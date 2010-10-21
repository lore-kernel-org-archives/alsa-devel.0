From: Valdis.Kletnieks@vt.edu
Subject: Re: HDA: no sound [was: mmotm 2010-10-20-15-01
	uploaded]
Date: Thu, 21 Oct 2010 17:24:24 -0400
Message-ID: <8089.1287696264@localhost>
References: <201010202233.o9KMXNoL008303@imap1.linux-foundation.org>
	<4CBFEE94.7020103@gmail.com> <s5hlj5sc7do.wl%tiwai@suse.de>
	<4CBFF25C.2080908@gmail.com> <s5hfww0c6oj.wl%tiwai@suse.de>
	<4CC085F5.9070905@gmail.com> <s5heibjxsi4.wl%tiwai@suse.de>
	<4CC092BC.9060504@gmail.com> <s5h8w1rxrl3.wl%tiwai@suse.de>
	<5220.1287692957@localhost> <s5h39rzclx3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7635452260022664261=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from turing-police.cc.vt.edu (turing-police.cc.vt.edu
	[128.173.14.107])
	by alsa0.perex.cz (Postfix) with ESMTP id 25473103ABD
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Oct 2010 23:24:25 +0200 (CEST)
In-Reply-To: Your message of "Thu, 21 Oct 2010 22:48:08 +0200."
	<s5h39rzclx3.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, mm-commits@vger.kernel.org, Jiri Slaby <jirislaby@gmail.com>, Colin Guthrie <gmane@colin.guthr.ie>, clemens@ladisch.de, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

--===============7635452260022664261==
Content-Type: multipart/signed; boundary="==_Exmh_1287696264_4908P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit

--==_Exmh_1287696264_4908P
Content-Type: text/plain; charset=us-ascii

On Thu, 21 Oct 2010 22:48:08 +0200, Takashi Iwai said:

> Yeah, if this is really the culprit, we should think of reverting the
> commit, at least until the use-space fix is more populated.

Am I allowed to NAK this commit till we get it sorted out? :)

> Well, this doesn't tell much...
> The fix patch for alsa-lib is pretty recent.  Attached below.

> commit 2f6206da0c1ff88235e6eca0077343f22a4b43ee
> Author: Clemens Ladisch <clemens@ladisch.de>
> Date:   Fri Oct 15 10:33:20 2010 +0200

That looks like a pretty self-contained patch, I should be able to build a
local test alsa-lib with that one added and see if it works with both old and
new kernels.  If I don't get a chance to do it tonight, won't be till Monday
I suspect, am booked solid with other stuff till then...


--==_Exmh_1287696264_4908P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFMwK+IcC3lWbTT17ARAgb/AJ9ImcrwMIbvtx2gJsQIJbCrbuA2ogCgi1aP
cuReq3Cijck0PyiOcdlPPl4=
=Ug3S
-----END PGP SIGNATURE-----

--==_Exmh_1287696264_4908P--

--===============7635452260022664261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7635452260022664261==--
