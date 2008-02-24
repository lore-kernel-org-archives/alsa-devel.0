From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: ESS 1688
Date: Sun, 24 Feb 2008 14:23:38 +0100
Message-ID: <47C16FDA.4030708@keyaccess.nl>
References: <mailman.0.1203805307.22796.alsa-user@lists.sourceforge.net>	<20080223232022.GA7656@amin>
	<47C13E03.8000903@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020004060207070108060804"
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <47C13E03.8000903@keyaccess.nl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Hans Ekbrand <hans@sociologi.cjb.net>
Cc: alsa-user@lists.sourceforge.net, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020004060207070108060804
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 24-02-08 10:50, Rene Herman wrote:

> Not yet, but I confirm the bug. I'll try and see of I can locate
> anything. No ETA available.

Can you try if applying the attached makes things work as you'd expect with 
respect to the recording levels? Over here it seems to, although I get the 
feeling we might as well rename the control "Distortion Levels" as keeping 
it at 0 is the only sensible thing.

Even if this works, it's not a final fix, just to confirm. Given that you 
posted to alsa-user... if you're not setup to apply this patch (to any semi 
recent source) and recompile the driver I hope someone can help.

With respect to the duplex issue -- there seem to be no docs for 688 and 
1688 which is a bit of a problem.

Rene.

--------------020004060207070108060804
Content-Type: text/plain;
 name="es1688_lib-reclev_dev.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="es1688_lib-reclev_dev.diff"

diff --git a/sound/isa/es1688/es1688_lib.c b/sound/isa/es1688/es1688_lib.c
index 5c26d49..eb35267 100644
--- a/sound/isa/es1688/es1688_lib.c
+++ b/sound/isa/es1688/es1688_lib.c
@@ -368,9 +368,11 @@ static int snd_es1688_playback_prepare(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	unsigned int size = snd_pcm_lib_buffer_bytes(substream);
 	unsigned int count = snd_pcm_lib_period_bytes(substream);
+	int tmp;
 
 	chip->dma_size = size;
 	spin_lock_irqsave(&chip->reg_lock, flags);
+	tmp = snd_es1688_read(chip, 0xb4);
 	snd_es1688_reset(chip);
 	snd_es1688_set_rate(chip, substream);
 	snd_es1688_write(chip, 0xb8, 4);	/* auto init DMA mode */
@@ -403,6 +405,7 @@ static int snd_es1688_playback_prepare(struct snd_pcm_substream *substream)
 	}
 	snd_es1688_write(chip, 0xb1, (snd_es1688_read(chip, 0xb1) & 0x0f) | 0x50);
 	snd_es1688_write(chip, 0xb2, (snd_es1688_read(chip, 0xb2) & 0x0f) | 0x50);
+	snd_es1688_write(chip, 0xb4, tmp);
 	snd_es1688_dsp_command(chip, ES1688_DSP_CMD_SPKON);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	/* --- */
@@ -429,9 +432,11 @@ static int snd_es1688_capture_prepare(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	unsigned int size = snd_pcm_lib_buffer_bytes(substream);
 	unsigned int count = snd_pcm_lib_period_bytes(substream);
+	int tmp;
 
 	chip->dma_size = size;
 	spin_lock_irqsave(&chip->reg_lock, flags);
+	tmp = snd_es1688_read(chip, 0xb4);
 	snd_es1688_reset(chip);
 	snd_es1688_set_rate(chip, substream);
 	snd_es1688_dsp_command(chip, ES1688_DSP_CMD_SPKOFF);
@@ -461,6 +466,7 @@ static int snd_es1688_capture_prepare(struct snd_pcm_substream *substream)
 	}
 	snd_es1688_write(chip, 0xb1, (snd_es1688_read(chip, 0xb1) & 0x0f) | 0x50);
 	snd_es1688_write(chip, 0xb2, (snd_es1688_read(chip, 0xb2) & 0x0f) | 0x50);
+	snd_es1688_write(chip, 0xb4, tmp);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	/* --- */
 	count = -count;

--------------020004060207070108060804
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--------------020004060207070108060804
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user

--------------020004060207070108060804--
