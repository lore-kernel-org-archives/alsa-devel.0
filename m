From: Benny Sjostrand <gorm@cucumelo.org>
Subject: [PATCH] cs46xx, SPDIF output fixes, AC3 through IEC958 should work
 OK
Date: Mon, 03 Mar 2003 02:25:03 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E62AEEF.7090109@cucumelo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020002020409020602040202"
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
--------------020002020409020602040202
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

With this patch AC3 through IEC958 should work OK, and synchronizations 
problems with the SPDIF output should be gone. (about SPDIF input the 
status is still the same)

I've tested it with ogle 0.9, the AC3 stuff  seems to work well, have 
not tested with xine (yet).

This patch adds a new DSP firmware routine, that makes it's possible to 
DMA from host directly to the SPDIF output. This will affect all 
playback on IEC958 device on 48khz, other rates will (should) work 
exactly as before.

- Added the cwcdma DSP firmware module
- Fixed a minor bug in cs46xx_iec958_pre_open(...)
- in cs46xx_dsp_enable_spdif_hw(...), disable SPDIF hw
 before enabling, this seems to help solving the synchronization issue
- Some changes in cs46xx_dsp_create_pcm_channel(...)  and 
cs46xx_dsp_create_src_task_scb(...) to adapt to the new DSP firmware.

Well, with the new firmware module I would consider this patch a little 
bit experimental ;)

/Benny


--------------020002020409020602040202
Content-Type: text/plain;
 name="cs46xx.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cs46xx.patch"

diff --exclude=CVS --exclude=Makefile -Naur alsa-kernel/pci/cs46xx/cs46xx_lib.c ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.c
--- alsa-kernel/pci/cs46xx/cs46xx_lib.c	Fri Feb 28 22:33:33 2003
+++ ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.c	Sun Mar  2 22:38:11 2003
@@ -321,6 +321,7 @@
 #include "imgs/cwcasync.h"
 #include "imgs/cwcsnoop.h"
 #include "imgs/cwcbinhack.h"
+#include "imgs/cwcdma.h"
 
 int snd_cs46xx_clear_BA1(cs46xx_t *chip,
                          unsigned long offset,
@@ -3165,6 +3166,11 @@
 
 	if (cs46xx_dsp_load_module(chip, &cwcbinhack_module) < 0) {
 		snd_printk(KERN_ERR "image download error [cwcbinhack]\n");
+		return -EIO;
+	}
+
+	if (cs46xx_dsp_load_module(chip, &cwcdma_module) < 0) {
+		snd_printk(KERN_ERR "image download error [cwcdma]\n");
 		return -EIO;
 	}
 
diff --exclude=CVS --exclude=Makefile -Naur alsa-kernel/pci/cs46xx/cs46xx_lib.h ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.h
--- alsa-kernel/pci/cs46xx/cs46xx_lib.h	Tue Dec 10 01:34:34 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.h	Mon Mar  3 01:45:17 2003
@@ -156,7 +156,8 @@
                                                        u16 src_buffer_addr,
                                                        u16 src_delay_buffer_addr,u32 dest,
                                                        dsp_scb_descriptor_t * parent_scb,
-                                                       int scb_child_type);
+                                                       int scb_child_type,
+						       int pass_through);
 dsp_scb_descriptor_t *  cs46xx_dsp_create_mix_only_scb(cs46xx_t * chip,char * scb_name,
                                                        u16 mix_buffer_addr,u32 dest,
                                                        dsp_scb_descriptor_t * parent_scb,
diff --exclude=CVS --exclude=Makefile -Naur alsa-kernel/pci/cs46xx/dsp_spos.c ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.c
--- alsa-kernel/pci/cs46xx/dsp_spos.c	Fri Feb 28 22:33:34 2003
+++ ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.c	Mon Mar  3 01:53:02 2003
@@ -1371,11 +1371,11 @@
 
 	/* SPDIF input sampel rate converter */
 	src_task_scb = cs46xx_dsp_create_src_task_scb(chip,"SrcTaskSCB_SPDIFI",
-						      48000,
+						      ins->spdif_in_sample_rate,
 						      SRC_OUTPUT_BUF1,
 						      SRC_DELAY_BUF1,SRCTASK_SCB_ADDR,
 						      master_mix_scb,
-						      SCB_ON_PARENT_SUBLIST_SCB);
+						      SCB_ON_PARENT_SUBLIST_SCB,0);
 
 	if (!src_task_scb) goto _fail_end;
 
@@ -1564,9 +1564,32 @@
 	return 0;
 }
 
