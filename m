From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [Alsa-user] is this card supported by ALSA?
Date: Tue, 15 Jul 2008 16:42:05 +0200
Message-ID: <487CB73D.4050808@keyaccess.nl>
References: <BLU137-W526424D3E9A79DA1437849959A0@phx.gbl>	<48701633.7040601@keyaccess.nl>	<loom.20080708T141841-614@post.gmane.org>	<4873AB3B.1070403@keyaccess.nl>	<4873CED6.2040704@keyaccess.nl>	<4873D033.8010604@keyaccess.nl>	<BLU137-W434EEB6A014E95FD1E225C95910@phx.gbl>	<48769D84.1050102@keyaccess.nl>	<BLU137-W51DDE8E1756609BBE5CF7F95910@phx.gbl>	<4876A0DE.2050803@keyaccess.nl>	<BLU137-W23A4FF48E97AC32476FD6095900@phx.gbl>	<4876AC75.2010305@keyaccess.nl>	<BLU137-W541C318CC744C4BF6461DE95900@phx.gbl>	<4876B329.80700@keyaccess.nl>	<BLU137-W3234537335E7D553F03AF195900@phx.gbl>	<48798CF7.6020303@keyaccess.nl>	<loom.20080714T232812-533@post.gmane.org>	<487BEB3D.6000209@keyaccess.nl>	<s5hvdz7uwb6.wl%tiwai@suse.de>
	<s5hod4zxm9v.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000401020404020704050700"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id D7FB42446E
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Jul 2008 16:40:16 +0200 (CEST)
In-Reply-To: <s5hod4zxm9v.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Landis McGauhey <b3zdomny@hotmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-user@lists.sourceforge.net, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000401020404020704050700
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 15-07-08 16:19, Takashi Iwai wrote:

> The below is a patch to improve the codec access routines in a bit
> more robust way (and clean-ups, too).  Give it a try.

Thank you for taking this...

Landis, if it's easier for you due to webmail stuff, I'm attaching the 
patch to this message so that it might be easier for you to save it 
(Takashi posted it "inline" in the message).

The way to use this is very similar to what you did for the OSS driver 
patch. You save this somewhere, then from the root of the source tree 
(from /usr/src/linux-2.6.25.9 it was...) you do

# patch -p1 --dry-run < /some/where/ens1371-ac97.diff

and upon seeing that complete without errors, without the --dry-run:

# patch -p1 --dry-run < /some/where/ens1371-ac97.diff

You then recompile the kernel with "make" (which should now only 
recompile the snd-ens1371 driver) and do a "make modules_install" after 
it finishes.

Then, make sure no old driver for the card is loaded:

# modprobe -r snd-ens1371
# modprobe -r es1371

and load the new one:

# modprobe snd-ens1371

then up and unmute volumes in alsamixer again and try if you have sound 
with "speaker-test" or "aplay foo.wav".

If you do, you should blacklist the now installed OSS es1371 driver (add 
"blacklist es1371" to /etc/modprobe.d/blacklist) and make sure 
snd-ens1371 is no longer blacklisted. If all's well, working sound 
should then survive a reboot (and a future kernel would include the fix 
autonmatically so things just work out of the box).

Rene.

--------------000401020404020704050700
Content-Type: text/plain;
 name="ens1371-ac97.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ens1371-ac97.diff"

diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
index 72d85a5..cd74fb2 100644
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -461,8 +461,6 @@ MODULE_DEVICE_TABLE(pci, snd_audiopci_ids);
  *  constants
  */
 
-#define POLL_COUNT	0xa000
-
 #ifdef CHIP1370
 static unsigned int snd_es1370_fixed_rates[] =
 	{5512, 11025, 22050, 44100};
