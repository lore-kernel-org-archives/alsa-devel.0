From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH v3 4/4] ASoC: simple-card: Add DT documentation for
 multi-DAI links
Date: Wed, 19 Mar 2014 17:07:10 +0100
Message-ID: <20140319170710.19fc5a1d@armhf>
References: <cover.1394883134.git.moinejf@free.fr>
	<d054780a0edf4b2338a52e48bff9144e19aa614f.1394883134.git.moinejf@free.fr>
	<20140317164339.GR11706@sirena.org.uk>
	<20140318091728.1d2240ca@armhf>
	<53296CB7.1000909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53296CB7.1000909-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 19 Mar 2014 12:08:55 +0200
Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org> wrote:

> sound {
> 	compatible =3D "simple-audio-card";
> 	simple-audio-card,name =3D "Simple Audio";
> 	simple-audio-card,widgets =3D ...
> 	simple-audio-card,routing =3D ...
>=20
> 	simple-audio-card,dai-link@0 {		/* I2S - codec */
> 		format =3D "i2s";
> 		bitclock-master =3D "codec";
> 		frame-master =3D "codec";
> 		bitclock-inversion =3D <1>;
> 		simple-audio-card,cpu {
> 			sound-dai =3D <&audio1 0>;
> 			bitclock-inversion =3D <0>;
> 		};
> 		simple-audio-card,codec {
> 			sound-dai =3D <&codec 0>;
> 			system-clock-frequency =3D <12000000>;
> 		};
> 	};
> ...
>=20
> I can participate in the implementation too.

Thanks. I will prepare the multi DAI links and send you the first
patches.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
