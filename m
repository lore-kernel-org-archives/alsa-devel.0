From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH 7/8] emu10k1 multichannel support
Date: Tue, 15 Feb 2005 19:50:42 -0500
Message-ID: <1108515042.3772.39.camel@krustophenia.net>
References: <1108514291.3772.19.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-4vPAdeu/NSHxjUCab20H"
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


--=-4vPAdeu/NSHxjUCab20H
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-02-15 at 19:38 -0500, Lee Revell wrote:
> This series of patches adds a 16 channel non interleaved PCM playback
> device, hw:x,3, to the emu10k1 driver.  It also adds support for the
> newly discovered per channel half loop interrupt.

Update synth voice allocation for new voice allocation scheme.

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

--=-4vPAdeu/NSHxjUCab20H
Content-Disposition: attachment; filename=emu10k1_callback.c.patch
Content-Type: text/x-patch; name=emu10k1_callback.c.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Index: alsa-v009-test/alsa-kernel/pci/emu10k1/emu10k1_callback.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1_callback.c,v
retrieving revision 1.12
diff -u -r1.12 emu10k1_callback.c
--- alsa-v009-test/alsa-kernel/pci/emu10k1/emu10k1_callback.c	29 Jun 2004 16:10:33 -0000	1.12
+++ alsa-v009-test/alsa-kernel/pci/emu10k1/emu10k1_callback.c	15 Feb 2005 23:51:21 -0000
@@ -291,7 +291,7 @@
 			if (vp->ch < 0) {
 				/* allocate a voice */
 				emu10k1_voice_t *hwvoice;
-				if (snd_emu10k1_voice_alloc(hw, EMU10K1_SYNTH, 0, &hwvoice) < 0 || hwvoice == NULL)
+				if (snd_emu10k1_voice_alloc(hw, EMU10K1_SYNTH, 1, &hwvoice) < 0 || hwvoice == NULL)
 					continue;
 				vp->ch = hwvoice->number;
 				emu->num_voices++;

--=-4vPAdeu/NSHxjUCab20H--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
