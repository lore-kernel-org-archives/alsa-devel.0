From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH 5/8] emu10k1 multichannel support
Date: Tue, 15 Feb 2005 19:48:17 -0500
Message-ID: <1108514897.3772.34.camel@krustophenia.net>
References: <1108514291.3772.19.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-SB6j+8G4hDJ4fPGDq21o"
In-Reply-To: <1108514291.3772.19.camel@krustophenia.net>
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


--=-SB6j+8G4hDJ4fPGDq21o
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-02-15 at 19:38 -0500, Lee Revell wrote:
> This series of patches adds a 16 channel non interleaved PCM playback
> device, hw:x,3, to the emu10k1 driver.  It also adds support for the
> newly discovered per channel half loop interrupt.

Add support for half loop interrupt.

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

--=-SB6j+8G4hDJ4fPGDq21o
Content-Disposition: attachment; filename=irq.c.patch
Content-Type: text/x-patch; name=irq.c.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Index: alsa-v009-test/alsa-kernel/pci/emu10k1/irq.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/irq.c,v
retrieving revision 1.11
diff -u -r1.11 irq.c
--- alsa-v009-test/alsa-kernel/pci/emu10k1/irq.c	10 Nov 2004 09:49:12 -0000	1.11
+++ alsa-v009-test/alsa-kernel/pci/emu10k1/irq.c	15 Feb 2005 23:51:23 -0000
@@ -73,6 +73,21 @@
 				val >>= 1;
 				pvoice++;
 			}
+			val = snd_emu10k1_ptr_read(emu, HLIPL, 0);
+			for (voice = 0; voice <= voice_max; voice++) {
+				if (voice == 0x20)
+					val = snd_emu10k1_ptr_read(emu, HLIPH, 0);
+				if (val & 1) {
+					if (pvoice->use && pvoice->interrupt != NULL) {
+						pvoice->interrupt(emu, pvoice);
+						snd_emu10k1_voice_half_loop_intr_ack(emu, voice);
+					} else {
+						snd_emu10k1_voice_half_loop_intr_disable(emu, voice);
+					}
+				}
+				val >>= 1;
+				pvoice++;
+			}
 			status &= ~IPR_CHANNELLOOP;
 		}
 		status &= ~IPR_CHANNELNUMBERMASK;

--=-SB6j+8G4hDJ4fPGDq21o--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
