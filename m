From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH v2 5/8] ASoC: Move SigmaDSP firmware loader
	to ASoC
Date: Thu, 24 Nov 2011 12:31:04 -0500
Message-ID: <201111241231.06356.vapier@gentoo.org>
References: <1322138908-32127-5-git-send-email-lars@metafoo.de>
	<1322140516-16183-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5244191757153251564=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 161A8103E4C
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 18:30:56 +0100 (CET)
In-Reply-To: <1322140516-16183-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: drivers@analog.com, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

--===============5244191757153251564==
Content-Type: multipart/signed;
  boundary="nextPart3753826.J6Go0PlZ96";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3753826.J6Go0PlZ96
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thursday 24 November 2011 08:15:16 Lars-Peter Clausen wrote:
> It has been pointed out previously, that the firmware subsystem is not the
> right place for the SigmaDSP firmware loader. Furthermore the SigmaDSP is
> currently only used in audio products and we are aiming for better
> integration into the ASoC framework in the future, with support for ALSA
> controls for firmware parameters and support dynamic power management as
> well. So the natural choice for the SigmaDSP firmware loader is the ASoC
> subsystem.

Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike

--nextPart3753826.J6Go0PlZ96
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJOzn9aAAoJEEFjO5/oN/WBK2IP/0JM7gV95Yrmh1qoXf808JQd
kZPTCkZrUdeae5l+J7NTJmGRTTeNB38jtfkfE92AIZlJRBTrqIkj3YZO2OT8RYUn
Wb+lsFrt1x9833ivbbT2gwsGlAF0uyVMW5LFgLcB9p+R4qze6BT/YIRORZYue33q
fMW1LqBgCtHhMK1l50MO/pVyxkkZ9lry8xuXBxbha6Id/wSbrbzZcmkytSVV+jqx
EV47jWOtQup9/PZaCJrEkTjo/69tqdZMd/1yoXDIJiZiHYSZpR1oPAiFpOPTa+OC
zZ32PZTaF1vOn01Orqdgc/kDbKq0XxKXnCUvSbM1er6zqbeF+bi2OlP2JMckwoGl
eo5rPyox0oaz2RLGbwukCpoAEzVgH5WJGCwecxeaUcqgiA8nS0tq0MpQenYVzolg
dCbLiaJdgaS31edOOyFk2Szp/il6/QG+H4lIvPBjx7Uknhirj+MACZNfGDbMMiwQ
GVLGrmJBXVslQh0xKmzHyJ8fr47Vk5TBBSkaa7hKkXEEh3A8js2/Fa04tc5B4dHi
WWkVx4mNNnmDv50cPnWr98b8Ss+T+bgSZt0TQXXzsxWOv/bbyCL8tDdRqAd49dkh
4Ve9Bjx75dwbSDjH0pYofWW3YItPrmEluWIvOrk7uMMpePqRgRxOjfJ0WNChEkZ2
xlFdYp+sD1iIINBAxDy3
=tzOr
-----END PGP SIGNATURE-----

--nextPart3753826.J6Go0PlZ96--

--===============5244191757153251564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5244191757153251564==--
