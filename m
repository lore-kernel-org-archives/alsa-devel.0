From: =?big5?B?IlRpZW4sICBDLkwuIC0gpdCp08KnIg==?= <cltien@cmedia.com.tw>
Subject: RE: CMI8768 patch
Date: Wed, 23 Feb 2005 03:07:02 +0800
Message-ID: <92C0412E07F63549B2A2F2345D3DB515F7D655@cm-msg-02.cmedia.com.tw>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable
content-class: urn:content-classes:message
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I made changes to the CMI8738-MC8.conf so the PCM volume appear after
play with -D front or -D rear:

--- alsa/CMI8738-MC8.conf	Fri Feb 18 17:29:38 2005
+++ CMI8738-MC8.conf	Tue Feb 22 13:28:58 2005
@@ -7,7 +7,7 @@
 CMI8738-MC8.pcm.front.0 {
 	@args [ CARD ]
 	@args.CARD {
-		type string
+		type integer
 	}
 	type softvol
 	slave.pcm {
@@ -57,7 +57,7 @@
 CMI8738-MC8.pcm.rear.0 {
 	@args [ CARD ]
 	@args.CARD {
-		type string
+		type integer
 	}
 	type softvol
 	slave.pcm {
@@ -76,7 +76,7 @@
 CMI8738-MC8.pcm.surround40.0 {
 	@args [ CARD ]
 	@args.CARD {
-		type string
+		type integer
 	}
 	type softvol
 	slave.pcm {

But the aplay -D default still shows:

ALSA lib pcm.c:2068:(snd_pcm_open_noupdate) Unknown PCM 0
ALSA lib pcm_dmix.c:868:(snd_pcm_dmix_open) unable to open slave
aplay: main:508: audio open error: No such file or directory

BTW, the query_chip() should be run with 8738 only, there is no
chip version for 8338 and the register checked in query_chip()
is reserved in 8338, so I made following change:

--- alsa-driver-1.0.8/alsa-kernel/pci/cmipci.c	Mon Jan  3 06:45:31 2005
+++ alsa-driver-1.0.8-update/alsa-kernel/pci/cmipci.c	Tue Feb 22 =
13:31:06 2005@@ -2623,7 +2664,8 @@
 	cm->max_channels =3D 2;
 	cm->do_soft_ac3 =3D soft_ac3[dev];
=20
-	query_chip(cm);
+	if (strcmp(card->driver, "CMI8338"))
+		query_chip(cm);
=20
 	cm->dig_status =3D SNDRV_PCM_DEFAULT_CON_SPDIF;
 	cm->dig_pcm_status =3D SNDRV_PCM_DEFAULT_CON_SPDIF;

I also recmmend that the "Four Channel" switch should be turned off for
surround41 and surround50, as well as surround51 and surround71. The

Sincerely,
ChenLi Tien
-----Original Message-----
From:	Takashi Iwai [mailto:tiwai@suse.de]
Sent:	2005/2/22 [=ACP=B4=C1=A4G] =A4W=A4=C8 06:30
To:	Tien,  C.L. - =A5=D0=A9=D3=C2=A7
Cc:	alsa-devel@lists.sourceforge.net
Subject:	Re: [Alsa-devel] CMI8768 patch
At Mon, 21 Feb 2005 07:20:55 +0800,
Tien, C.L. wrote:
>=20
> Should it be instide the patch or just like:
>=20
> Signed-off-by: ChenLi Tien <cltien@cmedia.com.tw>

Both are OK.  Thanks.

> I still cannot use the softvol with 8768, but softvol works with the =
8739 so I don't
> know if anything need to do except not setting PCM Playback Volume =
item for mixer.

The softvol won't create a control if it already exists in h/w, and
skips the software attenuation.  But, in your patch, PCM Playback
Volume control is removed, so it should work...

Did you try my config file I sent you in the last mail?


Takashi





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
