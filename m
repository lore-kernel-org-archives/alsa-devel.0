From: "Loc Ho" <loc@pacificconsultants.com>
Subject: RE: Alsa-devel digest, Vol 1 #1842 - 14 msgs
Date: Thu, 13 May 2004 13:43:28 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <D22B281CC561444AA27F7F6C6C9E3E6102F54C@mtvs4.pcllc.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Your fix of the ALSA memory allocation problem is incorrect. This only =
fixes the problem with the commerical USB Audio driver. It does not fix =
for all drivers. The proper fix is to replace the function setup_pcm_id =
with this one (note the added "card->number << 24"):

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
/*
 * set up the unique pcm id
 */
static inline void setup_pcm_id(snd_pcm_substream_t *subs)
{
	if (! subs->dma_device.id)
		subs->dma_device.id =3D subs->pcm->card->number << 24 | =
subs->pcm->device << 16 |
			subs->stream << 8 | (subs->number + 1);
}

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Thanks,
Loc Ho



Index: alsa-kernel/usb/usbaudio.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /suse/tiwai/cvs/alsa/alsa-kernel/usb/usbaudio.c,v
retrieving revision 1.100
diff -u -r1.100 usbaudio.c
--- alsa-kernel/usb/usbaudio.c	7 May 2004 10:08:49 -0000	1.100
+++ alsa-kernel/usb/usbaudio.c	13 May 2004 18:05:45 -0000
@@ -2036,6 +2036,7 @@
 static void init_substream(snd_usb_stream_t *as, int stream, struct =
audioformat *fp)
 {
 	snd_usb_substream_t *subs =3D &as->substream[stream];
+	snd_pcm_substream_t *pcms;
=20
 	INIT_LIST_HEAD(&subs->fmt_list);
 	spin_lock_init(&subs->lock);
@@ -2047,7 +2048,12 @@
 		subs->ops =3D audio_urb_ops[stream];
 	else
 		subs->ops =3D audio_urb_ops_high_speed[stream];
-	snd_pcm_lib_preallocate_pages(as->pcm->streams[stream].substream,
+	/* set up the unique device id with the card index number */
+	pcms =3D as->pcm->streams[stream].substream;
+	pcms->dma_device.id =3D (as->pcm->device << 16) |
+		(pcms->stream << 8) | (pcms->number + 1) |
+		(as->chip->card->number + 1) << 24;
+	snd_pcm_lib_preallocate_pages(pcms,
 				      SNDRV_DMA_TYPE_CONTINUOUS,
 				      snd_dma_continuous_data(GFP_KERNEL),
 				      64 * 1024, 128 * 1024);

--Multipart_Thu_May_13_20:06:45_2004-1--



--__--__--

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel


End of Alsa-devel Digest


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
