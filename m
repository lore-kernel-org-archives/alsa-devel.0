From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [alsa-cvslog] CVS: alsa-kernel/pci/emu10k1 emufx.c,1.59,1.60
Date: Mon, 8 Nov 2004 07:39:27 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0411080734330.2162@pnote.perex-int.cz>
References: <E1CNAGJ-000270-L7@sc8-pr-cvs1.sourceforge.net>
 <418E654E.5000807@superbug.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <418E654E.5000807@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Jaroslav Kysela <perex@users.sourceforge.net>, Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 7 Nov 2004, James Courtier-Dutton wrote:

> 2)
>  > +	if (put_user(x, &icode->code[a + 0]) ||
>  > +	    put_user(y, &icode->code[a + 1]))
>  > +		return -EFAULT;
> 
> Will always return -EFAULT on my system. I don't think that is what we 
> really want.

Does this patch help?

Index: emufx.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emufx.c,v
retrieving revision 1.61
diff -u -r1.61 emufx.c
--- emufx.c	30 Oct 2004 07:44:20 -0000	1.61
+++ emufx.c	8 Nov 2004 06:41:21 -0000
@@ -468,11 +468,11 @@
 static int snd_emu10k1_write_op(emu10k1_fx8010_code_t *icode, unsigned int *ptr,
 				u32 op, u32 r, u32 a, u32 x, u32 y)
 {
-	snd_assert(*ptr < 512, return);
+	snd_assert(*ptr < 512, return -EINVAL);
 	set_bit(*ptr, icode->code_valid);
 	x = ((x & 0x3ff) << 10) | (y & 0x3ff);
 	y = ((op & 0x0f) << 20) | ((r & 0x3ff) << 10) | (a & 0x3ff);
-	a = *ptr++ * 2;
+	a = (*ptr)++ * 2;
 	if (put_user(x, &icode->code[a + 0]) ||
             put_user(y, &icode->code[a + 1]))
 		return -EFAULT;
@@ -485,11 +485,11 @@
 static int snd_emu10k1_audigy_write_op(emu10k1_fx8010_code_t *icode, unsigned int *ptr,
 				       u32 op, u32 r, u32 a, u32 x, u32 y)
 {
-	snd_assert(*ptr < 1024, return);
+	snd_assert(*ptr < 1024, return -EINVAL);
 	set_bit(*ptr, icode->code_valid);
 	x = ((x & 0x7ff) << 12) | (y & 0x7ff);
 	y = ((op & 0x0f) << 24) | ((r & 0x7ff) << 12) | (a & 0x7ff);
-	a = *ptr++ * 2;
+	a = (*ptr)++ * 2;
 	if (put_user(x, &icode->code[a + 0]) ||
 	    put_user(y, &icode->code[a + 1]))
 		return -EFAULT;
@@ -1010,7 +1010,7 @@
 	INIT_LIST_HEAD(&emu->fx8010.gpr_ctl);
 
 	if ((icode = kcalloc(1, sizeof(*icode), GFP_KERNEL)) == NULL ||
-	    (icode->gpr_map = kcalloc(512 + 256 + 256, sizeof(u_int32_t), GFP_KERNEL)) == NULL ||
+	    (icode->gpr_map = kcalloc(512 + 256 + 256 + 2 * 1024, sizeof(u_int32_t), GFP_KERNEL)) == NULL ||
 	    (controls = kcalloc(SND_EMU10K1_GPR_CONTROLS, sizeof(*controls), GFP_KERNEL)) == NULL) {
 		err = -ENOMEM;
 		goto __err;
@@ -1018,6 +1018,7 @@
 
 	icode->tram_data_map = icode->gpr_map + 512;
 	icode->tram_addr_map = icode->tram_data_map + 256;
+	icode->code = icode->tram_addr_map + 256;
 
 	/* clear free GPRs */
 	for (i = 0; i < 512; i++)
@@ -1460,7 +1461,7 @@
 
 	if ((icode = kcalloc(1, sizeof(*icode), GFP_KERNEL)) == NULL)
 		return -ENOMEM;
-	if ((icode->gpr_map = kcalloc(256 + 160 + 160, sizeof(u_int32_t), GFP_KERNEL)) == NULL ||
+	if ((icode->gpr_map = kcalloc(256 + 160 + 160 + 2 * 512, sizeof(u_int32_t), GFP_KERNEL)) == NULL ||
             (controls = kcalloc(SND_EMU10K1_GPR_CONTROLS, sizeof(emu10k1_fx8010_control_gpr_t), GFP_KERNEL)) == NULL ||
 	    (ipcm = kcalloc(1, sizeof(*ipcm), GFP_KERNEL)) == NULL) {
 		err = -ENOMEM;
@@ -1469,6 +1470,7 @@
 
 	icode->tram_data_map = icode->gpr_map + 256;
 	icode->tram_addr_map = icode->tram_data_map + 160;
+	icode->code = icode->tram_addr_map + 160;
 	
 	/* clear free GPRs */
 	for (i = 0; i < 256; i++)

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
