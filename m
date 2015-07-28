From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH v13 3/3] ASoC: tda998x: add a codec to the HDMI
 transmitter
Date: Tue, 28 Jul 2015 14:53:58 +0100
Message-ID: <20150728135358.GK7557@n2100.arm.linux.org.uk>
References: <cover.1437397270.git.moinejf@free.fr>
 <e036c88aa945e72b40ec965c9358dacf564e79f2.1437397272.git.moinejf@free.fr>
 <20150720180606.GL11162@sirena.org.uk>
 <20150728121945.560f82a5@armhf>
 <20150728102410.GD11162@sirena.org.uk>
 <20150728152329.02668865@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150728152329.02668865@armhf>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Jackson <Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 28, 2015 at 03:23:29PM +0200, Jean-Francois Moine wrote:
> The EDID arrives in the DRM connector when video starts. The built ELD
> may be stored either in the connector itself (default), in the encoder
> (TDA998x device) or in some DRM/encoder/connector private data.

The ELD is stored in the DRM connector, and there _should_ be a system
of locking which ensures that you can get at that information safely.

The ELD is only updated when the connector's get_modes() method is called,
and the driver itself calls drm_edid_to_eld().  This all happens under
the drm_device's struct_mutex.

So, to safely read the ELD from outside DRM, you need to take the top-level
drm_device's struct_mutex.  That could be fraught, as that's quite a big
lock, so an alternative would be to introduce an 'eld' lock to the driver,
which protects the call to drm_edid_to_eld() and the reading of the ELD.

However, that doesn't solve the problem of passing the data to an audio
driver.  What's needed there is a notification system which allows a video
driver to broadcast HDMI events such as:

* connected
* new EDID available
* new ELD available
* disconnected

With such a system, different components driving the facilities of a HDMI
connector can make decisions on what to do - which not only includes things
like the audio driver, but also a driver for the CEC interface (which also
needs to see the EDID to get at its "address".)  This can be done in a safe
manner as the HDMI video driver would have control over the generation of
these messages.

The point that Mark is trying to get you to see is that this problem is
not specific to TDA998x.  The same problem exists for many other HDMI
interfaces (except maybe Intel's i9x5/HDA stuff which has a hardware
mechanism of passing the ELD data from the video driver, through the
hardware to the audio driver.)

It needs solving in a driver-agnostic way, and the normal way that happens
is when someone comes along, wanting to add support in that area, they get
to do the hard work to propose that infrastructure.

> You may note that, in DRM, there is no relation between the encoder and
> the connector except at video startup time, and no relation between the
> DRM connector and the audio CODEC (no CODEC information is returned on
> CODEC creation and the CODEC has no private data).

In the case of the TDA998x, there is a 1:1 fixed relationship between the
connector and the encoder.  The connector part can't be used with any other
encoder, and the encoder part can't be used with any other connector.  The
same is true of many other HDMI implementations (such as the Synopsis
Designware HDMI interface found on iMX6 and Rockchip.)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
