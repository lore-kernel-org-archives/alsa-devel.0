From: Klaus Steinberger <Klaus.Steinberger@Physik.Uni-Muenchen.DE>
Subject: Problem compiling alsa-driver-0.9.5 for SMP kernel
Date: Tue, 15 Jul 2003 17:11:40 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F1419AC.1090406@Physik.Uni-Muenchen.DE>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070703080600010105010003"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070703080600010105010003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I'm not sure if this is already reported, but I found nothing in the 
mail-archive about it.

There are some files inside alsa-driver Version 0.9.5, which do not 
compile for an SMP Kernel because of some mistypings with spinlock 
Variables.

1. i2c/other/ak4117.c doesn't compile because of incompatible types

    This is due to a incorrect definition of the lock variable in ak4117

2. pcmcia/pdaudiocf/pdaudiocf_core.c doesn't compile due to the use
    of undefined spinlock variables. I changed that, but I'm not quite
    if I did the right thing

3. pcmcia/pdaudiocf/pdaudiocf_pcm.c doesn't compile because of a typo
    with spinlock Variables.

I append my patch against this.

Sincerely,
Klaus Steinberger

-- 
Klaus Steinberger         Maier-Leibnitz Labor
Phone: (+49 89)289 14287  Am Coulombwall 6, D-85748 Garching, Germany
FAX:   (+49 89)289 14280  EMail: Klaus.Steinberger@Physik.Uni-Muenchen.DE
URL: http://www.physik.uni-muenchen.de/~k2/

In a world without Walls and Fences, who needs Windows and Gates

--------------070703080600010105010003
Content-Type: text/plain;
 name="alsa-driver-0.9.5-spinlock_t.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-driver-0.9.5-spinlock_t.patch"

--- alsa-driver-0.9.5/include/ak4117.h.spinlock_t	2003-07-15 13:05:22.000000000 +0200
+++ alsa-driver-0.9.5/include/ak4117.h	2003-07-15 13:05:37.000000000 +0200
@@ -163,7 +163,7 @@
 	ak4117_read_t * read;
 	void * private_data;
 	unsigned int init: 1;
-	spinlock_t * lock;
+	spinlock_t  lock;
 	unsigned char regmap[5];
 	snd_kcontrol_t *kctls[AK4117_CONTROLS];
 	snd_pcm_substream_t *substream;
--- alsa-driver-0.9.5/pcmcia/pdaudiocf/pdaudiocf_core.c.spinlock_t	2003-07-15 13:42:27.000000000 +0200
+++ alsa-driver-0.9.5/pcmcia/pdaudiocf/pdaudiocf_core.c	2003-07-15 13:42:39.000000000 +0200
@@ -133,8 +133,7 @@
 	if (chip == NULL)
 		return NULL;
 	chip->card = card;
-	spin_lock_init(&chip->lock);
-	spin_lock_init(&chip->irq_lock);
+	spin_lock_init(&chip->reg_lock);
 	spin_lock_init(&chip->ak4117_lock);
 	tasklet_init(&chip->tq, pdacf_tasklet, (unsigned long)chip);
 	card->private_data = chip;
--- alsa-driver-0.9.5/pcmcia/pdaudiocf/pdaudiocf_pcm.c.spinlock_t	2003-07-15 13:43:56.000000000 +0200
+++ alsa-driver-0.9.5/pcmcia/pdaudiocf/pdaudiocf_pcm.c	2003-07-15 13:44:13.000000000 +0200
@@ -126,7 +126,7 @@
 	tmp |= val;
 	pdacf_reg_write(chip, PDAUDIOCF_REG_SCR, tmp);
       __end:
-	spin_unlock(&chip_reg_lock);
+	spin_unlock(&chip->reg_lock);
 	if (cmd == SNDRV_PCM_TRIGGER_STOP)
 		pdacf_reinit(chip, 0);
 	snd_ak4117_check_rate_and_errors(chip->ak4117, AK4117_CHECK_NO_RATE);

--------------070703080600010105010003--



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
