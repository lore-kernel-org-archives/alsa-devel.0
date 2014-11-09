From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v3 2/2] ASoC: simple-card: add multi-CODECs
 in DT
Date: Sun, 9 Nov 2014 19:42:33 +0100
Message-ID: <20141109194233.66eae626@armhf>
References: <cover.1415096705.git.moinejf@free.fr>
	<53ef077d2174f8eb5b861d6cebe7c9e732f06d52.1415096705.git.moinejf@free.fr>
	<20141107123035.GO8509@sirena.org.uk>
	<20141107200557.78971e08@armhf>
	<545D2667.4070707@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <545D2667.4070707-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 07 Nov 2014 21:07:03 +0100
Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org> wrote:

> Casting const away is usually a sign that something is wrong and has =
the=20
> potential to result in undefined behavior. The correct fix in this ca=
se is=20
> probably to make the np argument for of_clk_get() const.

Thanks. I am sending a patch for that.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
