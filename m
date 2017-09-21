From: Thomas Meyer <thomas@m3y3r.de>
Subject: [PATCH 4/4] ALSA: emu10k1: Cocci spatch "alloc_cast"
Date: Thu, 21 Sep 2017 08:33:46 +0200
Message-ID: <1505975570447-568224618-4-diffsplit-thomas@m3y3r.de>
References: <1505975570447-826702259-0-diffsplit-thomas@m3y3r.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1505975570447-826702259-0-diffsplit-thomas@m3y3r.de>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Remove casting the values returned by memory allocation functions like
kmalloc, kzalloc, kmem_cache_alloc, kmem_cache_zalloc etc."
Found by coccinelle spatch "api/alloc/alloc_cast.cocci"

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
--- a/sound/pci/emu10k1/emufx.c
+++ b/sound/pci/emu10k1/emufx.c
@@ -1218,7 +1218,7 @@ static int _snd_emu10k1_audigy_init_efx(
 	if (!icode)
 		return err;
 
-	icode->gpr_map = (u_int32_t __user *) kcalloc(512 + 256 + 256 + 2 * 1024,
+	icode->gpr_map = kcalloc(512 + 256 + 256 + 2 * 1024,
 						      sizeof(u_int32_t), GFP_KERNEL);
 	if (!icode->gpr_map)
 		goto __err_gpr;
@@ -1853,7 +1853,7 @@ static int _snd_emu10k1_init_efx(struct
 	if (!icode)
 		return err;
 
-	icode->gpr_map = (u_int32_t __user *) kcalloc(256 + 160 + 160 + 2 * 512,
+	icode->gpr_map = kcalloc(256 + 160 + 160 + 2 * 512,
 						      sizeof(u_int32_t), GFP_KERNEL);
 	if (!icode->gpr_map)
 		goto __err_gpr;
