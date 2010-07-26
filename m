From: Valdis.Kletnieks@vt.edu
Subject: Re: hda_intel: too quiet sound (regression)
Date: Mon, 26 Jul 2010 14:40:01 -0400
Message-ID: <7512.1280169601@localhost>
References: <4C4D9EDA.3060505@gmail.com> <s5htynmuvw4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1505265575164379955=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lennier.cc.vt.edu (lennier.cc.vt.edu [198.82.162.213])
	by alsa0.perex.cz (Postfix) with ESMTP id 23B9E103852
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jul 2010 20:40:03 +0200 (CEST)
In-Reply-To: Your message of "Mon, 26 Jul 2010 17:04:43 +0200."
	<s5htynmuvw4.wl%tiwai@suse.de>
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
Cc: LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, fengguang.wu@intel.com, Jiri Slaby <jirislaby@gmail.com>
List-Id: alsa-devel@alsa-project.org

--===============1505265575164379955==
Content-Type: multipart/signed; boundary="==_Exmh_1280169601_4182P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit

--==_Exmh_1280169601_4182P
Content-Type: text/plain; charset=us-ascii

On Mon, 26 Jul 2010 17:04:43 +0200, Takashi Iwai said:
> At Mon, 26 Jul 2010 16:42:34 +0200, Jiri Slaby wrote:
> > after I upgraded from 2.6.34-rc5-mm1 to 2.6.35-rc5-mm1 (there were other
> > issues in between them), the sound from my soundcard is very very quiet.
> > 
> > alsa-info:
> > http://www.alsa-project.org/db/?f=dcadb29a2d5d047ecf5545792ac3239dc0c8c7f0
> > 
> > Any ideas?
> 
> Looks like a regression by the amp max value check.
> The following patch should fix the problem.

> ---
> From 7ccc3eface57b6e1773fce009dac8a3da081b8b1 Mon Sep 17 00:00:00 2001
> From: Takashi Iwai <tiwai@suse.de>
> Date: Mon, 26 Jul 2010 17:00:15 +0200
> Subject: [PATCH] ALSA: hda - Fix max amp cap calculation for IDT/STAC codecs

Confirming - I saw the same issue but didn't get a chance to track it down. This patch fixes it.
Feel free to stick a Tested-By: on it on its way upstream...

--==_Exmh_1280169601_4182P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFMTdaBcC3lWbTT17ARAviKAJ9GXkE6huFJqYgdSaIZh+VTYb+t2QCfZ+Ra
W49Zu5bFkYGqxDMb7lS6CeI=
=n14r
-----END PGP SIGNATURE-----

--==_Exmh_1280169601_4182P--


--===============1505265575164379955==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1505265575164379955==--
