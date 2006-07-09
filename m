From: Stefan Smietanowski <stesmi@stesmi.com>
Subject: Re: [ATrpms-devel] build failures in asihpi
Date: Mon, 10 Jul 2006 00:44:32 +0200
Message-ID: <44B186D0.1010000__26537.1293215596$1152524890$gmane$org@stesmi.com>
References: <Pine.LNX.4.61.0606231231370.10283@tm8103-a.perex-int.cz>	<200607022100.58844.linux@blennerhassett.gen.nz>	<20060702123404.GI5158@neu.nirvana>	<200607101021.35954.linux@blennerhassett.gen.nz>
	<20060709223120.GE27639@neu.nirvana>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1717548506=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7FA73222
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Jul 2006 11:47:13 +0200 (MEST)
Received: from mxfep01.bredband.com (mxfep01.bredband.com [195.54.107.70])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	DAD1A99CCC for <alsa-devel@alsa-project.org>;
	Mon, 10 Jul 2006 00:44:36 +0200 (MEST)
In-Reply-To: <20060709223120.GE27639@neu.nirvana>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Axel Thimm <Axel.Thimm@atrpms.net>
Cc: Eliot Blennerhassett <linux@blennerhassett.gen.nz>, ALSA development <alsa-devel@alsa-project.org>, ATrpms development list <atrpms-devel@atrpms.net>
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============1717548506==
Content-Type: multipart/signed; micalg=pgp-ripemd160;
	protocol="application/pgp-signature";
	boundary="------------enigA1094F3DF778FFE6B77620DA"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA1094F3DF778FFE6B77620DA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Axel Thimm wrote:
> On Mon, Jul 10, 2006 at 10:21:35AM +1200, Eliot Blennerhassett wrote:
> 
>>On Mon, 03 Jul 2006 00:34, Axel Thimm wrote:
>>
>>>On Sun, Jul 02, 2006 at 09:00:58PM +1200, Eliot Blennerhassett wrote:
>>>
>>>>On Sun, 02 Jul 2006 11:17, Axel Thimm wrote:
>>>>
>>>>>I'm having troubles compiling this on x86_64 distributions (from
>>>>>2.6.10 to 2.6.17 based kernels). The build fails on asihpi...
>>>>
>>>>Currently asihpi does not support x86_64.     Sorry.
>>>>
>>>>The Kconfig for asihpi does say:
>>>>depends on SND && X86 && !X86_64
>>>>(hmm, perhaps the ordinary make system doesn't know about this)
>>>
>>>You mean asihpi uses some next generation Kconfig?
>>
>>No, just ordinary Kconfig.
>>
>>
>>>So how do I turn asihpi off?
>>
>>AFAIK the "depends on SND && X86 && !X86_64"  should result in asihpi not 
>>being built on x86_64.   Have you figured out why this doesn't work?
> 
> 
> No.

Try "depends on SND && X86_32" which sounds like what you're after
really. The X86 && !X86_64 could be what's confusing.

X86 == 32 or 64bit.
X86_32 = 32bit
X86_64 = 64bit

// Stefan

--------------enigA1094F3DF778FFE6B77620DA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEsYbTBrn2kJu9P78RA5/RAJ0WQHx0eruB+txwaNxooR+I0dsI5ACfetIO
/HXivd14WQtVle+HKIm4lIo=
=FNnM
-----END PGP SIGNATURE-----

--------------enigA1094F3DF778FFE6B77620DA--


--===============1717548506==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

--===============1717548506==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1717548506==--
