From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: emu10k1: Get rid of set_fs() usage
Date: Tue, 16 May 2017 09:32:00 +0200
Message-ID: <20170516073200.29504-3-tiwai@suse.de>
References: <20170516073200.29504-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 616EB2674CE
 for <alsa-devel@alsa-project.org>; Tue, 16 May 2017 09:32:02 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id D68BDABF2
 for <alsa-devel@alsa-project.org>; Tue, 16 May 2017 07:32:01 +0000 (UTC)
In-Reply-To: <20170516073200.29504-1-tiwai@suse.de>
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

Instead of set_fs() hackery, do the straight memcpy() by passing a
flag indicating the kernel space operation.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/emu10k1/emufx.c | 127 ++++++++++++++++++++++++++--------------------
 1 file changed, 73 insertions(+), 54 deletions(-)

diff --git a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
index 56fc47bd6dba..dc585959ca32 100644
--- a/sound/pci/emu10k1/emufx.c
+++ b/sound/pci/emu10k1/emufx.c
@@ -311,21 +311,6 @@ static const u32 onoff_table[2] = {
 };
 
 /*
- */
- 
-static inline mm_segment_t snd_enter_user(void)
-{
-	mm_segment_t fs = get_fs();
-	set_fs(get_ds());
-	return fs;
-}
-
-static inline void snd_leave_user(mm_segment_t fs)
-{
-	set_fs(fs);
-}
-
-/*
  *   controls
  */
 
