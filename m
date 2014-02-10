From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] sound: soc: codecs: Add es8328 codec
Date: Mon, 10 Feb 2014 14:27:52 +0000
Message-ID: <20140210142752.GM1757@sirena.org.uk>
References: <1391749517-11787-1-git-send-email-xobs@kosagi.com>
 <1391749517-11787-2-git-send-email-xobs@kosagi.com>
 <20140207181238.GL1757@sirena.org.uk>
 <52F89ADF.8020305@kosagi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XZn3P0VKTizxZG2b"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52F89ADF.8020305-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--XZn3P0VKTizxZG2b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 10, 2014 at 05:24:47PM +0800, Sean Cross wrote:
> On 8/2/14 2:12 AM, Mark Brown wrote:

> > In general this looks like it should be making much more use of the
> > framework rather than open coding, it looks like it's very much hard
> > coded for one use cae.

> I've tried to simplify the code somewhat, but I'm still unclear about
> how much of the DAPM code functions.  I'm running into two problems:
> Mapping the codec names "OUT1" and "OUT2" onto "Speaker" and "Headphone"
> respectively, and accommodating this codec's one DAC / two outputs
> architecture.

Describe the hardware accurately.  If the hardware has outputs called
OUT1 and OUT2 that aren't fixed function in some way then describe them
like that, if the CODEC has routing control just describe the routing
control.

> First, this particular codec doesn't specify what the outputs are used
> for, it only specifies the names OUT1 and OUT2.  It is permitted to
> connect either a speaker or headphones to either output.  In the initial
> patch, I hardcoded OUT1 to be named "Speaker", and OUT2 to "Headphone".
>  However, I've genericised the codec and changed them back to "OUT1" and
> "OUT2".  Inthe board definition I've added DAPM routes that map
> "Speaker" and "Headphone" back onto these names.  amixer still shows
> OUT1 and OUT2.

Good.

> There seems to be some overlap between DAPM and kcontrols.  How can I
> specify in the board definition file that OUT1 should have a kcontrol
> named "Speaker" and OUT2 should be named "Headphone"?  Tracing shows
> that DAPM at least recognizes the naming: e.g. "snd_soc_dapm_input_path:
> *Speaker <- (direct) <- ROUT1"

You can't, do this in your userspace configuration - UCM contains tools
to help do remapping if you are using raw ALSA.  Or extend the in kernel
frameworks but that's probably more trouble than it's worth and it's not
clear it's even a good idea to have the complexity in kernel.

> Second, I'm having trouble getting the DAPM routing to function
> properly.  There is one DAC that routes to two outputs, OUT1 and OUT2.
> Both OUT1 and OUT2 have their own volume controls as well, but the main
> state machine and amplification comes from the DAC.  This doesn't seem
> to be very common.  Are there any codecs I can use as an example that
> have one DAC routing to two outputs?

That's really common - the overwhelming majority of CODECs have such a
design if they have multiple outputs.  Could you articulate what's
unclear here?

--XZn3P0VKTizxZG2b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS+OHlAAoJELSic+t+oim9uYsQAIusnApulj+qkYXQgVrm90lP
ahJSyg96cn9ciytr0gcq1Tem/ze4O1jZR9mY9zePBASGQ7WuX5apt3g09ykn/WMe
nT5iWGAHyUs33+n7GZ68NGGAW0qrpwqjAvqhDrCvzgpp7jbGhao9SG/qKdQMnZbv
PiNN1UEkp6YYumYjWvUqk0rka/UIr3nvQxySX9km4wa4/GuEh8mV2CTlvsddmZqU
tRdnsMXP7odDeFun+Y3G64W2ysAPvJAMfugKoRBtqdUVTiFl+rECa/DLBD6Z5psJ
+5WLaqTwtZ+590kpsg5L6wSa5eSE0Q3Yxpwi5AZSoe19zbKUC/GnSqRuIyP23SxZ
a+FI12WUBhgyFmpRklmZnRAYvqIXTjNBy5cqmCNxIcrwriTyYsFtahUMM0C3UQvx
k8lcFFiAAgGS0yh7LYDpaeXSAKfHRtrakAutndWfLvpHcvFg5W1zAqHPHCFt2JkF
YwUrIVui2yI9ffGLLUYsdulBmZ5VfJMa/4T0XWBtkcjAR6eKCyLcdhV9qyr00vMh
lIOLUVsTCAAVmleSNJFIcTpBZHQRNAJKzKVI2w7yqIpwoXqDDGb7wJ9PsDHi0csC
+65O3yiFO00xVNtmOa8UHgFwnKS/7RtLfRsWIkQsjDuFhFqzGYoFfEgV9Zxks1n3
j0uwe525eFZrzZpeDe8T
=YWWB
-----END PGP SIGNATURE-----

--XZn3P0VKTizxZG2b--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
