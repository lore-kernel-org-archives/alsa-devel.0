From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH] ASoC: kirkwood: add S/PDIF support
Date: Tue, 24 Sep 2013 18:32:41 +0200
Message-ID: <20130924183241.12a97af4@armhf>
References: <20130924124122.64834b2a@armhf>
	<20130924105127.GB12758@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130924105127.GB12758-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue, 24 Sep 2013 11:51:27 +0100
Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:

> On Tue, Sep 24, 2013 at 12:41:22PM +0200, Jean-Francois Moine wrote:
> > This patch adds S/PDIF input/output for mvebu DT boards.
> >=20
> > Signed-off-by: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
>=20
> Right, so if this goes in, then we're completely fucked for doing thi=
s
> the way that Mark apparantly wants it to be done, because once these
> DT properties go in, they're there to stay.

Indeed!

The DT properties I propose just reflect the hardware connections of
the board. There are only i2s-out and spdif-out in the Cubox, while
there may be kirkwood boards with, say, only spdif-in and spdif-out.

These definitions do not interfere with your DPCM problem: you assume
i2s-out and spdif-out for the i2s1 dove device, and that is what I
assume too, but from the DT. Then, the driver does not need to know the
type of the audio device (Kirkwood or Dove), nor to know if it is the
first or the second i2s device of the Dove chip.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