@@ -514,14 +512,16 @@ static const unsigned int snd_ensoniq_sample_shift[] =
 
 static unsigned int snd_es1371_wait_src_ready(struct ensoniq * ensoniq)
 {
-	unsigned int t, r = 0;
+	unsigned int r = 0;
+	unsigned long end_time;
 
-	for (t = 0; t < POLL_COUNT; t++) {
+	end_time = jiffies + msecs_to_jiffies(100);
+	do {
 		r = inl(ES_REG(ensoniq, 1371_SMPRATE));
 		if ((r & ES_1371_SRC_RAM_BUSY) == 0)
 			return r;
-		cond_resched();
-	}
+		schedule_timeout_uninterruptible(1);
+	} while (time_after_eq(end_time, jiffies));
 	snd_printk(KERN_ERR "wait source ready timeout 0x%lx [0x%x]\n",
 		   ES_REG(ensoniq, 1371_SMPRATE), r);
 	return 0;
@@ -529,7 +529,7 @@ static unsigned int snd_es1371_wait_src_ready(struct ensoniq * ensoniq)
 
 static unsigned int snd_es1371_src_read(struct ensoniq * ensoniq, unsigned short reg)
 {
-	unsigned int temp, i, orig, r;
+	unsigned int temp, orig, r;
 
 	/* wait for ready */
 	temp = orig = snd_es1371_wait_src_ready(ensoniq);
@@ -545,11 +545,13 @@ static unsigned int snd_es1371_src_read(struct ensoniq * ensoniq, unsigned short
 	
 	if ((temp & 0x00870000) != 0x00010000) {
 		/* wait for the right state */
-		for (i = 0; i < POLL_COUNT; i++) {
+		unsigned long end_time = jiffies + msecs_to_jiffies(100);
+		do {
 			temp = inl(ES_REG(ensoniq, 1371_SMPRATE));
 			if ((temp & 0x00870000) == 0x00010000)
 				break;
-		}
+			schedule_timeout_uninterruptible(1);
+		} while (time_after_eq(end_time, jiffies));
 	}
 
 	/* hide the state bits */	
@@ -602,104 +604,90 @@ static void snd_es1370_codec_write(struct snd_ak4531 *ak4531,
 
 #ifdef CHIP1371
 
+static int _es1371_wait_wip(struct ensoniq *ensoniq)
+{
+	unsigned long end_time;
+
+	end_time = jiffies + msecs_to_jiffies(100);
+	do {
+		if (!(inl(ES_REG(ensoniq, 1371_CODEC)) & ES_1371_CODEC_WIP))
+			return 0;
+	} while (time_after_eq(end_time, jiffies));
+	snd_printk(KERN_ERR "codec wait timeout, status = 0x%x\n",
+		   inl(ES_REG(ensoniq, 1371_CODEC)));
+	return -EINVAL;
+}
+
+static void _es1371_codec_write(struct ensoniq *ensoniq,
+				unsigned int val)
+{
+	unsigned int x;
+	unsigned long end_time;
+
+	_es1371_wait_wip(ensoniq);
+	/* save the current state for latter */
+	x = snd_es1371_wait_src_ready(ensoniq);
+	outl((x & (ES_1371_SRC_DISABLE | ES_1371_DIS_P1 |
+		   ES_1371_DIS_P2 | ES_1371_DIS_R1)) | 0x00010000,
+	     ES_REG(ensoniq, 1371_SMPRATE));
+	/* wait for not busy (state 0) first to avoid
+	   transition states */
+	end_time = jiffies + msecs_to_jiffies(100);
+	do {
+		if ((inl(ES_REG(ensoniq, 1371_SMPRATE)) & 0x00870000) ==
+		    0x00000000)
+			break;
+	} while (time_after_eq(end_time, jiffies));
+	/* wait for a SAFE time to write addr/data and then do it, dammit */
+	end_time = jiffies + msecs_to_jiffies(100);
+	do {
+		if ((inl(ES_REG(ensoniq, 1371_SMPRATE)) & 0x00870000) ==
+		    0x00010000)
+			break;
+	} while (time_after_eq(end_time, jiffies));
+	outl(val, ES_REG(ensoniq, 1371_CODEC));
+	/* restore SRC reg */
+	snd_es1371_wait_src_ready(ensoniq);
+	outl(x, ES_REG(ensoniq, 1371_SMPRATE));
+}
+
 static void snd_es1371_codec_write(struct snd_ac97 *ac97,
 				   unsigned short reg, unsigned short val)
 {
 	struct ensoniq *ensoniq = ac97->private_data;
-	unsigned int t, x;
 
 	mutex_lock(&ensoniq->src_mutex);
-	for (t = 0; t < POLL_COUNT; t++) {
-		if (!(inl(ES_REG(ensoniq, 1371_CODEC)) & ES_1371_CODEC_WIP)) {
-			/* save the current state for latter */
-			x = snd_es1371_wait_src_ready(ensoniq);
-			outl((x & (ES_1371_SRC_DISABLE | ES_1371_DIS_P1 |
-			           ES_1371_DIS_P2 | ES_1371_DIS_R1)) | 0x00010000,
-			     ES_REG(ensoniq, 1371_SMPRATE));
-			/* wait for not busy (state 0) first to avoid
-			   transition states */
-			for (t = 0; t < POLL_COUNT; t++) {
-				if ((inl(ES_REG(ensoniq, 1371_SMPRATE)) & 0x00870000) ==
-				    0x00000000)
-					break;
-			}
-			/* wait for a SAFE time to write addr/data and then do it, dammit */
-			for (t = 0; t < POLL_COUNT; t++) {
-				if ((inl(ES_REG(ensoniq, 1371_SMPRATE)) & 0x00870000) ==
-				    0x00010000)
-					break;
-			}
-			outl(ES_1371_CODEC_WRITE(reg, val), ES_REG(ensoniq, 1371_CODEC));
-			/* restore SRC reg */
-			snd_es1371_wait_src_ready(ensoniq);
-			outl(x, ES_REG(ensoniq, 1371_SMPRATE));
-			mutex_unlock(&ensoniq->src_mutex);
-			return;
-		}
-	}
+	_es1371_codec_write(ensoniq, ES_1371_CODEC_WRITE(reg, val));
 	mutex_unlock(&ensoniq->src_mutex);
-	snd_printk(KERN_ERR "codec write timeout at 0x%lx [0x%x]\n",
-		   ES_REG(ensoniq, 1371_CODEC), inl(ES_REG(ensoniq, 1371_CODEC)));
 }
 
 static unsigned short snd_es1371_codec_read(struct snd_ac97 *ac97,
 					    unsigned short reg)
 {
 	struct ensoniq *ensoniq = ac97->private_data;
-	unsigned int t, x, fail = 0;
+	unsigned int fail;
+	unsigned long end_time;
 
-      __again:
 	mutex_lock(&ensoniq->src_mutex);
-	for (t = 0; t < POLL_COUNT; t++) {
-		if (!(inl(ES_REG(ensoniq, 1371_CODEC)) & ES_1371_CODEC_WIP)) {
-			/* save the current state for latter */
-			x = snd_es1371_wait_src_ready(ensoniq);
-			outl((x & (ES_1371_SRC_DISABLE | ES_1371_DIS_P1 |
-			           ES_1371_DIS_P2 | ES_1371_DIS_R1)) | 0x00010000,
-			     ES_REG(ensoniq, 1371_SMPRATE));
-			/* wait for not busy (state 0) first to avoid
-			   transition states */
-			for (t = 0; t < POLL_COUNT; t++) {
-				if ((inl(ES_REG(ensoniq, 1371_SMPRATE)) & 0x00870000) ==
-				    0x00000000)
-					break;
+	for (fail = 0; fail < 10; fail++) {
+		_es1371_codec_write(ensoniq, ES_1371_CODEC_READS(reg));
+		/* wait for WIP again */
+		_es1371_wait_wip(ensoniq);
+		/* now wait for the stinkin' data (RDY) */
+		end_time = jiffies + msecs_to_jiffies(100);
+		do {
+			unsigned int x = inl(ES_REG(ensoniq, 1371_CODEC));
+			if (x & ES_1371_CODEC_RDY) {
+				mutex_unlock(&ensoniq->src_mutex);
+				return ES_1371_CODEC_READ(x);
 			}
-			/* wait for a SAFE time to write addr/data and then do it, dammit */
-			for (t = 0; t < POLL_COUNT; t++) {
-				if ((inl(ES_REG(ensoniq, 1371_SMPRATE)) & 0x00870000) ==
-				    0x00010000)
-					break;
-			}
-			outl(ES_1371_CODEC_READS(reg), ES_REG(ensoniq, 1371_CODEC));
-			/* restore SRC reg */
-			snd_es1371_wait_src_ready(ensoniq);
-			outl(x, ES_REG(ensoniq, 1371_SMPRATE));
-			/* wait for WIP again */
-			for (t = 0; t < POLL_COUNT; t++) {
-				if (!(inl(ES_REG(ensoniq, 1371_CODEC)) & ES_1371_CODEC_WIP))
-					break;		
-			}
-			/* now wait for the stinkin' data (RDY) */
-			for (t = 0; t < POLL_COUNT; t++) {
-				if ((x = inl(ES_REG(ensoniq, 1371_CODEC))) & ES_1371_CODEC_RDY) {
-					mutex_unlock(&ensoniq->src_mutex);
-					return ES_1371_CODEC_READ(x);
-				}
-			}
-			mutex_unlock(&ensoniq->src_mutex);
-			if (++fail > 10) {
-				snd_printk(KERN_ERR "codec read timeout (final) "
-					   "at 0x%lx, reg = 0x%x [0x%x]\n",
-					   ES_REG(ensoniq, 1371_CODEC), reg,
-					   inl(ES_REG(ensoniq, 1371_CODEC)));
-				return 0;
-			}
-			goto __again;
-		}
+		} while (time_after_eq(end_time, jiffies));
 	}
+	snd_printk(KERN_ERR "codec read timeout (final) "
+		   "at 0x%lx, reg = 0x%x [0x%x]\n",
+		   ES_REG(ensoniq, 1371_CODEC), reg,
+		   inl(ES_REG(ensoniq, 1371_CODEC)));
 	mutex_unlock(&ensoniq->src_mutex);
-	snd_printk(KERN_ERR "es1371: codec read timeout at 0x%lx [0x%x]\n",
-		   ES_REG(ensoniq, 1371_CODEC), inl(ES_REG(ensoniq, 1371_CODEC)));
 	return 0;
 }
 

--------------000401020404020704050700
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------000401020404020704050700--
