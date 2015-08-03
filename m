From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH v14 1/3] drm/i2c: tda998x: Add support of a DT graph of
 ports
Date: Mon, 3 Aug 2015 19:06:35 +0100
Message-ID: <20150803180635.GJ7557@n2100.arm.linux.org.uk>
References: <cover.1438076750.git.moinejf@free.fr>
 <fb313682b8d14e16565fc317b7f5a249748c069f.1438076750.git.moinejf@free.fr>
 <55BF8111.4080905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55BF8111.4080905-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Jackson <Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 03, 2015 at 05:56:17PM +0300, Jyri Sarha wrote:
> On 05/08/15 11:18, Jean-Francois Moine wrote:
> >Two kinds of ports may be declared in a DT graph of ports: video and audio.
> >This patch accepts the port value from a video port as an alternative
> >to the video-ports property.
> >It also accepts audio ports in the case the transmitter is not used as
> >a slave encoder.
> >The new file include/sound/tda998x.h prepares to the definition of
> >a tda998x CODEC.
> >
> >Signed-off-by: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
> >---
> >  .../devicetree/bindings/drm/i2c/tda998x.txt        | 51 ++++++++++++
> >  drivers/gpu/drm/i2c/tda998x_drv.c                  | 90 +++++++++++++++++++---
> >  include/sound/tda998x.h                            |  8 ++
> >  3 files changed, 140 insertions(+), 9 deletions(-)
> >  create mode 100644 include/sound/tda998x.h
> >
> >diff --git a/Documentation/devicetree/bindings/drm/i2c/tda998x.txt b/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
> >index e9e4bce..35f6a80 100644
> >--- a/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
> >+++ b/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
> >@@ -16,6 +16,35 @@ Optional properties:
> >
> >    - video-ports: 24 bits value which defines how the video controller
> >  	output is wired to the TDA998x input - default: <0x230145>
> >+	This property is not used when ports are defined.
> >+
> >+Optional nodes:
> >+
> >+  - port: up to three ports.
> >+	The ports are defined according to [1].
> >+
> >+    Video port.
> >+	There may be only one video port.
> >+	This one must contain the following property:
> >+
> >+	- port-type: must be "rgb"
> >+
> >+	and may contain the optional property:
> >+
> >+	- reg: 24 bits value which defines how the video controller
> >+		output is wired to the TDA998x input (video pins)
> >+		When absent, the default value is <0x230145>.
> 
> Using reg property for something else than for address of some kind seems
> confusing to me. Should we just add an explicit property rgb mapping?

It's what ePAPR requires.

The problem is when you have multiple nodes called the same thing, you
need to add the @number suffix to the name, and if you do that, ePAPR
says you must also have a reg property, where the reg property matches
the number given after the @.

See https://www.power.org/wp-content/uploads/2012/06/Power_ePAPR_APPROVED_v1.1.pdf
page 15, 2.2.1 "Node names".

> Here I do not even understand what what the values 3 ad 4 stand for.

It's the audio input pin number (which is a sort-of bus address.)

> Anyway having some clearly defined property that explicitly defines the
> audio pins would make more sense to me. Even if that is not possible due
> lack of proper documentation it would be better not add to the confusion by
> unusual usage of reg property.

As ePAPR requires the reg= property with the @unit-address part, this is
the most sane approach.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
