From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH 2/8] emu10k1 multichannel support
Date: Tue, 15 Feb 2005 19:43:55 -0500
Message-ID: <1108514635.3772.27.camel@krustophenia.net>
References: <1108514291.3772.19.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-rB96bqbH+dzykkxTTX38"
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


--=-rB96bqbH+dzykkxTTX38
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-02-15 at 19:38 -0500, Lee Revell wrote:
> This series of patches adds a 16 channel non interleaved PCM playback
> device, hw:x,3, to the emu10k1 driver.  It also adds support for the
> newly discovered per channel half loop interrupt.

Initialize the multichannel device.

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

--=-rB96bqbH+dzykkxTTX38
Content-Disposition: attachment; filename=emu10k1.c.patch
Content-Type: text/x-patch; name=emu10k1.c.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Index: alsa-v009-test/alsa-kernel/pci/emu10k1/emu10k1.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1.c,v
retrieving revision 1.30
diff -u -r1.30 emu10k1.c
--- alsa-v009-test/alsa-kernel/pci/emu10k1/emu10k1.c	22 Nov 2004 18:45:49 -0000	1.30
+++ alsa-v009-test/alsa-kernel/pci/emu10k1/emu10k1.c	15 Feb 2005 23:51:21 -0000
@@ -149,6 +149,11 @@
 		return err;
 	}
 
+	if ((err = snd_emu10k1_pcm_multi(emu, 3, NULL)) < 0) {
+		snd_card_free(card);
+		return err;
+	}		
+
 	if (emu->audigy) {
 		if ((err = snd_emu10k1_audigy_midi(emu)) < 0) {
 			snd_card_free(card);

--=-rB96bqbH+dzykkxTTX38--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
