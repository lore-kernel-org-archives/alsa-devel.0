From: Daniel Berlin <dberlin@dberlin.org>
Subject: [PATCH]: Add mixer controls for AudigyDrive SPDIF's
Date: Sun, 18 Aug 2002 02:03:18 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0208180202590.13917-100000@dberlin.org>
Reply-To: dberlin@dberlin.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.cdt.org (mail.cdt.org [206.112.85.61])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id IAA27888
	for <alsa-devel@alsa-project.org>; Sun, 18 Aug 2002 08:03:45 +0200
Received: from www.dberlin.org (pool-138-88-49-153.res.east.verizon.net [138.88.49.153])
	by mail.cdt.org (Postfix) with ESMTP id 9BAF9490052
	for <alsa-devel@alsa-project.org>; Sun, 18 Aug 2002 01:43:18 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by www.dberlin.org (Postfix) with ESMTP id F13CE1820942
	for <alsa-devel@alsa-project.org>; Sun, 18 Aug 2002 02:03:18 -0400 (EDT)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


This gives mixer controls for the RCA Coaxial SPDIF and the Optical SPDIF 
inputs on the audigy drive.

The associated outputs are likely the two ??'s in the A_EXTOUT listings of 
emu10k1.h,  or in between A_EXTOUT_AC97_R and A_EXTOUT_ADC_CAP_L, or some 
combination thereof.

I'll figure it out soon.

However, with this patch, i get sound from the optical input on the audigy 
drive.

