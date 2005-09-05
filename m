From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: hda-intel/ALC260: crackly playback and DC offset on recording
Date: Mon, 5 Sep 2005 09:59:58 +0930 (CST)
Message-ID: <200509050029.j850Twn5004053@auster.physics.adelaide.edu.au>
References: <s5hbr3bvlge.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbr3bvlge.wl%tiwai@suse.de> from "Takashi Iwai" at Sep 02, 2005 12:00:01 PM
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
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all

Further tests with the hda-intel driver with the ALC260 chip in my laptop
has shown that when audio is played, seemingly random crackling occurs
in the output.  This affects only playback - recorded audio is fine.  It
affected aplay (native alsa), wavplay (uses /dev/dsp and thus alsa's OSS
snd-pcm-oss module) and audacity 1.2.2 (also using /dev/dsp).

I found that the following change to hda_intel.c almost fixed the problem:

--- hda_intel.c 2005-09-03 23:02:18.000000000 +0930
+++ hda_intel.c-orig    2005-08-16 05:23:07.000000000 +0930
@@ -1026,7 +1026,7 @@
 	azx_setup_periods(azx_dev);
 	azx_setup_controller(chip, azx_dev);
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		azx_dev->fifo_size = azx_sd_readw(azx_dev, SD_FIFOSIZE);
+		azx_dev->fifo_size = azx_sd_readw(azx_dev, SD_FIFOSIZE) + 1;
 	else
 		azx_dev->fifo_size = 0;

If this patch was applied then playing audio using aplay was clean - no hint
of the crackling was evident.  However, playing through audacity (which used
the ALSA OSS emulation) was still crackly.  I then tested using wavplay (which
also uses the OSS devices) and it too was still crackly.  I recompiled
audacity to use portaudio v19 (thus giving audacity native ALSA support) and
was slightly surprised to hear that the crackling remained with audacity even
when using the ALSA output options.  Throughout all this, the aplay output
was clean so long as the above patch had been applied.

I must admit to not knowing exactly what the fifo_size does; my attention
was drawn to it because the +1 looked odd and it was an obvious point of
difference between the record path (which was fine) and the playback path
(which crackled).

On the subject of recording, there seems to be a DC offset in the ADC which
is dependent on the level of the "capture" mixer control - the higher the
control the higher the DC offset.  The offset is present even when nothing
is plugged in to the laptop.  With the control at maximum the DC offset
is as much as 10% FSD; at mimimum it's around 1-2%.

Any ideas on either of these?

Regards
  jonathan


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
