From: Breno Leitao <leitao@debian.org>
Subject: powerpc64 workaround
Date: Mon, 20 Feb 2017 16:32:35 -0300
Message-ID: <20170220193234.GA10305@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6283108456572564192=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f176.google.com (mail-qk0-f176.google.com
 [209.85.220.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C050266917
 for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2017 20:32:41 +0100 (CET)
Received: by mail-qk0-f176.google.com with SMTP id x71so38141226qkb.3
 for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2017 11:32:41 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6283108456572564192==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Takashi,

Fourteen years ago you commited a patch in alsa-libs entitled "added
workaround for ppc64." and I am curious about it.  What is this
workaround for? Is this still needed?

Currently it seems to be causing some issues on ppc64le (ABI v2) when
building this package, and we are reverting it downstream in order to
avoid FTBFS on alsa-libs:=20

https://github.com/alpinelinux/aports/pull/911

https://github.com/buildroot/buildroot/blob/master/package/alsa-lib/0005-re=
move-powerpc64-workaround.patch

Anyway, do you think it is still important?

Thank you,
Breno

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJYq0RSAAoJEDWjk5/8eHdtYDYP/2BLcpPjzcsMUL91776eazpb
WZdG1qSTaTW0eq+QQnaR6KN1lvbsT9pj/389K+4dZHyseFLeIGIXDpEPv+gYvVq5
wrQOYm2r/l/JUrnJFLN+m3McRIVI6Hh+03AX5H8vqKX+vG0jTGs4kaeu826ky2E5
dfq13042NtbQTj/0qs6KuWbZuhjwYzxX5EPtelxIELNl8/tXuJ+WTB+S3OaxZ0+U
y8Gel/mFAVnw/x9nfeCxPhLpsEogDwcOKg1dWzvDskK/ynVDBRYpq2vLB6jjbmOs
8shuR3NaxIn25a/ftyEaHnh4brM4tsIGVrOLVQPd7+2ULQEidC+2+hV4hc03xQry
bpvt1Fugw0oqFMEI2VeDxKyquPbdDW91RT/iXT3jIZXoetNwyIRqxBFTbzZdg31E
F8N/4AwjmOo7PZrhn9fhtTYEKxL+lBIWVZO9zpgDF1b5c9LXQvOG781huzA0Yxaw
m4RIp+IU8tWsmmClCZm8UUD+nWrRiTJpEK14xVQToPmN/+Anv6LteYA/aLMJAosQ
76TSV+uUQ4wBB2btLPv8WkA9JByO5reZuoxXXFSJtxkptFb9oeF6WYLfge83Dwje
5XSHjyM+7FWg2VvGwPjYgNOT5xUGFO9rXVjJzpHH+x0gK9auqvSVNQYwubCnvVol
r6CTfyhZTNbyywOdJXXS
=ltvc
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--

--===============6283108456572564192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6283108456572564192==--
