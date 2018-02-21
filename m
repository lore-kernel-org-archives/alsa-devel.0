From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 02/11] ASoC: rt5651: Remove
 is_sys_clk_from_pll, it has ordering issues
Date: Wed, 21 Feb 2018 20:38:01 +0100
Message-ID: <7c0a41b1-6765-13e6-be96-b354c744ba29@redhat.com>
References: <20180220221511.22861-1-hdegoede@redhat.com>
 <20180220221511.22861-2-hdegoede@redhat.com>
 <20180221111821.GA8334@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f170.google.com (mail-wr0-f170.google.com
 [209.85.128.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 25167267046
 for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2018 20:38:03 +0100 (CET)
Received: by mail-wr0-f170.google.com with SMTP id 34so7700905wre.13
 for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2018 11:38:03 -0800 (PST)
In-Reply-To: <20180221111821.GA8334@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 21-02-18 12:18, Mark Brown wrote:
> On Tue, Feb 20, 2018 at 11:15:02PM +0100, Hans de Goede wrote:
> 
>> TL;DR: The PLL1-supply must always be powered up when PLL1 is the sysclk
>> source and we can simply set the RT5651_PWR_PLL bit when selecting PLL1.
> 
> Only if jack detection is enabled, if jack detection is not in use for
> some reason then the PLL isn't required and should be powered off - this
> is normally handled by having the jack detection code force enable
> things.

As the commit message tries to explain, the code this removes is fundamentally
broken and this is not jack-detection related:

    "dapm_power_widgets() first builds a list of which widgets to power-up
     before actually powering any of them up. For dapm-supply widgets their
     connected method, in our case is_sys_clk_from_pll() get called at this
     point.

     Before this commit is_sys_clk_from_pll() was looking at the actually
     selected clock in the RT5651_GBL_CLK register. But the sysclk itself is
     selected by another dapm-supply (the "Platform Clock" supply in the
     machine driver) and any changes to that supply part of the same power-
     transition get executed after building the list, causing
     is_sys_clk_from_pll() to return the wrong value."

I actually wrote this patch for the rt5640 driver first (but my rt5640
work / patch-series is not finished yet). I saw the following problem
on rt5640 boards before even introducing jack-detect:

1) Have a generic UCM file
2) Start recording
3) Select an input which is not part of the input-map quirk in the machine driver
4) Switch to an input which is part of the input-map
5) Notice how only silence is recorded
6) Use i2c-get to get the PWR_ANLG2 register, observe that the PLL-bit is OFF at
    this point despite a stream being recorded due to the ordering issues
7) Use i2c-get to get the GLB_CLK register notice that it does point to PLL1,
    so is_sys_clk_from_pll() will return 1 if called *NOW*, but clearly it
    returned 0 when called as proven by 6) which shows the ordering issue is real
8) Use i2c-set to enable the PLL-bit in PWR_ANLG2 and the recording starts working

As I tried to explain in the commit message the is_sys_clk_from_pll() thingie
simply can NOT work because it should check for what the GLB_CLK register will
be *after* the dapm transaction / transition but in reality it checks for what it
was *before* the transition, which means that it will only return the right thing
if 2 transitions are made in a row where the second transition preserves the
GLB_CLK value of the first.

As for that the PLL should be powered-off when not needed, I agree but that
is controlled by the machine-driver through the "Platform Clock" dapm supply
and if that leaves things on for some reason then that is the problem which
we actually need to fix, e.g. this will also leave the MCLK input clk enabled
needlessly.

I really don't see how configuring a broken sysclk (GBL_CLK points to PLL1,
but PLL-bit in PWR_ANLG2 is OFF) is ever a good thing, instead we should make
sure we always switch to the RCCLK when we don't need the SYSCLK.

Last force-enabling the PLL bit on all machines where we can do jack-detection
(not only over-current, but the JD irq in general needs a valid sysclk) would
in practice mean always force-enabling the PLL bit since almost all boards have
jack-detection once we add the necessary quirks, so this really is not a solution.

Regards,

Hans
