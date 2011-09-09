From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: [PATCH] snd_hda_intel : add support for built-in
 audio devices on late 2010 Mac Pro (MacPro 5, 1)
Date: Fri, 09 Sep 2011 11:16:22 +0200
Message-ID: <1315559797.4192.26.camel@mattotaupa>
References: <0C4A886F-0F29-4943-9F09-9EB2B6054573@eecs.berkeley.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7202491585454238889=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 53DA5103ADC
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Sep 2011 11:16:40 +0200 (CEST)
In-Reply-To: <0C4A886F-0F29-4943-9F09-9EB2B6054573@eecs.berkeley.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Rimas Avizienis <rimas@eecs.berkeley.edu>
List-Id: alsa-devel@alsa-project.org


--===============7202491585454238889==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-wqCIxnat+Q7YkZ28feEz"


--=-wqCIxnat+Q7YkZ28feEz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Rimas,


thank you for your patch.

Am Freitag, den 09.09.2011, 01:31 -0700 schrieb Rimas Avizienis:

> I don't know what the protocol is around here for submitting patches,

I guess patches formatted using `git format-patch -s` are appreciated
for easier application.

Important is the Signed-off-by line which is required [1].

> but I spent the evening hacking the snd_hda_intel ALSA driver
> (specifically alc882_quirks.c) to add support for the built in audio
> devices on the late 2010 Mac Pro (MacPro 5,1) and I figured I should
> get it out into the world before I get lazy.

Good idea.

> Previously, the analog line out and optical digital I/Os worked if you
> specified the model=3Dimac24 parameter when loading the module.
> However, the analog input and front headphone jack didn't.  With this
> patch, all inputs and outputs seem to work properly and I've cleaned
> up the mixer interface (no source selection, no phantom inputs or
> outputs).

Could you attach (I think the size limit of this list is 70 KB) or
upload the output of `alsa-info.sh` [2] without and with your patch
applied.

> Hope someone finds this useful!

I guess a lot of people do.

Please resend as [PATCH v2]. I think the maintainer is on vacation right
now so it might take some days until your patch gets reviewed.


Thanks,

Paul


[1] http://www.mjmwired.net/kernel/Documentation/SubmittingPatches
[2] http://alsa-project.org/main/index.php/Help_To_Debug

--=-wqCIxnat+Q7YkZ28feEz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk5p2WYACgkQPX1aK2wOHVhAwwCfXQhCI7K9SbO6/EEe1SuU+171
WgMAn13cPY0xUJQj+XzACoZ1yF3fVuHt
=StBW
-----END PGP SIGNATURE-----

--=-wqCIxnat+Q7YkZ28feEz--


--===============7202491585454238889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7202491585454238889==--
