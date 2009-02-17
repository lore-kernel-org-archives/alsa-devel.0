From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: [PATCH] hda: Add logic to force HP mixer creation
Date: Tue, 17 Feb 2009 15:06:38 -0600
Message-ID: <499B26DE.2010109@dell.com>
References: <49983C3D.2000309@embeddedalley.com>	<s5hiqnaiwa1.wl%tiwai@suse.de>	<499AFBAE.3050003@dell.com>	<s5heixw2a0i.wl%tiwai@suse.de>	<499B0F90.4070008@dell.com>
	<s5hljs46beo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5885878284670535505=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ausxippc101.us.dell.com (ausxippc101.us.dell.com
	[143.166.85.207])
	by alsa0.perex.cz (Postfix) with ESMTP id E6401243BC
	for <alsa-devel@alsa-project.org>; Tue, 17 Feb 2009 22:06:40 +0100 (CET)
In-Reply-To: <s5hljs46beo.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Matthew Ranostay <mranostay@embeddedalley.com>
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============5885878284670535505==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig13ED45A198E71F6467F9C04E"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig13ED45A198E71F6467F9C04E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Takashi:

Takashi Iwai wrote:
> At Tue, 17 Feb 2009 13:27:12 -0600,
> Mario Limonciello wrote:
>  =20
>
> Ah, OK, then the mic jack is connected to the surround DAC.
> But don't you have Center and LFE?
>  =20
There aren't mixers for Center or LFE at all.  Again going back to my
feelings about mixer names, for the purposes of a laptop I think
providing a knob called Center or another called LFE just adds to the
confusion.
> And any control of speaker volume?
>  =20
Speaker volume is handled by the combination of Master, PCM, and Front
mixers.  The headphone mixer has no bearing on the volume of the speakers=
=2E
>
> And exactly this is another point why I feel the necessity of
> cleanup.  If the feature isn't needed, we should get rid of it.  Or,
> implement in a better form.
>  =20
If I was to put a vote towards this, I think attempting to support 6
channel analog in the mobile space is a feature that needs to go.  It
causes confusion and complicates the code.=20
> One more another problem is that this setup thingy isn't described
> at all, or pretty hard to guess from the mixer control.  There are
> knobs, but you don't know the combination.
>  =20
I think knobs, switches, do-hickeys, etc are great to have when they
serve an explicit purpose.  I look at the mixers being presented to me,
and I've no idea what

"Mono Mux" is there for, or why I've got several "Digital Input Source"
areas.=20
> This must be included.  Check commit
> 8bb0ac5573ff0879fef511e1a80a4a4db0316daa
> in sound git tree.
>  =20
I suppose i've got some confusion for when these commits are showing up
on
http://git.alsa-project.org/?p=3Dalsa-kernel.git;a=3Dhistory;f=3Dsound/pc=
i/hda/patch_sigmatel.c;h=3D3c84817ccd2e0d4bd1eee4f2882047ae84165e10;hb=3D=
HEAD
My understanding was that the tree alsa-kernel tree was merged into the
alsa-driver and alsa-kmirror trees on a regular basis.  I have been
operating off of web snapshots of alsa-driver from
http://www.alsa-project.org/snapshot/ since I can't do GIT internally
here, but I'm not seeing the patch show up in alsa-driver there.

Regards
--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com

--------------enig13ED45A198E71F6467F9C04E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkmbJt4ACgkQ2CrZjkA73YujoACfb5fM/dqO2cZ12g88USdhmOyT
ousAn0Oo1tjp2HkMcrpflsf+SCUmOq0E
=0JiW
-----END PGP SIGNATURE-----

--------------enig13ED45A198E71F6467F9C04E--

--===============5885878284670535505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5885878284670535505==--
