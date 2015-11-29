From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] ALSA: i2c: constify snd_i2c_ops structures
Date: Sun, 29 Nov 2015 18:25:24 +0100
Message-ID: <1448817924-17447-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A1A7265353
 for <alsa-devel@alsa-project.org>; Sun, 29 Nov 2015 18:37:24 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The snd_i2c_ops structures are never modified, so declare them as const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 include/sound/i2c.h       |    2 +-
 sound/i2c/i2c.c           |    2 +-
 sound/pci/ice1712/delta.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/sound/i2c.h b/include/sound/i2c.h
index d125ff8..835254d 100644
--- a/include/sound/i2c.h
+++ b/include/sound/i2c.h
@@ -66,7 +66,7 @@ struct snd_i2c_bus {
 		struct snd_i2c_bit_ops *bit;
 		void *ops;
 	} hw_ops;		/* lowlevel operations */
-	struct snd_i2c_ops *ops;	/* midlevel operations */
+	const struct snd_i2c_ops *ops;	/* midlevel operations */
 
 	unsigned long private_value;
 	void *private_data;
diff --git a/sound/i2c/i2c.c b/sound/i2c/i2c.c
index 4677037..ef2a9af 100644
--- a/sound/i2c/i2c.c
+++ b/sound/i2c/i2c.c
@@ -39,7 +39,7 @@ static int snd_i2c_bit_readbytes(struct snd_i2c_device *device,
 static int snd_i2c_bit_probeaddr(struct snd_i2c_bus *bus,
 				 unsigned short addr);
 
-static struct snd_i2c_ops snd_i2c_bit_ops = {
+static const struct snd_i2c_ops snd_i2c_bit_ops = {
 	.sendbytes = snd_i2c_bit_sendbytes,
 	.readbytes = snd_i2c_bit_readbytes,
 	.probeaddr = snd_i2c_bit_probeaddr,
diff --git a/sound/pci/ice1712/delta.c b/sound/pci/ice1712/delta.c
index 496dbd0..3bfdc78 100644
--- a/sound/pci/ice1712/delta.c
+++ b/sound/pci/ice1712/delta.c
@@ -174,7 +174,7 @@ static int ap_cs8427_probeaddr(struct snd_i2c_bus *bus, unsigned short addr)
 	return -ENOENT;
 }
 
-static struct snd_i2c_ops ap_cs8427_i2c_ops = {
+static const struct snd_i2c_ops ap_cs8427_i2c_ops = {
 	.sendbytes = ap_cs8427_sendbytes,
 	.readbytes = ap_cs8427_readbytes,
 	.probeaddr = ap_cs8427_probeaddr,
