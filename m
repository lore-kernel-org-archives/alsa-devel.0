From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH 07/11] ASoC: tegra: Add tegra-das driver
Date: Wed, 5 Jan 2011 14:58:02 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310567AAE@HQMAIL01.nvidia.com>
References: <1292622090-21896-1-git-send-email-swarren@nvidia.com>
	<1292622090-21896-8-git-send-email-swarren@nvidia.com>
	<20101217220029.GD25609@sirena.org.uk>
	<74CDBE0F657A3D45AFBB94109FB122FF030FD78D90@HQMAIL01.nvidia.com>
	<20101222201118.GA8167@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C0382442F
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2011 23:58:17 +0100 (CET)
In-Reply-To: <20101222201118.GA8167@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Wed, Dec 22, 2010 at 10:30:15AM -0800, Stephen Warren wrote:
> > Mark Brown wrote:
> 
> > > Reading this it's essentially just exporting point to point switches
> > > within the DAS block.  This really feels like it ought to be represented
> > > as a CODEC driver to give runtime flexibility to userspace to control
> > > the mux - it looks like the AP part of the system streams data into this
> > > block which then has very flexible switching on to the externally
> > > connected audio devices.
> 
> > Hmm. I don't see any examples of anything like Tegra's DAS in the existing
> > ASoC code-base. So, I'm slightly unsure how to recast the DAS driver as
> > a codec. In particular, in the machine driver, would I do something like:
> 
> The closest thing in the tree at the minute is WM8994 and WM8995 - both
> of these have multiple audio interfaces plus a DAC/ADC/DMIC block
> connected together via a digital mixing block.
> 
> > static struct snd_soc_dai_link *harmony_links[] = {
> > 	& harmony_i2s_das_link,
> > 	& harmony_das_wm8903_link,
> > };
> 
> Essentially, yes.
> 
> > Wouldn't that end up exposing two streams to user-space, one for each entry
> > in harmony_links[]?
> 
> Yeah, that's the unfortunate bit - it doesn't work ideally well right
> now.  We actually need to take care of this anyway (it's also an issue
> for things like phones as you get the same structure for the link
> between a digital baseband and the CODEC it's connected to) and
> something like this that really strongly benefits from the feature would
> be a good thing to use to get that working.
> 
> I guess for now setting up a 1:1 mapping between the CPU DAIs and the
> physical ports would get the CPU driver going, then I can do the
> framework work required to make sure DAPM propagates nicely over the
> mux.  Does that sound reasonable?

So I'm clear, I'm interpreting that as meaning the existing tegra_das.c
driver that I sent to the list is acceptable for now. Then, once that's
merged in, we can add in the infra-structure to recast it as a codec/...
Or, were you asking for some kind of structural change?

Thanks.

-- 
nvpublic