+
+static void cs46xx_dsp_disable_spdif_hw (cs46xx_t *chip)
+{
+	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
+
+	/* set SPDIF output FIFO slot */
+	snd_cs46xx_pokeBA0(chip, BA0_ASER_FADDR, 0);
+
+	/* SPDIF output MASTER ENABLE */
+	cs46xx_poke_via_dsp (chip,SP_SPDOUT_CONTROL, 0);
+
+	/* right and left validate bit */
+	/*cs46xx_poke_via_dsp (chip,SP_SPDOUT_CSUV, ins->spdif_csuv_default);*/
+	cs46xx_poke_via_dsp (chip,SP_SPDOUT_CSUV, 0x0);
+
+	/* monitor state */
+	ins->spdif_status_out &= ~DSP_SPDIF_STATUS_HW_ENABLED;
+}
+
 int cs46xx_dsp_enable_spdif_hw (cs46xx_t *chip)
 {
 	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
+
+	/* if hw-ctrl already enabled, turn off to reset logic ... */
+	cs46xx_dsp_disable_spdif_hw (chip);
+	udelay(50);
 
 	/* set SPDIF output FIFO slot */
 	snd_cs46xx_pokeBA0(chip, BA0_ASER_FADDR, ( 0x8000 | ((SP_SPDOUT_FIFO >> 4) << 4) ));
diff --exclude=CVS --exclude=Makefile -Naur alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c ../cvs/alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c
--- alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c	Fri Feb 28 22:33:34 2003
+++ ../cvs/alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c	Mon Mar  3 01:47:50 2003
@@ -584,7 +584,8 @@
                                u16 src_buffer_addr,
                                u16 src_delay_buffer_addr,u32 dest,
                                dsp_scb_descriptor_t * parent_scb,
-                               int scb_child_type)
+                               int scb_child_type,
+	                       int pass_through)
 {
 
 	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
@@ -659,10 +660,22 @@
 		/* clear buffers */
 		_dsp_clear_sample_buffer (chip,src_buffer_addr,8);
 		_dsp_clear_sample_buffer (chip,src_delay_buffer_addr,32);
-		
-		scb = _dsp_create_generic_scb(chip,scb_name,(u32 *)&src_task_scb,
-					      dest,ins->s16_up,parent_scb,
-					      scb_child_type);
+				
+		if (pass_through) {
+			/* wont work with any other rate than
+			   the native DSP rate */
+			snd_assert (rate = 48000);
+
+			scb = cs46xx_dsp_create_generic_scb(chip,scb_name,(u32 *)&src_task_scb,
+							    dest,"DMAREADER",parent_scb,
+							    scb_child_type);
+		} else {
+			scb = _dsp_create_generic_scb(chip,scb_name,(u32 *)&src_task_scb,
+						      dest,ins->s16_up,parent_scb,
+						      scb_child_type);
+		}
+
+
 	}
 
 	return scb;
@@ -835,10 +848,10 @@
 
 		RSCONFIG_SAMPLE_16STEREO + RSCONFIG_MODULO_16,
 		0,
-		0,input_scb->address,
+      /* 0xD */ 0,input_scb->address,
 		{
-			0x8000,0x8000,
-			0x8000,0x8000
+      /* 0xE */   0x8000,0x8000,
+      /* 0xF */	  0x8000,0x8000
 		}
 	};
 
@@ -1134,9 +1147,9 @@
 	dsp_scb_descriptor_t * src_scb = NULL,* pcm_scb, * mixer_scb = NULL;
 	dsp_scb_descriptor_t * src_parent_scb = NULL;
 
-	/*dsp_scb_descriptor_t * pcm_parent_scb;*/
+	/* dsp_scb_descriptor_t * pcm_parent_scb; */
 	char scb_name[DSP_MAX_SCB_NAME];
-	int i,pcm_index = -1, insert_point, src_index = -1;
+	int i,pcm_index = -1, insert_point, src_index = -1,pass_through = 0;
 	unsigned long flags;
 
 	switch (pcm_channel_id) {
@@ -1163,7 +1176,8 @@
 		   alter the raw data stream ...) */
 		if (sample_rate == 48000) {
 			snd_printdd ("IEC958 pass through\n");
-			src_parent_scb = ins->asynch_tx_scb;
+			/* Hack to bypass creating a new SRC */
+			pass_through = 1;
 		}
 		break;
 	default:
@@ -1216,18 +1230,16 @@
 		snd_assert (src_index != -1,return NULL);
 
 		/* we need to create a new SRC SCB */
