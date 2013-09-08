From: "Jurgen Kramer" <gtmkramer@xs4all.nl>
Subject: [PATCH] aplay - fix two off by one errors
Date: Sun, 8 Sep 2013 13:50:51 +0200
Message-ID: <127132b074e97d56b5deab572b9c2176.squirrel@webmail.xs4all.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20130908135051_59489"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-vbr9.xs4all.nl (smtp-vbr9.xs4all.nl [194.109.24.29])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B50F261691
 for <alsa-devel@alsa-project.org>; Sun,  8 Sep 2013 13:50:51 +0200 (CEST)
Received: from webmail.xs4all.nl (dovemail16.xs4all.nl [194.109.26.18])
 by smtp-vbr9.xs4all.nl (8.13.8/8.13.8) with ESMTP id r88Bojwu095618
 for <alsa-devel@alsa-project.org>; Sun, 8 Sep 2013 13:50:51 +0200 (CEST)
 (envelope-from gtmkramer@xs4all.nl)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

------=_20130908135051_59489
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Attached patch for aplay fixes two off-by-one errors preventing usage of
the last available sample format.

diff -uNrp alsa-utils-1.0.27.2/aplay/aplay.c
alsa-utils-1.0.27.2-jk/aplay/aplay.c
--- alsa-utils-1.0.27.2/aplay/aplay.c	2013-07-09 17:28:37.000000000 +0200
+++ alsa-utils-1.0.27.2-jk/aplay/aplay.c	2013-09-08 13:46:23.746825429 +0=
200
@@ -242,7 +242,7 @@ _("Usage: %s [OPTION]... [FILE]...\n"
   )
 		, command);
 	printf(_("Recognized sample formats are:"));
-	for (k =3D 0; k < SND_PCM_FORMAT_LAST; ++k) {
+	for (k =3D 0; k <=3D SND_PCM_FORMAT_LAST; ++k) {
 		const char *s =3D snd_pcm_format_name(k);
 		if (s)
 			printf(" %s", s);
@@ -1114,7 +1114,7 @@ static void show_available_sample_format
 	snd_pcm_format_t format;

 	fprintf(stderr, "Available formats:\n");
-	for (format =3D 0; format < SND_PCM_FORMAT_LAST; format++) {
+	for (format =3D 0; format <=3D SND_PCM_FORMAT_LAST; format++) {
 		if (snd_pcm_hw_params_test_format(handle, params, format) =3D=3D 0)
 			fprintf(stderr, "- %s\n", snd_pcm_format_name(format));
 	}


Jurgen

------=_20130908135051_59489
Content-Type: text/x-patch; name="aplay-fix-off-by-one-errors.patch"
Content-Disposition: attachment;
  filename="aplay-fix-off-by-one-errors.patch"
Content-Transfer-Encoding: quoted-printable

diff -uNrp alsa-utils-1.0.27.2/aplay/aplay.c alsa-utils-1.0.27.2-jk/aplay=
/aplay.c
--- alsa-utils-1.0.27.2/aplay/aplay.c	2013-07-09 17:28:37.000000000 +0200
+++ alsa-utils-1.0.27.2-jk/aplay/aplay.c	2013-09-08 13:46:23.746825429 +0=
200
@@ -242,7 +242,7 @@ _("Usage: %s [OPTION]... [FILE]...\n"
   )
 		, command);
 	printf(_("Recognized sample formats are:"));
-	for (k =3D 0; k < SND_PCM_FORMAT_LAST; ++k) {
+	for (k =3D 0; k <=3D SND_PCM_FORMAT_LAST; ++k) {
 		const char *s =3D snd_pcm_format_name(k);
 		if (s)
 			printf(" %s", s);
@@ -1114,7 +1114,7 @@ static void show_available_sample_format
 	snd_pcm_format_t format;
=20
 	fprintf(stderr, "Available formats:\n");
-	for (format =3D 0; format < SND_PCM_FORMAT_LAST; format++) {
+	for (format =3D 0; format <=3D SND_PCM_FORMAT_LAST; format++) {
 		if (snd_pcm_hw_params_test_format(handle, params, format) =3D=3D 0)
 			fprintf(stderr, "- %s\n", snd_pcm_format_name(format));
 	}
------=_20130908135051_59489
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_20130908135051_59489--
