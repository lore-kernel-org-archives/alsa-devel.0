From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: snd-aoa: headphone detection fix
Date: Tue, 27 Jun 2006 19:43:00 +0200
Message-ID: <1151430180.597.27.camel@localhost>
References: <87d5cuhq9j.fsf@briny.internal.ondioline.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0328344871=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6224E26F
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jun 2006 19:44:21 +0200 (MEST)
In-Reply-To: <87d5cuhq9j.fsf@briny.internal.ondioline.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Paul Collins <paul@briny.ondioline.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0328344871==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-MXiYBMEeixCK8D47SWBt"


--=-MXiYBMEeixCK8D47SWBt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

> I took a look at tumbler.c and after it requests the headphone or
> lineout detection IRQ it sets a bit in the associated GPIO register.
> I added some code to snd-aoa to do something similar and now I get
> interrupts both on plug and unplug.  Three each time, in fact.
> (I don't remember if this used to happen with snd-powermac.)

Nice detective work :) Unfortunately my mail server had crashed or you'd
have gotten a patch for this already, but I'm fairly sure that mine is
correct too. Would you try please?

johannes

--=-MXiYBMEeixCK8D47SWBt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARKFuIqVg1VMiehFYAQKnhw/+MWk89ZeXycrKGyGjnQzgAeRfCWx7ufTM
RVm64LRE49d03UYzjIoS49nPnQM4MLveRR/z7sODR/+1v1mNu7XWBKL6B2fUUNfY
aSSQoGZ5iqNZdAmd+wGI9lnK2grJO+81ys07RO5J5VVQsy/OYau079yMZPN+ovDF
eSGDPa5L0f8SW+IknDc0KhmuUDiuXliEXvZ44H0yZf77gQyRGODY7MD94/CZOkev
GNJZjZypH4BxfaHNSI8OG4D97iwlYNk+HPmzQ/GNXW1pochm6rJOMe9rdCcOtUzC
Aq6H5udL2shzw1s+r5HyEY9+knV+3swiB3o/IX4qyLR4bBylqdgTzZAq/pbSJlFQ
Aip/WZVKKHoktfKzP/lpfMSHBM5H6eE6VWmTE2DYFDvJDVQ7u+sWP/6czSxvkmcV
hn3Tzpt+R3nKNP97lyQ4/klCBzSUdiHu3CoO2HZhTwDHc8UaOCYxG+5hQERkzPp+
92cStuPHk0LdFM/Fvz/Cqw3yVB6Bw0WiZceCRA0fnqqA039aZi6yNoEE+A9dSgWf
ePmhwI0aWaaDdBKmK1tx9A6QwsSK9Ni1m9fODimw3V7TF+jUUFD99BQIDVtujssN
n98gRYF4zS8m+0/cd7SW9UQ69UknHImzTso6z/49LbU8kTAUoQQ1x1kcNjvKKP/j
ZppgQQLsO70=
=yV8d
-----END PGP SIGNATURE-----

--=-MXiYBMEeixCK8D47SWBt--



--===============0328344871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0328344871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0328344871==--