-		if (src_parent_scb == NULL) {
-			if (mixer_scb->sub_list_ptr == ins->the_null_scb) {
-				src_parent_scb = mixer_scb;
-				insert_point = SCB_ON_PARENT_SUBLIST_SCB;
-			} else {
-				src_parent_scb = find_next_free_scb(chip,mixer_scb->sub_list_ptr);
-				insert_point = SCB_ON_PARENT_NEXT_SCB;
-			}
-		} else insert_point = SCB_ON_PARENT_NEXT_SCB;
+		if (mixer_scb->sub_list_ptr == ins->the_null_scb) {
+			src_parent_scb = mixer_scb;
+			insert_point = SCB_ON_PARENT_SUBLIST_SCB;
+		} else {
+			src_parent_scb = find_next_free_scb(chip,mixer_scb->sub_list_ptr);
+			insert_point = SCB_ON_PARENT_NEXT_SCB;
+		}
 
 		snprintf (scb_name,DSP_MAX_SCB_NAME,"SrcTask_SCB%d",src_index);
-
+		
 		snd_printdd( "dsp_spos: creating SRC \"%s\"\n",scb_name);
 		src_scb = cs46xx_dsp_create_src_task_scb(chip,scb_name,
 							 sample_rate,
@@ -1236,7 +1248,8 @@
 							 /* 0x400 - 0x600 source SCBs */
 							 0x400 + (src_index * 0x10) ,
 							 src_parent_scb,
-							 insert_point);
+							 insert_point,
+							 pass_through);
 
 		if (!src_scb) {
 			snd_printk (KERN_ERR "dsp_spos: failed to create SRCtaskSCB\n");
@@ -1268,19 +1281,6 @@
 		snd_printk (KERN_ERR "dsp_spos: failed to create PCMreaderSCB\n");
 		return NULL;
 	}
-
-	if (pcm_channel_id == DSP_IEC958_CHANNEL && sample_rate == 48000) {
-		snd_assert (ins->spdif_pcm_input_scb == NULL);
-		
-		/* a hack to make the skip the SRC and pass the stream 
-		   directly to the SPDIF task */
-		ins->spdif_pcm_input_scb = 
-			cs46xx_dsp_create_pcm_serial_input_scb(chip,"PCMSerialInput_PCM",
-							       PCMSERIALINII_SCB_ADDR,
-							       pcm_scb,
-							       ins->asynch_tx_scb,
-							       SCB_ON_PARENT_SUBLIST_SCB);		
-	}
 	
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	ins->pcm_channels[pcm_index].sample_rate = sample_rate;
@@ -1625,7 +1625,7 @@
 	}
 	
 	/* if not enabled already */
