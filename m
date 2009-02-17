From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: [PATCH] hda: Add logic to force HP mixer creation
Date: Tue, 17 Feb 2009 13:27:12 -0600
Message-ID: <499B0F90.4070008@dell.com>
References: <49983C3D.2000309@embeddedalley.com>	<s5hiqnaiwa1.wl%tiwai@suse.de>	<499AFBAE.3050003@dell.com>
	<s5heixw2a0i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4382995067722759376=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ausc60pc101.us.dell.com (ausc60pc101.us.dell.com
	[143.166.85.206])
	by alsa0.perex.cz (Postfix) with ESMTP id 82164243F3
	for <alsa-devel@alsa-project.org>; Tue, 17 Feb 2009 20:27:15 +0100 (CET)
In-Reply-To: <s5heixw2a0i.wl%tiwai@suse.de>
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
--===============4382995067722759376==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig85880B964A0FC88589DF577C"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig85880B964A0FC88589DF577C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Takashi:

Takashi Iwai wrote:
> If "Surround" doesn't do anything, why should it be there?
> And, does "Headphone" change both headphones even with 4 or 6 ch output=
s
> properly?   Doesn't "Headhpone" change any other output volumes?
>  =20
I found what the surround mixer is being used for. If "Mic as Output" is
turned on, "Surround" acts as the mixer to control that jack.

The Headphone mixer changes both of the regular headphone jack's
volumes. Changing the "Headphone" volume doesn't affect the speaker
outputs at all, only the two headphone jacks.
> The patch introduces another exception, and now nobody would understand=

> how the channels and outputs and mixers are assigned together.
>  =20
Two points:
1) I'm not sure this is as much of a problem as you raise. I don't
believe many people even know how the channels and mixers are assigned
in the first place. I see plenty of support requests for "why doesn't
this second headphone jack work with headphones". I've never seen one of
"I can't hook up my 7.1 surround system to my consumer grade laptop and
have all of my speakers work". These machines come with DisplayPort and
HDMI ports which people will generally be using for hooking up to their
television sets. I seem to think it's not very common to use the
analogue jacks to independently hook up pairs of speakers assigned to
say Front or Surround.
2) You are still able to hook up a separate set of speakers to the mic
output jack and since those are assigned surround have things work as
expected.

>
> Hm, I thought I did.  Which patch exactly?
>
>  =20
The patch title was [PATCH] hda: Add STA_DELL_S14 quirk. Here's the
starting part of it:

Add STAC_DELL_S14 quirk for new laptop series. Removed un-needed pins in =
pin_nids
for stac92hd83xxx. Also reorganized connection selection code for the res=
pective ports
per quirk define.

---
 sound/pci/hda/patch_sigmatel.c <imap://mario_limonciello@outlook.dell.co=
m:143/fetch%3EUID%3E/INBOX%3E13699#sound/pci/hda/patch_sigmatel.c> |   52=
 +++++++++++++++++++++++++++-------------


 1 files changed, 35 insertions(+), 17 deletions(-)


You responded to the mail saying it was applied, but I seem to not be
able to find it in current ALSA git.

Regards
--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com

--------------enig85880B964A0FC88589DF577C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkmbD5AACgkQ2CrZjkA73Ys3IwCgnGLqflG6/ee75N/uVXD+YJ7c
dlAAoJwf8AiHfKVdborsHZfLF/iHJPvI
=t9IE
-----END PGP SIGNATURE-----

--------------enig85880B964A0FC88589DF577C--

--===============4382995067722759376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4382995067722759376==--
