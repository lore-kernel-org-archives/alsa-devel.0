From: Lee Revell <rlrevell@joe-job.com>
Subject: [PATCH] emu10k1: fix efx_voices_mask setting for SBLive
Date: Sat, 26 Feb 2005 19:19:52 -0500
Message-ID: <1109463592.1814.12.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-bST/XQbROUgGB/YCSHxH"
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: Takashi Iwai <tiwai@suse.de>, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org


--=-bST/XQbROUgGB/YCSHxH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch fixes a stupid thinko where we set the low 16 bits of the
FXWC register, which correspond to the 16 physical outs.  We should be
setting the high 16 bits, which correspond to the physical inputs
(connected in emufx.c).  The Audigy was not affected by this bug.

Also, the "EFX Voices Mask" control is renamed to "Captured FX8010
Outputs".  This is a trick to ensure the default mixer settings are
loaded when users upgrade from 1.0.8.  Otherwise, the upgrade process
will probably restore the old settings which results in the
"multichannel" capture device only having two channels.  I could not
think of a better way to get around this issue, and the alternative
seems to be a slew of bug reports.  Half the testers reported this to me
as a bug already.

Anyway, I think the new name is clearer anyway, because there's no
reason to tell userspace the hardware stores this value as a mask, and
"voices" is confusing because it implies some relation to the 64
wavetable/PCM voices.

Signed-Off-By: <rlrevell@joe-job.com>



--=-bST/XQbROUgGB/YCSHxH
Content-Disposition: attachment; filename=sblive-fix-default-voices-mask.patch
Content-Type: text/x-patch; name=sblive-fix-default-voices-mask.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Index: alsa/alsa-kernel/pci/emu10k1/emupcm.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emupcm.c,v
retrieving revision 1.40
diff -u -r1.40 emupcm.c
--- alsa/alsa-kernel/pci/emu10k1/emupcm.c	17 Feb 2005 14:49:50 -0000	1.40
+++ alsa/alsa-kernel/pci/emu10k1/emupcm.c	26 Feb 2005 23:34:53 -0000
@@ -1690,7 +1690,7 @@
 		emu->efx_voices_mask[0] = 0;
 		emu->efx_voices_mask[1] = 0xffff;
 	} else {
-		emu->efx_voices_mask[0] = 0xffff;
+		emu->efx_voices_mask[0] = 0xffff0000;
 		emu->efx_voices_mask[1] = 0;
 	}
 	snd_ctl_add(emu->card, snd_ctl_new1(&snd_emu10k1_pcm_efx_voices_mask, emu));

--=-bST/XQbROUgGB/YCSHxH--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
