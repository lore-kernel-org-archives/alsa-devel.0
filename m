From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: all-modular snd-aoa
Date: Fri, 23 Jun 2006 16:36:30 +0200
Message-ID: <1151073390.7608.38.camel@localhost>
References: <87hd2cz116.fsf@briny.internal.ondioline.org>
	<1151072095.7608.29.camel@localhost>  <s5h7j389c7d.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1639004770=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0E70222C
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Jun 2006 16:36:44 +0200 (MEST)
In-Reply-To: <s5h7j389c7d.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Paul Collins <paul@briny.ondioline.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============1639004770==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-BvOkEEGaCVOxmNY8zb4J"


--=-BvOkEEGaCVOxmNY8zb4J
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-06-23 at 16:30 +0200, Takashi Iwai wrote:

> Where is the problem in Makefile?  It looks OK to me...

Well, the problem is the fact the snd-aoa/ dir contains nothing to be
compiled and the kernel Makefiles don't like that.

> Nevertheless, aoa/Kconfig has a wrong dependency on SND_PCM.

Good point. Committing to my repository, how should we process things
like that now? Should I post some patches once a while or do you want to
commit that right away?

johannes

--=-BvOkEEGaCVOxmNY8zb4J
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARJv8bKVg1VMiehFYAQK0LA//bdVVvIqMvjLvCx+hnzpQiM1PWmPweTVv
GbajoPjEOWatE3LXSFhdOnSXPY24H5gDbBaFrO9XnrASCOp/r9pVvtEqHpP8M9kb
o8tdt1AE/oEOpk/sdGgJHb/29nU502zlgBW3NaZDnh5H06aAhLSoeLO5q8rmmmEC
kNzQpzzmQzIAPYtyhUe3kFm5eYSAyDa2a3+Cj4uoTSejPqlyeJaw/bKdI9vO7IUG
+r+RMaM5xGUBZ7FgLn/TUWq237qmFTize0eiFJYcFWDU08SCgA28OmjYeih3J/EJ
ZU+fMIvtdp8/C9q4fbMOhZkj1og1Oa9wIcwD9qScnh/me/HwzcPyBLI3oQtfF1Hw
rJdn4K9PHYhIMRm9j42FQwfy4KSBpRGk32pMWvnEBKAY8iAjrYjeB3ErXzqRMXfR
TpREKQUzYENyp3gkJNI/ndQXXBCjYU4NnflbZPhSNhZdvL5hXyZqL6KsuriUy/3N
X2bh95DezDUj3DEvevN6CGiB6Uzk7dZuhAkQ+KgyKbRzWCqvkpl+RMXMVV/ZVsiK
5MMdAyWYvv6uYi0oi7PYKSfAyi4i9ZFD13LggDUb4QG7lwVGKqzBX0USMOJ2Fk0/
dB86LCK0P/q5I4DvNXUfwuuHH/UFtlcrCC3pheY8mYxtBuN1IA8jxRo+iA0T2lEr
tpV8ZZEClH8=
=OvP7
-----END PGP SIGNATURE-----

--=-BvOkEEGaCVOxmNY8zb4J--



--===============1639004770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1639004770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1639004770==--
