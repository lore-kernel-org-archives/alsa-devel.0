From: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
Subject: Re: [PATCH v14 8/8] ASoC: sun4i-codec: Add Left Capture
 Select, Right Capture Select
Date: Sat, 5 May 2018 12:40:50 +0200
Message-ID: <20180505124050.66f74999@scratchpost.org>
References: <20180502210800.1971-1-dannym@scratchpost.org>
 <20180502210800.1971-9-dannym@scratchpost.org>
 <20180503145408.yymk2ndt4sm2yt4i@flea>
Reply-To: dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Exol.Wno/UhQybeCm87A+jH"; protocol="application/pgp-signature"
Return-path: <linux-sunxi+bncBCPKHTHNWIPBBOUUW3LQKGQERCLBTHI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20180503145408.yymk2ndt4sm2yt4i@flea>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Andrea Bondavalli <andrea.bondavalli74-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

--Sig_/Exol.Wno/UhQybeCm87A+jH
Content-Type: text/plain; charset="UTF-8"

Hi Maxime,

On Thu, 3 May 2018 16:54:08 +0200
Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org> wrote:

> > +static const char * const sun4i_codec_capture_source[] = {
> > +	"Line",
> > +	"FM",
> > +	"Mic1",
> > +	"Mic2",
> > +	"Mic1,Mic2",
> > +	"Mic1+Mic2",
> > +	"Output Mixer",
> > +	"Line,Mic1",
> > +};  
> 
> Shouldn't that be defined in a more generic way? As far as I know,
> there's no way to tell what the difference between "Mic1,Mic2" and
> "Mic1+Mic2" would be from the userspace.

Sounds good - but how?

Here, "Mic1,Mic2" means the left channel captured is Mic1 and the right
channel captured is Mic2.

On the other hand, "Mic1+Mic2" means that the signals from Mic1 and
Mic2 are added together and that is captured (both as left and as right).

"Mic1" means both the left channel and the right channel captured is
from Mic1.  Likewise "Mic2".
--Sig_/Exol.Wno/UhQybeCm87A+jH--
