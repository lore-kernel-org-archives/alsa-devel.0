From: Martin Langer <martin-langer@gmx.de>
Subject: Re: [PATCH]snd-usb-usx2y
Date: Thu, 4 Dec 2003 20:30:09 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031204193009.GA678@tuba.home>
References: <200311271544.21367.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200311271544.21367.annabellesgarden@yahoo.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

diff -u -r1.1 usbusx2yaudio.c
--- alsa-driver/usb/usx2y/usbusx2yaudio.c	25 Nov 2003 11:21:49 -0000	1.1
+++ alsa-driver/usb/usx2y/usbusx2yaudio.c	27 Nov 2003 14:32:25 -0000
@@ -1225,7 +1225,8 @@
 	sprintf(pcm->name, NAME_ALLCAPS" Audio #%d", usX2Y(card)->chip.pcm_devs);
 
 	if (0 > (err = snd_pcm_lib_preallocate_pages(pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream,  64*1024, 128*1024, GFP_ATOMIC))
-	    || 0 > (err = snd_pcm_lib_preallocate_pages(pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream ,  usX2Y_capt_substream->endpoints * 64*1024, usX2Y_capt_substream->endpoints * 128*1024, GFP_ATOMIC))) {
+	    || 0 > (err = snd_pcm_lib_preallocate_pages(pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream ,  usX2Y_capt_substream->endpoints * 64*1024, usX2Y_capt_substream->endpoints * 128*1024, GFP_ATOMIC))
+	    || 0 > (err = usX2Y_rate_set(usX2Y_stream, 44100))) {  // needed to make us428 recognize output-volume settings for direct-monitoring and master-pcm. shouldn't disturb other usx2y.

Karsten, your us428 fix breaks us122 support.
usX2Y_rate_set(usX2Y_stream, 44100)) isn't possible on us122. 

martin



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
