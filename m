From: arromdee@rahul.net (Ken Arromdee)
Subject: Help with AD1816 driver please...
Date: Thu,  2 Feb 2006 19:34:57 -0800 (PST)
Message-ID: <20060203033457.B2E9EBE8CC@green.rahul.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I'm probably the only person who uses this driver (four years ago it wasn't
working at all and wasn't fixed until I reported the problem).

At any rate, I just tried using my card (Shark Predator ISA) for capture, which
I never did before.  It didn't work--it gave a weird repeating sound and
eventually the following error:
	arecord: pcm_read:1196: read error: Input/output error
I highly suspect the driver is causing the problem.  It's obviously never been
tested, and capture works fine in Windows 98.  Also, I know the weird sound
was a driver problem, because I was able to fix it (the version I patched is
the one in Mandrake 10.1).  I still get the pcm_read I/O error, however.

Here's the patch.  Is there anyone willing to officially make this change in
CVS, and/or help me fix the I/O error?

*** ad1816a_lib.c.orig	2006-02-02 21:25:00.869143712 -0500
--- ad1816a_lib.c	2006-02-02 21:29:13.142792288 -0500
***************
*** 179,185 ****
  
  
  static int snd_ad1816a_trigger(ad1816a_t *chip, unsigned char what,
! 			       int channel, int cmd)
  {
  	int error = 0;
  
--- 179,185 ----
  
  
  static int snd_ad1816a_trigger(ad1816a_t *chip, unsigned char what,
! 			       int channel, int cmd, int iscapture)
  {
  	int error = 0;
  
***************
*** 188,197 ****
  	case SNDRV_PCM_TRIGGER_STOP:
  		spin_lock(&chip->lock);
  		cmd = (cmd == SNDRV_PCM_TRIGGER_START) ? 0xff: 0x00;
! 		if (what & AD1816A_PLAYBACK_ENABLE)
  			snd_ad1816a_out_mask(chip, AD1816A_PLAYBACK_CONFIG,
  				AD1816A_PLAYBACK_ENABLE, cmd);
! 		if (what & AD1816A_CAPTURE_ENABLE)
  			snd_ad1816a_out_mask(chip, AD1816A_CAPTURE_CONFIG,
  				AD1816A_CAPTURE_ENABLE, cmd);
  		spin_unlock(&chip->lock);
--- 188,201 ----
  	case SNDRV_PCM_TRIGGER_STOP:
  		spin_lock(&chip->lock);
  		cmd = (cmd == SNDRV_PCM_TRIGGER_START) ? 0xff: 0x00;
! 		/* if (what & AD1816A_PLAYBACK_ENABLE) */
! 		/* That is not valid, because playback and capture enable
! 		 * are the same bit pattern, just to different addresses
! 		 */
! 		if (!iscapture)
  			snd_ad1816a_out_mask(chip, AD1816A_PLAYBACK_CONFIG,
  				AD1816A_PLAYBACK_ENABLE, cmd);
! 		if (iscapture)
  			snd_ad1816a_out_mask(chip, AD1816A_CAPTURE_CONFIG,
  				AD1816A_CAPTURE_ENABLE, cmd);
  		spin_unlock(&chip->lock);
***************
*** 208,221 ****
  {
  	ad1816a_t *chip = snd_pcm_substream_chip(substream);
  	return snd_ad1816a_trigger(chip, AD1816A_PLAYBACK_ENABLE,
! 		SNDRV_PCM_STREAM_PLAYBACK, cmd);
  }
  
  static int snd_ad1816a_capture_trigger(snd_pcm_substream_t *substream, int cmd)
  {
  	ad1816a_t *chip = snd_pcm_substream_chip(substream);
  	return snd_ad1816a_trigger(chip, AD1816A_CAPTURE_ENABLE,
! 		SNDRV_PCM_STREAM_CAPTURE, cmd);
  }
  
  static int snd_ad1816a_hw_params(snd_pcm_substream_t * substream,
--- 212,225 ----
  {
  	ad1816a_t *chip = snd_pcm_substream_chip(substream);
  	return snd_ad1816a_trigger(chip, AD1816A_PLAYBACK_ENABLE,
! 		SNDRV_PCM_STREAM_PLAYBACK, cmd, 0);
  }
  
  static int snd_ad1816a_capture_trigger(snd_pcm_substream_t *substream, int cmd)
  {
  	ad1816a_t *chip = snd_pcm_substream_chip(substream);
  	return snd_ad1816a_trigger(chip, AD1816A_CAPTURE_ENABLE,
! 		SNDRV_PCM_STREAM_CAPTURE, cmd, 1);
  }
  
  static int snd_ad1816a_hw_params(snd_pcm_substream_t * substream,



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