@@ -538,7 +523,8 @@ unsigned int snd_emu10k1_efx_read(struct snd_emu10k1 *emu, unsigned int pc)
 }
 
 static int snd_emu10k1_gpr_poke(struct snd_emu10k1 *emu,
-				struct snd_emu10k1_fx8010_code *icode)
+				struct snd_emu10k1_fx8010_code *icode,
+				bool in_kernel)
 {
 	int gpr;
 	u32 val;
@@ -546,7 +532,9 @@ static int snd_emu10k1_gpr_poke(struct snd_emu10k1 *emu,
 	for (gpr = 0; gpr < (emu->audigy ? 0x200 : 0x100); gpr++) {
 		if (!test_bit(gpr, icode->gpr_valid))
 			continue;
-		if (get_user(val, &icode->gpr_map[gpr]))
+		if (in_kernel)
+			val = *(u32 *)&icode->gpr_map[gpr];
+		else if (get_user(val, &icode->gpr_map[gpr]))
 			return -EFAULT;
 		snd_emu10k1_ptr_write(emu, emu->gpr_base + gpr, 0, val);
 	}
@@ -569,7 +557,8 @@ static int snd_emu10k1_gpr_peek(struct snd_emu10k1 *emu,
 }
 
 static int snd_emu10k1_tram_poke(struct snd_emu10k1 *emu,
-				 struct snd_emu10k1_fx8010_code *icode)
+				 struct snd_emu10k1_fx8010_code *icode,
+				 bool in_kernel)
 {
 	int tram;
 	u32 addr, val;
@@ -577,9 +566,14 @@ static int snd_emu10k1_tram_poke(struct snd_emu10k1 *emu,
 	for (tram = 0; tram < (emu->audigy ? 0x100 : 0xa0); tram++) {
 		if (!test_bit(tram, icode->tram_valid))
 			continue;
-		if (get_user(val, &icode->tram_data_map[tram]) ||
-		    get_user(addr, &icode->tram_addr_map[tram]))
-			return -EFAULT;
+		if (in_kernel) {
+			val = *(u32 *)&icode->tram_data_map[tram];
+			addr = *(u32 *)&icode->tram_addr_map[tram];
+		} else {
+			if (get_user(val, &icode->tram_data_map[tram]) ||
+			    get_user(addr, &icode->tram_addr_map[tram]))
+				return -EFAULT;
+		}
 		snd_emu10k1_ptr_write(emu, TANKMEMDATAREGBASE + tram, 0, val);
 		if (!emu->audigy) {
 			snd_emu10k1_ptr_write(emu, TANKMEMADDRREGBASE + tram, 0, addr);
@@ -615,16 +609,22 @@ static int snd_emu10k1_tram_peek(struct snd_emu10k1 *emu,
 }
 
 static int snd_emu10k1_code_poke(struct snd_emu10k1 *emu,
-				 struct snd_emu10k1_fx8010_code *icode)
+				 struct snd_emu10k1_fx8010_code *icode,
+				 bool in_kernel)
 {
 	u32 pc, lo, hi;
 
 	for (pc = 0; pc < (emu->audigy ? 2*1024 : 2*512); pc += 2) {
 		if (!test_bit(pc / 2, icode->code_valid))
 			continue;
-		if (get_user(lo, &icode->code[pc + 0]) ||
-		    get_user(hi, &icode->code[pc + 1]))
-			return -EFAULT;
+		if (in_kernel) {
+			lo = *(u32 *)&icode->code[pc + 0];
+			hi = *(u32 *)&icode->code[pc + 1];
+		} else {
+			if (get_user(lo, &icode->code[pc + 0]) ||
+			    get_user(hi, &icode->code[pc + 1]))
+				return -EFAULT;
+		}
 		snd_emu10k1_efx_write(emu, pc + 0, lo);
 		snd_emu10k1_efx_write(emu, pc + 1, hi);
 	}
@@ -665,14 +665,16 @@ snd_emu10k1_look_for_ctl(struct snd_emu10k1 *emu, struct snd_ctl_elem_id *id)
 
 #define MAX_TLV_SIZE	256
 
-static unsigned int *copy_tlv(const unsigned int __user *_tlv)
+static unsigned int *copy_tlv(const unsigned int __user *_tlv, bool in_kernel)
 {
 	unsigned int data[2];
 	unsigned int *tlv;
 
 	if (!_tlv)
 		return NULL;
-	if (copy_from_user(data, _tlv, sizeof(data)))
+	if (in_kernel)
+		memcpy(data, (void *)_tlv, sizeof(data));
+	else if (copy_from_user(data, _tlv, sizeof(data)))
 		return NULL;
 	if (data[1] >= MAX_TLV_SIZE)
 		return NULL;
@@ -680,7 +682,9 @@ static unsigned int *copy_tlv(const unsigned int __user *_tlv)
 	if (!tlv)
 		return NULL;
 	memcpy(tlv, data, sizeof(data));
-	if (copy_from_user(tlv + 2, _tlv + 2, data[1])) {
+	if (in_kernel) {
+		memcpy(tlv + 2, (void *)(_tlv + 2),  data[1]);
+	} else if (copy_from_user(tlv + 2, _tlv + 2, data[1])) {
 		kfree(tlv);
 		return NULL;
 	}
@@ -690,7 +694,7 @@ static unsigned int *copy_tlv(const unsigned int __user *_tlv)
 static int copy_gctl(struct snd_emu10k1 *emu,
 		     struct snd_emu10k1_fx8010_control_gpr *gctl,
 		     struct snd_emu10k1_fx8010_control_gpr __user *_gctl,
-		     int idx)
+		     int idx, bool in_kernel)
 {
 	struct snd_emu10k1_fx8010_control_old_gpr __user *octl;
 
@@ -718,7 +722,8 @@ static int copy_gctl_to_user(struct snd_emu10k1 *emu,
 }
 
 static int snd_emu10k1_verify_controls(struct snd_emu10k1 *emu,
-				       struct snd_emu10k1_fx8010_code *icode)
+				       struct snd_emu10k1_fx8010_code *icode,
+				       bool in_kernel)
 {
 	unsigned int i;
 	struct snd_ctl_elem_id __user *_id;
@@ -728,7 +733,9 @@ static int snd_emu10k1_verify_controls(struct snd_emu10k1 *emu,
 	
 	for (i = 0, _id = icode->gpr_del_controls;
 	     i < icode->gpr_del_control_count; i++, _id++) {
-	     	if (copy_from_user(&id, _id, sizeof(id)))
+		if (in_kernel)
+			id = *(struct snd_ctl_elem_id *)_id;
+		else if (copy_from_user(&id, _id, sizeof(id)))
 	     		return -EFAULT;
 		if (snd_emu10k1_look_for_ctl(emu, &id) == NULL)
 			return -ENOENT;
@@ -738,7 +745,8 @@ static int snd_emu10k1_verify_controls(struct snd_emu10k1 *emu,
 		return -ENOMEM;
 	err = 0;
 	for (i = 0; i < icode->gpr_add_control_count; i++) {
-		if (copy_gctl(emu, gctl, icode->gpr_add_controls, i)) {
+		if (copy_gctl(emu, gctl, icode->gpr_add_controls, i,
+			      in_kernel)) {
 			err = -EFAULT;
 			goto __error;
 		}
@@ -759,7 +767,8 @@ static int snd_emu10k1_verify_controls(struct snd_emu10k1 *emu,
 	}
 	for (i = 0; i < icode->gpr_list_control_count; i++) {
 	     	/* FIXME: we need to check the WRITE access */
-		if (copy_gctl(emu, gctl, icode->gpr_list_controls, i)) {
+		if (copy_gctl(emu, gctl, icode->gpr_list_controls, i,
+			      in_kernel)) {
 			err = -EFAULT;
 			goto __error;
 		}
@@ -781,7 +790,8 @@ static void snd_emu10k1_ctl_private_free(struct snd_kcontrol *kctl)
 }
 
 static int snd_emu10k1_add_controls(struct snd_emu10k1 *emu,
-				    struct snd_emu10k1_fx8010_code *icode)
+				    struct snd_emu10k1_fx8010_code *icode,
+				    bool in_kernel)
 {
 	unsigned int i, j;
 	struct snd_emu10k1_fx8010_control_gpr *gctl;
@@ -800,7 +810,8 @@ static int snd_emu10k1_add_controls(struct snd_emu10k1 *emu,
 	}
 
 	for (i = 0; i < icode->gpr_add_control_count; i++) {
-		if (copy_gctl(emu, gctl, icode->gpr_add_controls, i)) {
+		if (copy_gctl(emu, gctl, icode->gpr_add_controls, i,
+			      in_kernel)) {
 			err = -EFAULT;
 			goto __error;
 		}
@@ -821,7 +832,7 @@ static int snd_emu10k1_add_controls(struct snd_emu10k1 *emu,
 		knew.device = gctl->id.device;
 		knew.subdevice = gctl->id.subdevice;
 		knew.info = snd_emu10k1_gpr_ctl_info;
-		knew.tlv.p = copy_tlv(gctl->tlv);
+		knew.tlv.p = copy_tlv(gctl->tlv, in_kernel);
 		if (knew.tlv.p)
 			knew.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
 				SNDRV_CTL_ELEM_ACCESS_TLV_READ;
@@ -873,7 +884,8 @@ static int snd_emu10k1_add_controls(struct snd_emu10k1 *emu,
 }
 
 static int snd_emu10k1_del_controls(struct snd_emu10k1 *emu,
-				    struct snd_emu10k1_fx8010_code *icode)
+				    struct snd_emu10k1_fx8010_code *icode,
+				    bool in_kernel)
 {
 	unsigned int i;
 	struct snd_ctl_elem_id id;
@@ -883,7 +895,9 @@ static int snd_emu10k1_del_controls(struct snd_emu10k1 *emu,
 	
 	for (i = 0, _id = icode->gpr_del_controls;
 	     i < icode->gpr_del_control_count; i++, _id++) {
-	     	if (copy_from_user(&id, _id, sizeof(id)))
+		if (in_kernel)
+			id = *(struct snd_ctl_elem_id *)_id;
+		else if (copy_from_user(&id, _id, sizeof(id)))
 			return -EFAULT;
 		down_write(&card->controls_rwsem);
 		ctl = snd_emu10k1_look_for_ctl(emu, &id);
@@ -941,12 +955,14 @@ static int snd_emu10k1_list_controls(struct snd_emu10k1 *emu,
 }
 
 static int snd_emu10k1_icode_poke(struct snd_emu10k1 *emu,
-				  struct snd_emu10k1_fx8010_code *icode)
+				  struct snd_emu10k1_fx8010_code *icode,
+				  bool in_kernel)
 {
 	int err = 0;
 
 	mutex_lock(&emu->fx8010.lock);
-	if ((err = snd_emu10k1_verify_controls(emu, icode)) < 0)
+	err = snd_emu10k1_verify_controls(emu, icode, in_kernel);
+	if (err < 0)
 		goto __error;
 	strlcpy(emu->fx8010.name, icode->name, sizeof(emu->fx8010.name));
 	/* stop FX processor - this may be dangerous, but it's better to miss
@@ -956,11 +972,20 @@ static int snd_emu10k1_icode_poke(struct snd_emu10k1 *emu,
 	else
 		snd_emu10k1_ptr_write(emu, DBG, 0, emu->fx8010.dbg | EMU10K1_DBG_SINGLE_STEP);
 	/* ok, do the main job */
-	if ((err = snd_emu10k1_del_controls(emu, icode)) < 0 ||
-	    (err = snd_emu10k1_gpr_poke(emu, icode)) < 0 ||
-	    (err = snd_emu10k1_tram_poke(emu, icode)) < 0 ||
-	    (err = snd_emu10k1_code_poke(emu, icode)) < 0 ||
-	    (err = snd_emu10k1_add_controls(emu, icode)) < 0)
+	err = snd_emu10k1_del_controls(emu, icode, in_kernel);
+	if (err < 0)
+		goto __error;
+	err = snd_emu10k1_gpr_poke(emu, icode, in_kernel);
+	if (err < 0)
+		goto __error;
+	err = snd_emu10k1_tram_poke(emu, icode, in_kernel);
+	if (err < 0)
+		goto __error;
+	err = snd_emu10k1_code_poke(emu, icode, in_kernel);
+	if (err < 0)
+		goto __error;
+	err = snd_emu10k1_add_controls(emu, icode, in_kernel);
+	if (err < 0)
 		goto __error;
 	/* start FX processor when the DSP code is updated */
 	if (emu->audigy)
@@ -1179,7 +1204,6 @@ static int _snd_emu10k1_audigy_init_efx(struct snd_emu10k1 *emu)
 	struct snd_emu10k1_fx8010_code *icode = NULL;
 	struct snd_emu10k1_fx8010_control_gpr *controls = NULL, *ctl;
 	u32 *gpr_map;
-	mm_segment_t seg;
 
 	err = -ENOMEM;
 	icode = kzalloc(sizeof(*icode), GFP_KERNEL);
@@ -1739,13 +1763,11 @@ A_OP(icode, &ptr, iMAC0, A_GPR(var), A_GPR(var), A_GPR(vol), A_EXTIN(input))
 	while (ptr < 0x400)
 		A_OP(icode, &ptr, 0x0f, 0xc0, 0xc0, 0xcf, 0xc0);
 
-	seg = snd_enter_user();
 	icode->gpr_add_control_count = nctl;
 	icode->gpr_add_controls = (struct snd_emu10k1_fx8010_control_gpr __user *)controls;
 	emu->support_tlv = 1; /* support TLV */
-	err = snd_emu10k1_icode_poke(emu, icode);
+	err = snd_emu10k1_icode_poke(emu, icode, true);
 	emu->support_tlv = 0; /* clear again */
-	snd_leave_user(seg);
 
 __err:
 	kfree(controls);
@@ -1817,7 +1839,6 @@ static int _snd_emu10k1_init_efx(struct snd_emu10k1 *emu)
 	struct snd_emu10k1_fx8010_pcm_rec *ipcm = NULL;
 	struct snd_emu10k1_fx8010_control_gpr *controls = NULL, *ctl;
 	u32 *gpr_map;
-	mm_segment_t seg;
 
 	err = -ENOMEM;
 	icode = kzalloc(sizeof(*icode), GFP_KERNEL);
@@ -2368,13 +2389,11 @@ static int _snd_emu10k1_init_efx(struct snd_emu10k1 *emu)
 
 	if ((err = snd_emu10k1_fx8010_tram_setup(emu, ipcm->buffer_size)) < 0)
 		goto __err;
-	seg = snd_enter_user();
 	icode->gpr_add_control_count = i;
 	icode->gpr_add_controls = (struct snd_emu10k1_fx8010_control_gpr __user *)controls;
 	emu->support_tlv = 1; /* support TLV */
-	err = snd_emu10k1_icode_poke(emu, icode);
+	err = snd_emu10k1_icode_poke(emu, icode, true);
 	emu->support_tlv = 0; /* clear again */
-	snd_leave_user(seg);
 	if (err >= 0)
 		err = snd_emu10k1_ipcm_poke(emu, ipcm);
 __err:
@@ -2537,7 +2556,7 @@ static int snd_emu10k1_fx8010_ioctl(struct snd_hwdep * hw, struct file *file, un
 		icode = memdup_user(argp, sizeof(*icode));
 		if (IS_ERR(icode))
 			return PTR_ERR(icode);
-		res = snd_emu10k1_icode_poke(emu, icode);
+		res = snd_emu10k1_icode_poke(emu, icode, false);
 		kfree(icode);
 		return res;
 	case SNDRV_EMU10K1_IOCTL_CODE_PEEK:
-- 
2.12.2
