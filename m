From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [PATCH]snd-usb-usx2y
Date: Fri, 5 Dec 2003 00:41:24 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312050041.24111.annabellesgarden@yahoo.de>
References: <200311271544.21367.annabellesgarden@yahoo.de> <200312042302.14540.annabellesgarden@yahoo.de> <20031204224623.GB6074@tuba.home>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_kY8z/KffgTb1W2m"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031204224623.GB6074@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_kY8z/KffgTb1W2m
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Donnerstag, 4. Dezember 2003 23:46 schrieb Martin Langer:
> On Thu, Dec 04, 2003 at 11:02:14PM +0100, Karsten Wiese wrote:
> > Am Donnerstag, 4. Dezember 2003 20:30 schrieb Martin Langer:
> > > Karsten, your us428 fix breaks us122 support.
> > > usX2Y_rate_set(usX2Y_stream, 44100)) isn't possible on us122.
> >
> > usX2Y_rate_set() is being called when you start audio also.
> > So audio stops working on the us122 with this patch?
> > Would it work with 48000 instead of 44100?
>
> no success with both frequencies. it produces the same error:
> ALSA usX2Yhwdep.c:315: snd_us428_create_alsa_devices error -19
>
> I guess we have to check the device id here and allow this only in case of
> ID=8001.
>

The attached patch against CVS-HEAD does that.
Please try it. If us122 works again, ask Jaroslav to commit it, as Takashi is 
on vacation.

Best,
Karsten

--Boundary-00=_kY8z/KffgTb1W2m
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="usbusx2yaudio.c.patch_1.3_1.4"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="usbusx2yaudio.c.patch_1.3_1.4"

Index: alsa-driver/usb/usx2y/usbusx2yaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usx2y/usbusx2yaudio.c,v
retrieving revision 1.3
diff -u -r1.3 usbusx2yaudio.c
--- alsa-driver/usb/usx2y/usbusx2yaudio.c	2 Dec 2003 10:15:02 -0000	1.3
+++ alsa-driver/usb/usx2y/usbusx2yaudio.c	4 Dec 2003 23:24:00 -0000
@@ -1224,9 +1224,12 @@
 
 	sprintf(pcm->name, NAME_ALLCAPS" Audio #%d", usX2Y(card)->chip.pcm_devs);
 
-	if (0 > (err = snd_pcm_lib_preallocate_pages(pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream,  64*1024, 128*1024, GFP_KERNEL))
-	    || 0 > (err = snd_pcm_lib_preallocate_pages(pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream ,  usX2Y_capt_substream->endpoints * 64*1024, usX2Y_capt_substream->endpoints * 128*1024, GFP_KERNEL))
-	    || 0 > (err = usX2Y_rate_set(usX2Y_stream, 44100))) {  // needed to make us428 recognize output-volume settings for direct-monitoring and master-pcm. shouldn't disturb other usx2y.
+	if (0 > (err = snd_pcm_lib_preallocate_pages(pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream, 64*1024, 128*1024, GFP_KERNEL)) ||
+	    0 > (err = snd_pcm_lib_preallocate_pages(pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream,
+							usX2Y_capt_substream->endpoints * 64*1024,
+							usX2Y_capt_substream->endpoints * 128*1024, GFP_KERNEL)) ||
+	    (usX2Y(card)->chip.dev->descriptor.idProduct == USB_ID_US428 &&
+	     0 > (err = usX2Y_rate_set(usX2Y_stream, 44100)))) {	// Lets us428 recognize output-volume settings, disturbs us122.
 		snd_usX2Y_audio_stream_free(usX2Y_stream);
 		return err;
 	}

--Boundary-00=_kY8z/KffgTb1W2m--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
