From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH v13 3/3] ASoC: tda998x: add a codec to the HDMI
 transmitter
Date: Tue, 28 Jul 2015 16:06:28 +0100
Message-ID: <20150728150628.GM7557@n2100.arm.linux.org.uk>
References: <cover.1437397270.git.moinejf@free.fr>
 <e036c88aa945e72b40ec965c9358dacf564e79f2.1437397272.git.moinejf@free.fr>
 <20150720180606.GL11162@sirena.org.uk>
 <20150728121945.560f82a5@armhf>
 <20150728102410.GD11162@sirena.org.uk>
 <20150728152329.02668865@armhf>
 <20150728135358.GK7557@n2100.arm.linux.org.uk>
 <20150728163912.71789e31@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150728163912.71789e31@armhf>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Jackson <Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 28, 2015 at 04:39:12PM +0200, Jean-Francois Moine wrote:
> On Tue, 28 Jul 2015 14:53:58 +0100
> Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
> > In the case of the TDA998x, there is a 1:1 fixed relationship between the
> > connector and the encoder.  The connector part can't be used with any other
> > encoder, and the encoder part can't be used with any other connector.  The
> > same is true of many other HDMI implementations (such as the Synopsis
> > Designware HDMI interface found on iMX6 and Rockchip.)
> 
> But there is no direct link (pointer) between the encoder and the
> connector.

There's no direct link from an encoder to a connector because the DRM
model allows a single encoder to be associated with multiple connectors.
Adding a link from the encoder to a connector breaks that ability (an
encoder would then need an array of connectors.)

If we kill the old drm_slave_encoder support in TDA998x, then this would
solve the problem - we can then get at the TDA998x's drm_connector easily
as it then becomes part of TDA998x's private data.

However, this doesn't matter.  All that we need from the DRM side of the
TDA998x is to know is the EDID or ELD.  That can be broadcast via a
notification (using something like the code I illustrated in a follow up
email) to any listeners, whether they be an audio driver or a CEC bus
driver.  The audio driver may not care about HDMI connect/disconnect
events, but that's no reason not to include them.  Some consumers of
these events need to know (CEC certainly needs to know.)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