Index: include/emu10k1.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/include/emu10k1.h,v
retrieving revision 1.17
diff -c -3 -p -w -B -b -r1.17 emu10k1.h
*** include/emu10k1.h	12 Aug 2002 06:47:15 -0000	1.17
--- include/emu10k1.h	17 Aug 2002 21:53:56 -0000
*************** int snd_emu10k1_proc_done(emu10k1_t * em
*** 1195,1202 ****
--- 1195,1206 ----
  #define A_EXTIN_AC97_R		0x01	/* AC'97 capture channel - right */
  #define A_EXTIN_SPDIF_CD_L	0x02	/* digital CD left */
  #define A_EXTIN_SPDIF_CD_R	0x03	/* digital CD left */
+ #define A_EXTIN_OPT_SPDIF_L     0x04    /* audigy drive Optical SPDIF - left */
+ #define A_EXTIN_OPT_SPDIF_R     0x05    /*                              right */ 
  #define A_EXTIN_LINE2_L		0x08	/* audigy drive line2/mic2 - left */
  #define A_EXTIN_LINE2_R		0x09	/*                           right */
+ #define A_EXTIN_RCA_SPDIF_L     0x0a    /* audigy drive RCA SPDIF - left */
+ #define A_EXTIN_RCA_SPDIF_R     0x0b    /*                          right */
  #define A_EXTIN_AUX2_L		0x0c	/* audigy drive aux2 - left */
  #define A_EXTIN_AUX2_R		0x0d	/*                   - right */
  
Index: pci/emu10k1/emufx.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emufx.c,v
retrieving revision 1.17
diff -c -3 -p -w -B -b -r1.17 emufx.c
*** pci/emu10k1/emufx.c	15 Aug 2002 12:13:09 -0000	1.17
--- pci/emu10k1/emufx.c	17 Aug 2002 21:53:57 -0000
*************** static char *audigy_ins[16] = {
*** 91,104 ****
  	/* 0x01 */ "AC97 Right",
  	/* 0x02 */ "Audigy CD Left",
  	/* 0x03 */ "Audigy CD Right",
! 	/* 0x04 */ NULL,
! 	/* 0x05 */ NULL,
  	/* 0x06 */ NULL,
  	/* 0x07 */ NULL,
  	/* 0x08 */ "Line/Mic 2 Left",
  	/* 0x09 */ "Line/Mic 2 Right",
! 	/* 0x0a */ NULL,
! 	/* 0x0b */ NULL,
  	/* 0x0c */ "Aux2 Left",
  	/* 0x0d */ "Aux2 Right",
  	/* 0x0e */ NULL,
--- 91,104 ----
  	/* 0x01 */ "AC97 Right",
  	/* 0x02 */ "Audigy CD Left",
  	/* 0x03 */ "Audigy CD Right",
! 	/* 0x04 */ "Optical IEC958 Left",
! 	/* 0x05 */ "Optical IEC958 Right",
  	/* 0x06 */ NULL,
  	/* 0x07 */ NULL,
  	/* 0x08 */ "Line/Mic 2 Left",
  	/* 0x09 */ "Line/Mic 2 Right",
! 	/* 0x0a */ "SPDIF Left",
! 	/* 0x0b */ "SPDIF Right",
  	/* 0x0c */ "Aux2 Left",
  	/* 0x0d */ "Aux2 Right",
  	/* 0x0e */ NULL,
*************** A_OP(icode, &ptr, iMAC0, A_GPR(var), A_G
*** 1313,1318 ****
--- 1313,1329 ----
  	snd_emu10k1_init_stereo_control(&controls[nctl++], "Audigy CD Capture Volume", gpr, 0);
  	gpr += 2;
  
+ 	/* Optical SPDIF Playback Volume */
+ 	A_ADD_VOLUME_IN(playback, gpr, A_EXTIN_OPT_SPDIF_L);
+ 	A_ADD_VOLUME_IN(playback+1, gpr+1, A_EXTIN_OPT_SPDIF_R);
+ 	snd_emu10k1_init_stereo_control(&controls[nctl++], "Optical IEC958 Playback Volume", gpr, 0);
+ 	gpr += 2;
+ 	/* Optical SPDIF Capture Volume */
+ 	A_ADD_VOLUME_IN(capture, gpr, A_EXTIN_OPT_SPDIF_L);
+ 	A_ADD_VOLUME_IN(capture+1, gpr+1, A_EXTIN_OPT_SPDIF_R);
+ 	snd_emu10k1_init_stereo_control(&controls[nctl++], "Optical IEC958 Capture Volume", gpr, 0);
+ 	gpr += 2;
+ 
  	/* Line2 Playback Volume */
  	A_ADD_VOLUME_IN(playback, gpr, A_EXTIN_LINE2_L);
  	A_ADD_VOLUME_IN(playback+1, gpr+1, A_EXTIN_LINE2_R);
*************** A_OP(icode, &ptr, iMAC0, A_GPR(var), A_G
*** 1322,1327 ****
--- 1333,1349 ----
  	A_ADD_VOLUME_IN(capture, gpr, A_EXTIN_LINE2_L);
  	A_ADD_VOLUME_IN(capture+1, gpr+1, A_EXTIN_LINE2_R);
  	snd_emu10k1_init_stereo_control(&controls[nctl++], "Line2 Capture Volume", gpr, 0);
+ 	gpr += 2;
+         
+ 	/* RCA SPDIF Playback Volume */
+ 	A_ADD_VOLUME_IN(playback, gpr, A_EXTIN_RCA_SPDIF_L);
+ 	A_ADD_VOLUME_IN(playback+1, gpr+1, A_EXTIN_RCA_SPDIF_R);
+ 	snd_emu10k1_init_stereo_control(&controls[nctl++], "RCA SPDIF Playback Volume", gpr, 0);
+ 	gpr += 2;
+ 	/* RCA SPDIF Capture Volume */
+ 	A_ADD_VOLUME_IN(capture, gpr, A_EXTIN_RCA_SPDIF_L);
+ 	A_ADD_VOLUME_IN(capture+1, gpr+1, A_EXTIN_RCA_SPDIF_R);
+ 	snd_emu10k1_init_stereo_control(&controls[nctl++], "RCA SPDIF Capture Volume", gpr, 0);
  	gpr += 2;
  
  	/* Aux2 Playback Volume */






-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
