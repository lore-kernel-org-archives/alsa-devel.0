From: Valdis.Kletnieks@vt.edu
Subject: Re: 2.6.28-rc2-mm1 - sound semi-busted on Dell Latitude D820
Date: Wed, 12 Nov 2008 16:09:37 -0500
Message-ID: <29372.1226524177@turing-police.cc.vt.edu>
References: <4411.1226345758@turing-police.cc.vt.edu> <s5hljvqzot1.wl%tiwai@suse.de> <s5hprl2yz39.wl%tiwai@suse.de>
            <s5hmyg6yz0n.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1226524177_3381P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755144AbYKLVJ7@vger.kernel.org>
In-Reply-To: Your message of "Tue, 11 Nov 2008 18:04:56 +0100."
             <s5hmyg6yz0n.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, perex@perex.cz, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--==_Exmh_1226524177_3381P
Content-Type: text/plain; charset=us-ascii

On Tue, 11 Nov 2008 18:04:56 +0100, Takashi Iwai said:

Following up...

> > > To confirm a regression, could you copy sound/pci/hda/patch_sigmatel.c
> > > from 2.6.27 kernel and check the driver works?  Does the same problem
> > > exist in 2.6.28-rc kernel?

Yes, it was a regression - using the older patch_sigmatel.c in the -rc4-mm
kernel worked fine.

> > Could you try the patch below?

> > There is another patch for a missing capture mux control, but in your
> > case, it doesn't matter because you didn't change the value.
> > I'll post that patch later, too.
> 
> Here is another fix.

> Subject: [PATCH] ALSA: hda - Add missing analog-mux mixer creation for STAC9200

Running with a current patch_sigmatel.c plus the two patches also works fine,
so feel free to stick a Tested-By: on it if you wish...

Thanks for the speedy patches..

--==_Exmh_1226524177_3381P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFJG0YRcC3lWbTT17ARAkTSAJ9P5GDgz4fdCZylYWleNGq3Pn7eJwCfQ0ZU
Dz4eEFYKRo368aOVFRo7DcY=
=oGJ4
-----END PGP SIGNATURE-----

--==_Exmh_1226524177_3381P--