-	if (ins->spdif_status_out & DSP_SPDIF_STATUS_HW_ENABLED) {
+	if ( !(ins->spdif_status_out & DSP_SPDIF_STATUS_HW_ENABLED) ) {
 		cs46xx_dsp_enable_spdif_hw (chip);
 	}
 
@@ -1669,7 +1669,6 @@
 	_dsp_clear_sample_buffer(chip,SPDIFO_IP_OUTPUT_BUFFER1,256);
 
 	/* restore state */
-
 	if ( ins->spdif_status_out & DSP_SPDIF_STATUS_OUTPUT_ENABLED ) {
 		cs46xx_dsp_enable_spdif_out (chip);
 	}
diff --exclude=CVS --exclude=Makefile -Naur alsa-kernel/pci/cs46xx/imgs/cwcdma.asp ../cvs/alsa-kernel/pci/cs46xx/imgs/cwcdma.asp
--- alsa-kernel/pci/cs46xx/imgs/cwcdma.asp	Thu Jan  1 01:00:00 1970
+++ ../cvs/alsa-kernel/pci/cs46xx/imgs/cwcdma.asp	Mon Mar  3 00:53:08 2003
@@ -0,0 +1,169 @@
+// 
+//  Copyright(c) by Benny Sjostrand (benny@hostmobility.com)
+//
+//  This program is free software; you can redistribute it and/or modify
+//  it under the terms of the GNU General Public License as published by
+//  the Free Software Foundation; either version 2 of the License, or
+//  (at your option) any later version.
+//
+//  This program is distributed in the hope that it will be useful,
+//  but WITHOUT ANY WARRANTY; without even the implied warranty of
+//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+//  GNU General Public License for more details.
+//
+//  You should have received a copy of the GNU General Public License
+//  along with this program; if not, write to the Free Software
+//  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+//
+
+
+//
+// This code runs inside the DSP (cs4610, cs4612, cs4624, or cs4630),
+// to compile it you need a tool named SPASM 3.0 and DSP code owned by 
+// Cirrus Logic(R). The SPASM program will generate a object file (cwcdma.osp),
+// the "ospparser"  tool will genereate the cwcdma.h file it's included from
+// the cs46xx_lib.c file.
+//
+//
+// The purpose of this code is very simple: make it possible to tranfser
+// the samples 'as they are' with no alteration from a PCMreader SCB (DMA from host)
+// to any other SCB. This is useful for AC3 throug SPDIF. SRC (source rate converters) 
+// task always alters the samples in some how, however it's from 48khz -> 48khz. The
+// alterations are not audible, but AC3 wont work. 
+//
+//        ...
+//         |
+// +---------------+
+// | AsynchFGTxSCB |
+// +---------------+
+//        |
+//    subListPtr
+//        |
+// +--------------+
+// |   DMAReader  |
+// +--------------+
+//        |
+//    subListPtr
+//        |
+// +-------------+
+// | PCMReader   |
+// +-------------+
+// (DMA from host)
+//
+
+struct dmaSCB
+  {
+    long  dma_reserved1[3];
+
+    short dma_reserved2:dma_outBufPtr;
+
+    short dma_unused1:dma_unused2;
+
+    long  dma_reserved3[4];
+
+    short dma_subListPtr:dma_nextSCB;
+    short dma_SPBptr:dma_entryPoint;
+
+    long  dma_strmRsConfig;
+    long  dma_strmBufPtr;
+
+    long  dma_reserved4;
+
+    VolumeControl s2m_volume;
+  };
+
+#export DMAReader
+void DMAReader()
+{
+  execChild();
+  r2 = r0->dma_subListPtr;
+  r1 = r0->nextSCB;
+	
+  rsConfig01 = r2->strmRsConfig;
+  // Load rsConfig for input buffer
+
+  rsDMA01 = r2->basicReq.daw,       ,                   tb = Z(0 - rf);
+  // Load rsDMA in case input buffer is a DMA buffer    Test to see if there is any data to transfer
+
+  if (tb) goto execSibling_2ind1 after {
+      r5 = rf + (-1);
+      r6 = r1->dma_entryPoint;           // r6 = entry point of sibling task
+      r1 = r1->dma_SPBptr,               // r1 = pointer to sibling task's SPB
+          ,   ind = r6;                  // Load entry point of sibling task
+  }
+
+  rsConfig23 = r0->dma_strmRsConfig;
+  // Load rsConfig for output buffer (never a DMA buffer)
+
+  r4 = r0->dma_outBufPtr;
+
+  rsa0 = r2->strmBufPtr;
+  // rsa0 = input buffer pointer                        
+
+  for (i = r5; i >= 0; --i)
+    after {
+      rsa2 = r4;
+      // rsa2 = output buffer pointer
+
+      nop;
+      nop;
+    }
+  //*****************************
+  // TODO: cycles to this point *
+  //*****************************
+    {
+      acc0 =  (rsd0 = *rsa0++1);
+      // get sample
+
+      nop;  // Those "nop"'s are really uggly, but there's
+      nop;  // something with DSP's pipelines which I don't
+      nop;  // understand, resulting this code to fail without
+            // having those "nop"'s (Benny)
+
+      rsa0?reqDMA = r2;
+      // Trigger DMA transfer on input stream, 
+      // if needed to replenish input buffer
+
+      nop;
+      // Yet another magic "nop" to make stuff work
+
+      ,,r98 = acc0 $+>> 0;
+      // store sample in ALU
+
+      nop;
+      // latency on load register.
+      // (this one is understandable)
+
+      *rsa2++1 = r98;
+      // store sample in output buffer
+
+      nop; // The same story
+      nop; // as above again ...
+      nop;
+    }
+  // TODO: cycles per loop iteration
+
+  r2->strmBufPtr = rsa0,,   ;
+  // Update the modified buffer pointers
+
+  r4 = rsa2;
+  // Load output pointer position into r4
+
+  r2 = r0->nextSCB;
+  // Sibling task
+
+  goto execSibling_2ind1 // takes 6 cycles
+    after {
+      r98 = r2->thisSPB:entryPoint;
+      // Load child routine entry and data address 
+
+      r1 = r9;
+      // r9 is r2->thisSPB
+
+      r0->dma_outBufPtr = r4,,
+      // Store updated output buffer pointer
+
+      ind = r8;
+      // r8 is r2->entryPoint
+    }
+}
diff --exclude=CVS --exclude=Makefile -Naur alsa-kernel/pci/cs46xx/imgs/cwcdma.h ../cvs/alsa-kernel/pci/cs46xx/imgs/cwcdma.h
--- alsa-kernel/pci/cs46xx/imgs/cwcdma.h	Thu Jan  1 01:00:00 1970
+++ ../cvs/alsa-kernel/pci/cs46xx/imgs/cwcdma.h	Sun Mar  2 22:38:08 2003
@@ -0,0 +1,68 @@
+/* generated from cwcdma.osp DO NOT MODIFY */
+
+#ifndef __HEADER_cwcdma_H__
+#define __HEADER_cwcdma_H__
+
+symbol_entry_t cwcdma_symbols[] = {
+  { 0x8000, "EXECCHILD",0x03 },
+  { 0x8001, "EXECCHILD_98",0x03 },
+  { 0x8003, "EXECCHILD_PUSH1IND",0x03 },
+  { 0x8008, "EXECSIBLING",0x03 },
+  { 0x800a, "EXECSIBLING_298",0x03 },
+  { 0x800b, "EXECSIBLING_2IND1",0x03 },
+  { 0x8010, "TIMINGMASTER",0x03 },
+  { 0x804f, "S16_CODECINPUTTASK",0x03 },
+  { 0x805e, "PCMSERIALINPUTTASK",0x03 },
+  { 0x806d, "S16_MIX_TO_OSTREAM",0x03 },
+  { 0x809a, "S16_MIX",0x03 },
+  { 0x80bb, "S16_UPSRC",0x03 },
+  { 0x813b, "MIX3_EXP",0x03 },
+  { 0x8164, "DECIMATEBYPOW2",0x03 },
+  { 0x8197, "VARIDECIMATE",0x03 },
+  { 0x81f2, "_3DINPUTTASK",0x03 },
+  { 0x820a, "_3DPRLGCINPTASK",0x03 },
+  { 0x8227, "_3DSTEREOINPUTTASK",0x03 },
+  { 0x8242, "_3DOUTPUTTASK",0x03 },
+  { 0x82c4, "HRTF_MORPH_TASK",0x03 },
+  { 0x82c6, "WAIT4DATA",0x03 },
+  { 0x82fa, "PROLOGIC",0x03 },
+  { 0x8496, "DECORRELATOR",0x03 },
+  { 0x84a4, "STEREO2MONO",0x03 },
+  { 0x0000, "OVERLAYBEGINADDRESS",0x00 },
+  { 0x0000, "DMAREADER",0x03 },
+  { 0x0018, "#CODE_END",0x00 },
+}; /* cwcdma symbols */
+
+u32 cwcdma_code[] = {
+/* OVERLAYBEGINADDRESS */
+/* 0000 */ 0x00002731,0x00001400,0x0004c108,0x000e5044,
+/* 0002 */ 0x0005f608,0x00000000,0x000007ae,0x000be300,
+/* 0004 */ 0x00058630,0x00001400,0x0007afb0,0x000e9584,
+/* 0006 */ 0x00007301,0x000a9840,0x0005e708,0x000cd104,
+/* 0008 */ 0x00067008,0x00000000,0x000902a0,0x00001000,
+/* 000A */ 0x00012a01,0x000c0000,0x00000000,0x00000000,
+/* 000C */ 0x00021843,0x000c0000,0x00000000,0x000c0000,
+/* 000E */ 0x0000e101,0x000c0000,0x00000cac,0x00000000,
+/* 0010 */ 0x00080000,0x000e5ca1,0x00000000,0x000c0000,
+/* 0012 */ 0x00000000,0x00000000,0x00000000,0x00092c00,
+/* 0014 */ 0x000122c1,0x000e5084,0x00058730,0x00001400,
+/* 0016 */ 0x000d7488,0x000e4782,0x00007401,0x0001c100
+};
+
+/* #CODE_END */
+
+segment_desc_t cwcdma_segments[] = {
+  { SEGTYPE_SP_PROGRAM, 0x00000000, 0x00000030, cwcdma_code },
+};
+
+dsp_module_desc_t cwcdma_module = {
+  "cwcdma",
+  {
+    27,
+    cwcdma_symbols
+  },
+  1,
+  cwcdma_segments,
+};
+
+#endif /* __HEADER_cwcdma_H__ */

--------------020002020409020602040202--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
