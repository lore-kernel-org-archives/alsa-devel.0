From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH RFC 2/3] ASoC: hdmi-codec: add support for
	bclk_ratio
Date: Mon, 25 Feb 2019 23:01:36 +0000
Message-ID: <20190225230136.ryni5bvqppggj6m2@shell.armlinux.org.uk>
References: <20190222212619.ghxly3eb6dx7p2ut@shell.armlinux.org.uk>
 <E1gxILm-0004MX-Kb@rmk-PC.armlinux.org.uk>
 <520b346f-a874-790d-61ec-fb4ac67ad046@ti.com>
 <20190225140334.uy3qf55u2jjk3ith@shell.armlinux.org.uk>
 <f48bdac0-06ea-03e6-8794-bfb547ec1ed5@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0DB5AF89661
 for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2019 00:01:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <f48bdac0-06ea-03e6-8794-bfb547ec1ed5@ti.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jyri Sarha <jsarha@ti.com>
Cc: Sven Van Asbroeck <thesven73@gmail.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 25, 2019 at 10:58:34PM +0200, Jyri Sarha wrote:
> On 25/02/2019 16:03, Russell King - ARM Linux admin wrote:
> > As mentioned in the commit message, this is what TDA998x does today,
> > and I have to assume that the contributor tested this, who seems to
> > be one Jyri Sarha in commit 95db3b255fde ("drm/i2c: tda998x: Improve
> > tda998x_configure_audio() audio related pdata").
> 
> Yes, my original implementation was a bit optimistic. I only had limited
> information about the chip and a somewhat working undocumented hackish
> driver implementation. By now it's clear that rejecting anything but
> 16-, 24-, or 32-bit sample widths (32, 48, or 64 bclk ratios) would have
> been right way to go.
> 
> > If we don't do it this way, then converting TDA998x to use this
> > defaulting would change the already established behaviour.  As there
> > are no users of this by hdmi-codec implementations, and as there are
> > no callers of snd_soc_dai_set_bclk_ratio(), the only way to maintain
> > the current behaviour in TDA998x is to either place a default in
> > hdmi-codec.c, or to have hdmi-codec.c pass zero into TDA998x and have
> > that encode the above.
> 
> I think there are other options too. The obvious one would be passing
> the blck_ratio callback trough HDMI-codec to HDMI-bridge-driver, but
> yes, I do not like that either.
> 
> The other would be changing the implicit bclk_ratio to 2 x sample-width,
> and accepting blck_ratios of 36 and 40 in tda998x, and set CTS_N_M = 3
> and CTS_N_K = 2 for them too.
> 
> This way my bad choices would not spread to all hdmi-codec users.
> 
> Then again, I don't think anyone is using 18- or 20-bit samples with
> tda998x. They most likely do not even work. So simply refusing the 36
> and 40 blck_ratios would probably be just fine too.

Another would be keepign the existing code with an additional
WARN_ON_ONCE(1) if invoked, which would have the effect of encouraging
drivers to be fixed up to call snd_soc_dai_set_bclk_ratio() - which has
surely to be a good thing?  However, the risk is that no one reports
the problem cases...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
