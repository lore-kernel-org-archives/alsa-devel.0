From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 12/12] ALSA: emu10k1: Fix missing __force
	annotation for user/kernel pointer cast
Date: Wed, 25 Jul 2018 23:00:57 +0200
Message-ID: <20180725210057.18017-13-tiwai@suse.de>
References: <20180725210057.18017-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D4A5D26778A
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:01:05 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id E1351B381
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 21:01:03 +0000 (UTC)
In-Reply-To: <20180725210057.18017-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The cast between user-space and kernel-space needs an explicit __force
prefix, but it's missing in many places in emu10k1 driver code.

Spotted by sparse as a warning like:
  sound/pci/emu10k1/emufx.c:529:33: warning: cast removes address space of expression

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/emu10k1/emufx.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
index de2ecbe95d6c..90713741c2dc 100644
--- a/sound/pci/emu10k1/emufx.c
+++ b/sound/pci/emu10k1/emufx.c
@@ -526,7 +526,7 @@ static int snd_emu10k1_gpr_poke(struct snd_emu10k1 *emu,
 		if (!test_bit(gpr, icode->gpr_valid))
 			continue;
 		if (in_kernel)
-			val = *(u32 *)&icode->gpr_map[gpr];
+			val = *(__force u32 *)&icode->gpr_map[gpr];
 		else if (get_user(val, &icode->gpr_map[gpr]))
 			return -EFAULT;
 		snd_emu10k1_ptr_write(emu, emu->gpr_base + gpr, 0, val);
@@ -560,8 +560,8 @@ static int snd_emu10k1_tram_poke(struct snd_emu10k1 *emu,
 		if (!test_bit(tram, icode->tram_valid))
 			continue;
 		if (in_kernel) {
-			val = *(u32 *)&icode->tram_data_map[tram];
-			addr = *(u32 *)&icode->tram_addr_map[tram];
+			val = *(__force u32 *)&icode->tram_data_map[tram];
+			addr = *(__force u32 *)&icode->tram_addr_map[tram];
 		} else {
 			if (get_user(val, &icode->tram_data_map[tram]) ||
 			    get_user(addr, &icode->tram_addr_map[tram]))
@@ -611,8 +611,8 @@ static int snd_emu10k1_code_poke(struct snd_emu10k1 *emu,
 		if (!test_bit(pc / 2, icode->code_valid))
 			continue;
 		if (in_kernel) {
-			lo = *(u32 *)&icode->code[pc + 0];
-			hi = *(u32 *)&icode->code[pc + 1];
+			lo = *(__force u32 *)&icode->code[pc + 0];
+			hi = *(__force u32 *)&icode->code[pc + 1];
 		} else {
 			if (get_user(lo, &icode->code[pc + 0]) ||
 			    get_user(hi, &icode->code[pc + 1]))
@@ -666,7 +666,7 @@ static unsigned int *copy_tlv(const unsigned int __user *_tlv, bool in_kernel)
 	if (!_tlv)
 		return NULL;
 	if (in_kernel)
-		memcpy(data, (void *)_tlv, sizeof(data));
+		memcpy(data, (__force void *)_tlv, sizeof(data));
 	else if (copy_from_user(data, _tlv, sizeof(data)))
 		return NULL;
 	if (data[1] >= MAX_TLV_SIZE)
@@ -676,7 +676,7 @@ static unsigned int *copy_tlv(const unsigned int __user *_tlv, bool in_kernel)
 		return NULL;
 	memcpy(tlv, data, sizeof(data));
 	if (in_kernel) {
-		memcpy(tlv + 2, (void *)(_tlv + 2),  data[1]);
+		memcpy(tlv + 2, (__force void *)(_tlv + 2),  data[1]);
 	} else if (copy_from_user(tlv + 2, _tlv + 2, data[1])) {
 		kfree(tlv);
 		return NULL;
@@ -693,7 +693,7 @@ static int copy_gctl(struct snd_emu10k1 *emu,
 
 	if (emu->support_tlv) {
 		if (in_kernel)
-			memcpy(gctl, (void *)&_gctl[idx], sizeof(*gctl));
+			memcpy(gctl, (__force void *)&_gctl[idx], sizeof(*gctl));
 		else if (copy_from_user(gctl, &_gctl[idx], sizeof(*gctl)))
 			return -EFAULT;
 		return 0;
@@ -701,7 +701,7 @@ static int copy_gctl(struct snd_emu10k1 *emu,
 
 	octl = (struct snd_emu10k1_fx8010_control_old_gpr __user *)_gctl;
 	if (in_kernel)
-		memcpy(gctl, (void *)&octl[idx], sizeof(*octl));
+		memcpy(gctl, (__force void *)&octl[idx], sizeof(*octl));
 	else if (copy_from_user(gctl, &octl[idx], sizeof(*octl)))
 		return -EFAULT;
 	gctl->tlv = NULL;
@@ -735,7 +735,7 @@ static int snd_emu10k1_verify_controls(struct snd_emu10k1 *emu,
 	for (i = 0, _id = icode->gpr_del_controls;
 	     i < icode->gpr_del_control_count; i++, _id++) {
 		if (in_kernel)
-			id = *(struct snd_ctl_elem_id *)_id;
+			id = *(__force struct snd_ctl_elem_id *)_id;
 		else if (copy_from_user(&id, _id, sizeof(id)))
 	     		return -EFAULT;
 		if (snd_emu10k1_look_for_ctl(emu, &id) == NULL)
@@ -833,7 +833,7 @@ static int snd_emu10k1_add_controls(struct snd_emu10k1 *emu,
 		knew.device = gctl->id.device;
 		knew.subdevice = gctl->id.subdevice;
 		knew.info = snd_emu10k1_gpr_ctl_info;
-		knew.tlv.p = copy_tlv(gctl->tlv, in_kernel);
+		knew.tlv.p = copy_tlv((__force const unsigned int __user *)gctl->tlv, in_kernel);
 		if (knew.tlv.p)
 			knew.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
 				SNDRV_CTL_ELEM_ACCESS_TLV_READ;
@@ -897,7 +897,7 @@ static int snd_emu10k1_del_controls(struct snd_emu10k1 *emu,
 	for (i = 0, _id = icode->gpr_del_controls;
 	     i < icode->gpr_del_control_count; i++, _id++) {
 		if (in_kernel)
-			id = *(struct snd_ctl_elem_id *)_id;
+			id = *(__force struct snd_ctl_elem_id *)_id;
 		else if (copy_from_user(&id, _id, sizeof(id)))
 			return -EFAULT;
 		down_write(&card->controls_rwsem);
-- 
2.18.0
