From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH RFC 2/3] ASoC: hdmi-codec: add support for
	bclk_ratio
Date: Wed, 27 Feb 2019 11:47:47 +0000
Message-ID: <20190227114747.rjvkbewiloysdi3g@shell.armlinux.org.uk>
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
 by alsa1.perex.cz (Postfix) with ESMTPS id 9641EF806EE
 for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2019 12:48:07 +0100 (CET)
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
> I think there are other options too. The obvious one would be passing
> the blck_ratio callback trough HDMI-codec to HDMI-bridge-driver, but
> yes, I do not like that either.
> 
> The other would be changing the implicit bclk_ratio to 2 x sample-width,
> and accepting blck_ratios of 36 and 40 in tda998x, and set CTS_N_M = 3
> and CTS_N_K = 2 for them too.

To put a bit of further information out there...

I really don't like that idea - what if we have a transmitter that
really does use a bclk_ratio of 36 or 40?  That would mess up the
CTS calculation in the TDA998x.

The equation I've come up to fit what we know for TDA998x is:

	k = m * bclk_ratio / 128

where k and m are parameters that we values we select for TDA998x.
This reflects the entire clock regeneration system including the sink.
The possible values of k are 1, 2, 3, 4, or 8.  m are 1, 2, 4, or 8.
I also have this equation which defines the fs regenerated at the sink:

	fso = bclk_ratio * fsi * m / (128 * k)

If we did have a ratio of 36 or 40, the first equation above fails
since k is not one of the possible integers.  If we round down and use
e.g. 2 for the 36fs case, then we'd actually end up with a sample
frequency on the sink of 1.125x faster than it should be, and the sink
would suffer starvation of audio samples.  If we rounded up to 3, then
the sample frequency will be 3/4 of it's true value, so the sink will
overflow and would have to discard audio samples.

We know this happens, because that's the root of the problem at hand:
wrongly setting the m and k values for the bclk_ratio being supplied
to the TDA998x causes audio to be corrupted when reproduced by the
sink.

Given that, we do need some way to validate the bclk_ratio when it is
set, and not during hw_params which would (a) lead to ALSA devices
failing when userspace is negotiating the parameters and (b) gives no
way in the kernel for set_bclk_ratio() to discover whether a particular
ratio is supported by the codec.

So, I think there's three possible ways around this:
1. adding a set_bclk_ratio() method to hdmi_codec_ops
2. calling hw_params() when our set_bclk_ratio() method is called
   (what if the rest of the format isn't set or incompatible, which
   may cause the hw_params() method to fail?)
3. adding a list of acceptable bclk_ratio values to hdmi_codec_pdata

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
