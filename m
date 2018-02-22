From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 02/11] ASoC: rt5651: Remove
 is_sys_clk_from_pll, it has ordering issues
Date: Thu, 22 Feb 2018 12:00:35 +0100
Message-ID: <1af26369-fc76-8862-86bf-f554c3559a41@redhat.com>
References: <20180220221511.22861-1-hdegoede@redhat.com>
 <20180220221511.22861-2-hdegoede@redhat.com>
 <20180221111821.GA8334@sirena.org.uk>
 <7c0a41b1-6765-13e6-be96-b354c744ba29@redhat.com>
 <20180222104816.GA5905@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f181.google.com (mail-wr0-f181.google.com
 [209.85.128.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 10AEA2675F4
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 12:00:37 +0100 (CET)
Received: by mail-wr0-f181.google.com with SMTP id u15so10119357wrg.3
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 03:00:37 -0800 (PST)
In-Reply-To: <20180222104816.GA5905@sirena.org.uk>
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

On 22-02-18 11:48, Mark Brown wrote:
> On Wed, Feb 21, 2018 at 08:38:01PM +0100, Hans de Goede wrote:
>> On 21-02-18 12:18, Mark Brown wrote:
>>> On Tue, Feb 20, 2018 at 11:15:02PM +0100, Hans de Goede wrote:
> 
>>> Only if jack detection is enabled, if jack detection is not in use for
>>> some reason then the PLL isn't required and should be powered off - this
>>> is normally handled by having the jack detection code force enable
>>> things.
> 
>> As the commit message tries to explain, the code this removes is fundamentally
>> broken and this is not jack-detection related:
> 
>>     "dapm_power_widgets() first builds a list of which widgets to power-up
>>      before actually powering any of them up. For dapm-supply widgets their
>>      connected method, in our case is_sys_clk_from_pll() get called at this
>>      point.
> 
>>      Before this commit is_sys_clk_from_pll() was looking at the actually
>>      selected clock in the RT5651_GBL_CLK register. But the sysclk itself is
>>      selected by another dapm-supply (the "Platform Clock" supply in the
>>      machine driver) and any changes to that supply part of the same power-
>>      transition get executed after building the list, causing
>>      is_sys_clk_from_pll() to return the wrong value."
> 

> Right, but there's a couple of jumps in your reasoning with the actual
> solution.
> 
>> As for that the PLL should be powered-off when not needed, I agree but that
>> is controlled by the machine-driver through the "Platform Clock" dapm supply
>> and if that leaves things on for some reason then that is the problem which
>> we actually need to fix, e.g. this will also leave the MCLK input clk enabled
>> needlessly.
> 
> I don't follow this bit, sorry.  If there's a DAPM supply that's being
> enabled when it's not needed then we should just disable it.

Right, that is exactly what I'm saying too.

Whether we use PLL1 as sys-clk or the RCCLK is controlled by the
"Platform Clock" dapm supply. If we proper disable that supply when we don't
need PLL1, then it will switch to RCCLK and we can simply have
rt5651_set_dai_sysclk() enable / disable the PLL pwr bit in PWR_ANLG2 when
we switch clock rather then using the is_sys_clk_from_pll() check.

I hope this helps clear up the confusion surrounding this patch. And I guess
I need to improve the commit message...

Regards,

Hans
