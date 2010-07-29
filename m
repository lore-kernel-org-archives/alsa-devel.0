From: Valdis.Kletnieks@vt.edu
Subject: Re: mmotm 2010-07-27 - hda-intel audio fails to
	initialize
Date: Thu, 29 Jul 2010 12:05:27 -0400
Message-ID: <6177.1280419527@localhost>
References: <201007272226.o6RMQRBm008735@imap1.linux-foundation.org>
	<22094.1280355787@localhost> <s5hhbjialvv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5219381412329817983=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lennier.cc.vt.edu (lennier.cc.vt.edu [198.82.162.213])
	by alsa0.perex.cz (Postfix) with ESMTP id 583892445B
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jul 2010 18:05:31 +0200 (CEST)
In-Reply-To: Your message of "Thu, 29 Jul 2010 07:37:56 +0200."
	<s5hhbjialvv.wl%tiwai@suse.de>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============5219381412329817983==
Content-Type: multipart/signed; boundary="==_Exmh_1280419527_4412P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit

--==_Exmh_1280419527_4412P
Content-Type: text/plain; charset=us-ascii

On Thu, 29 Jul 2010 07:37:56 +0200, Takashi Iwai said:

> This was already fixed, but in the same date (July 27) as mmotm was
> created.  The commit is:
> 
>     cd7643bfb772dc7103ed6fc8dda6b233a8e14178
>     Author:     Jaroslav Kysela <perex@perex.cz>
>     ALSA: hda-intel - fix function_id rework (add missing bitmask)

Thanks, I cherry-picked that commit and my sound now works.

--==_Exmh_1280419527_4412P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFMUabHcC3lWbTT17ARAnTiAJ4yHuLTy0BBPEzHBk7srLPlbbvmDACcCgm/
1D4rivpYNySBY5xGrLC4/+I=
=aWIq
-----END PGP SIGNATURE-----

--==_Exmh_1280419527_4412P--


--===============5219381412329817983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5219381412329817983==--
