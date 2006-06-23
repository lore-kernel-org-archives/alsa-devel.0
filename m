From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: snd-aoa: headphone detection wonky on PowerBook5, 4
Date: Fri, 23 Jun 2006 16:13:21 +0200
Message-ID: <1151072001.7608.27.camel@localhost>
References: <87lkrom70h.fsf@briny.internal.ondioline.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1565312928=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 03817175
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Jun 2006 16:14:23 +0200 (MEST)
In-Reply-To: <87lkrom70h.fsf@briny.internal.ondioline.org>
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


--===============1565312928==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-SgtNqa1ncF59Y8xZbQsq"


--=-SgtNqa1ncF59Y8xZbQsq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-06-23 at 21:43 +1000, Paul Collins wrote:
> Where "wonky" means: only unplugging is detected, not plugging.  I'm
> not sure why I didn't spot this earlier.  I dug down a bit with printk
> to discover that ftr_handle_notify_irq is being called only on unplug.
> And the interrupt count in /proc/interrupts increases only on unplug.

Heya, that's weird. But if the count in /proc/interrupts increases only
on unplug I probably have to reprogram the controller somehow.

johannes

--=-SgtNqa1ncF59Y8xZbQsq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARJv2/qVg1VMiehFYAQKpLA/9FImLLDgy4EUg/pcdI5y+UBRP8W7XKOwu
IKTEyFHgHesyJ1akqqaBmetCdBOFVTSsHwBmaOBjDr9DuHISkKBROJ1NPu4/UUve
ql2qoMxN7CYYbvB/WitbJ9wWX1sKkj3R3HD9RBN7VI25qFrA8OxLqbs0AHtOImSX
+vaDHQHJkWC2o9vi6dgL3J/WIccOoDhtd0UJKAnOFs2kem4Q1ObfIGabxjo2uRL2
xFJPrgMIf+RqqXdhhUnz2R9ZizVS2k6G11D6pWXkCR2mBB94FaPR7V3gEZvh9J5Y
vc6KBIGRDrW9zS0oPxBKO1PA0SY1bZTsB/sz08YC/7yjZLX9wx8g8IBfo/vVkq0k
Kl1auALe5QMqVJcwuG5tpWEfo2IIhqWdcFhX3Mt8UP1PJ8FUDhs0GyqRkuaWOEnC
Wni8fts4mq9CPdA80iKEo1xseRJ2n9TzhcDoql6r2zwcBLc+K9VG+2zSeiC+yyn/
7q8A/Av/uddBzHBdAJhXfZYhlg8QawCnmeHMkrE15HVDi+iKEQvSuliphPkobOoO
snqh97VnOyxwJP8Ma4ELO9yJD6TaWA7xB/sAP1FRCeoVD9S/XANwGXw6ErEtpg7m
CXe8luc54Cii6L7brEJm993+h+OX24A2RjjIZYaORUrL80F78I08nUnyCUPZL8KK
z5SEAI5WKNc=
=cxCN
-----END PGP SIGNATURE-----

--=-SgtNqa1ncF59Y8xZbQsq--



--===============1565312928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1565312928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1565312928==--
