From: Adam Tla/lka <atlka@pg.gda.pl>
Subject: another shm memory patch and some optimizations
Date: Fri, 23 Jan 2004 13:52:23 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40111907.10702@pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060607010406040003080303"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060607010406040003080303
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Welcome

Marking a shm segment to remove it after using shmat function makes 
automatic removal of shm segment while num of attached apps decreses to 
zero. If app is killed it works too. But we could not mark segments 
which have assigned a key because this clears the key. These segments 
stay in memory after crash but as long as we do not want bigger segment 
size we could get to them. So I added check which removes this kind of 
segments in case while we could not get them and they are not used. 
After that we can create new segments with desired key and size.

In next part I optimized a bit sample mixing routines in c and x_86 asm.
Hope this helps.
Regards

-- 
Adam Tla/lka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
Computer Center,  Technical University of Gdansk, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl

--------------060607010406040003080303
Content-Type: text/plain;
 name="alsa-20040123.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-20040123.patch"

--- alsa-20040123/alsa-lib/src/pcm/pcm_dmix_old.c	2004-01-21 20:21:11.000000000 +0100
+++ alsa-20040123/alsa-lib/src/pcm/pcm_dmix.c	2004-01-23 13:13:53.000000000 +0100
@@ -59,14 +59,26 @@
 static int shm_sum_create_or_connect(snd_pcm_direct_t *dmix)
 {
 	static int shm_sum_discard(snd_pcm_direct_t *dmix);
+	struct shmid_ds buf;
+	int tmpid, err;
 	size_t size;
 
 	size = dmix->shmptr->s.channels *
 	       dmix->shmptr->s.buffer_size *
 	       sizeof(signed int);	
+retryshm:
 	dmix->u.dmix.shmid_sum = shmget(dmix->ipc_key + 1, size, IPC_CREAT | 0666);
-	if (dmix->u.dmix.shmid_sum < 0)
-		return -errno;
+	err = -errno;
+	if (dmix->u.dmix.shmid_sum < 0){
+		if (errno == EINVAL)
+		if ((tmpid = shmget(dmix->ipc_key + 1, 0, 0666)) != -1)
+		if (!shmctl(tmpid, IPC_STAT, &buf))
+	    	if (!buf.shm_nattch) 
+		/* no users so destroy the segment */
+		if (!shmctl(tmpid, IPC_RMID, NULL))
+		    goto retryshm;
+		return err;
+	}
 	dmix->u.dmix.sum_buffer = shmat(dmix->u.dmix.shmid_sum, 0, 0);
 	if (dmix->u.dmix.sum_buffer == (void *) -1) {
 		shm_sum_discard(dmix);
@@ -214,7 +226,7 @@
 {
 	register signed int sample, old_sample;
 
-	while (size-- > 0) {
+	for (;;) {
 		sample = *src;
 		old_sample = *sum;
 		if (*dst == 0)
@@ -230,6 +242,8 @@
 				sample = old_sample;
 			*dst = sample;
 		} while (*sum != old_sample);
+		if (!--size)
+			return;
 		((char *)src) += src_step;
 		((char *)dst) += dst_step;
 		((char *)sum) += sum_step;
@@ -244,7 +258,7 @@
 {
 	register signed int sample, old_sample;
 
-	while (size-- > 0) {
+	for (;;) {
 		sample = *src / 256;
 		old_sample = *sum;
 		if (*dst == 0)
@@ -260,6 +274,8 @@
 				sample = old_sample * 256;
 			*dst = sample;
 		} while (*sum != old_sample);
+		if (!--size)
+			return;
 		((char *)src) += src_step;
 		((char *)dst) += dst_step;
 		((char *)sum) += sum_step;
@@ -366,9 +382,11 @@
 	dmix->slave_appl_ptr %= dmix->shmptr->s.boundary;
 	while (size > 0) {
 		transfer = appl_ptr + size > pcm->buffer_size ? pcm->buffer_size - appl_ptr : size;
-		transfer = slave_appl_ptr + transfer > dmix->shmptr->s.buffer_size ? dmix->shmptr->s.buffer_size - slave_appl_ptr : transfer;
-		size -= transfer;
+		if ((transfer = slave_appl_ptr + transfer > dmix->shmptr->s.buffer_size ? dmix->shmptr->s.buffer_size - slave_appl_ptr : transfer))
 		mix_areas(dmix, src_areas, dst_areas, appl_ptr, slave_appl_ptr, transfer);
+		if (transfer >= size)
+			return;
+		size -= transfer;
 		slave_appl_ptr += transfer;
 		slave_appl_ptr %= dmix->shmptr->s.buffer_size;
 		appl_ptr += transfer;
--- alsa-20040123/alsa-lib/src/pcm/pcm_mmap_old.c	2004-01-23 13:06:01.000000000 +0100
+++ alsa-20040123/alsa-lib/src/pcm/pcm_mmap.c	2004-01-23 13:09:49.000000000 +0100
@@ -368,6 +368,11 @@
 						SYSERR("shmat failed");
 						return -errno;
 					}
+					/* automatically remove segment if not used */
+					if (shmctl(id, IPC_RMID, NULL) < 0){
+						SYSERR("shmctl mark remove failed");
+						return -errno;
+					}
 					i->u.shm.area = snd_shm_area_create(id, ptr);
 					if (i->u.shm.area == NULL) {
 						SYSERR("snd_shm_area_create failed");
--- alsa-20040123/alsa-lib/src/pcm/pcm_direct_old.c	2004-01-21 20:21:11.000000000 +0100
+++ alsa-20040123/alsa-lib/src/pcm/pcm_direct.c	2004-01-23 12:40:46.000000000 +0100
@@ -101,11 +101,21 @@
 {
 	static int snd_pcm_direct_shm_discard(snd_pcm_direct_t *dmix);
 	struct shmid_ds buf;
-	int ret = 0;
+	int tmpid, err;
 	
+retryget:
 	dmix->shmid = shmget(dmix->ipc_key, sizeof(snd_pcm_direct_share_t), IPC_CREAT | 0666);
-	if (dmix->shmid < 0)
-		return -errno;
+	err = -errno;
+	if (dmix->shmid < 0){
+		if (errno == EINVAL)
+		if ((tmpid = shmget(dmix->ipc_key, 0, 0666)) != -1)
+		if (!shmctl(tmpid, IPC_STAT, &buf))
+		if (!buf.shm_nattch)
+	    	/* no users so destroy the segment */
+		if (!shmctl(tmpid, IPC_RMID, NULL))
+		    goto retryget;
+		return err;
+	}
 	dmix->shmptr = shmat(dmix->shmid, 0, 0);
 	if (dmix->shmptr == (void *) -1) {
 		snd_pcm_direct_shm_discard(dmix);
@@ -118,9 +128,9 @@
 	}
 	if (buf.shm_nattch == 1) {	/* we're the first user, clear the segment */
 		memset(dmix->shmptr, 0, sizeof(snd_pcm_direct_share_t));
-		ret = 1;
+		return 1;
 	}
-	return ret;
+	return 0;
 }
 
 int snd_pcm_direct_shm_discard(snd_pcm_direct_t *dmix)
--- alsa-20040123/alsa-lib/src/pcm/pcm_dmix_i386_old.h	2004-01-23 13:01:39.000000000 +0100
+++ alsa-20040123/alsa-lib/src/pcm/pcm_dmix_i386.h	2004-01-15 11:06:36.000000000 +0100
@@ -51,16 +51,17 @@
 		"\tmovl %1, %%edi\n"
 		"\tmovl %2, %%esi\n"
 		"\tmovl %3, %%ebx\n"
+		"\tjmp 2f\n"
+
 
 		/*
-		 * while (size-- > 0) {
+		 * for (;;)
 		 */
-		"\tcmpl $0, %0\n"
-		"jz 6f\n"
-
 		"\t.p2align 4,,15\n"
-
 		"1:"
+		"\tadd %4, %%edi\n"
+		"\tadd %5, %%esi\n"
+		"\tadd %6, %%ebx\n"
 
 		/*
 		 *   sample = *src;
@@ -69,14 +70,17 @@
 		 *     sample -= sum_sample;
 		 *   xadd(*sum, sample);
 		 */
-		"\tmovw $0, %%ax\n"
-		"\tmovw $1, %%cx\n"
+
+		"2:"
+		"\txor %%ax, %%ax\n"
+		"\tmovw %%ax, %%cx\n"
+		"\tincw  %%cx\n"
 		"\tmovl (%%ebx), %%edx\n"
 		"\t" LOCK_PREFIX "cmpxchgw %%cx, (%%edi)\n"
 		"\tmovswl (%%esi), %%ecx\n"
-		"\tjnz 2f\n"
+		"\tjnz 3f\n"
 		"\tsubl %%edx, %%ecx\n"
-		"2:"
+		"3:"
 		"\t" LOCK_PREFIX "addl %%ecx, (%%ebx)\n"
 
 		/*
@@ -87,25 +91,22 @@
 		 *   } while (v != *sum);
 		 */
 
-		"3:"
+		"4:"
 		"\tmovl (%%ebx), %%ecx\n"
 		"\tcmpl $0x7fff,%%ecx\n"
-		"\tjg 4f\n"
+		"\tjg 5f\n"
 		"\tcmpl $-0x8000,%%ecx\n"
-		"\tjl 5f\n"
+		"\tjl 6f\n"
 		"\tmovw %%cx, (%%edi)\n"
 		"\tcmpl %%ecx, (%%ebx)\n"
-		"\tjnz 3b\n"
+		"\tjnz 4b\n"
 
 		/*
 		 * while (size-- > 0)
 		 */
-		"\tadd %4, %%edi\n"
-		"\tadd %5, %%esi\n"
-		"\tadd %6, %%ebx\n"
 		"\tdecl %0\n"
-		"\tjnz 1b\n"
-		"\tjmp 6f\n"
+		"\tjz  7f\n"
+		"\tjmp 1b\n"
 
 		/*
 		 *  sample > 0x7fff
@@ -113,16 +114,13 @@
 
 		"\t.p2align 4,,15\n"
 
-		"4:"
+		"5:"
 		"\tmovw $0x7fff, (%%edi)\n"
 		"\tcmpl %%ecx,(%%ebx)\n"
-		"\tjnz 3b\n"
-		"\tadd %4, %%edi\n"
-		"\tadd %5, %%esi\n"
-		"\tadd %6, %%ebx\n"
+		"\tjnz 4b\n"
 		"\tdecl %0\n"
 		"\tjnz 1b\n"
-		"\tjmp 6f\n"
+		"\tjmp 7f\n"
 
 		/*
 		 *  sample < -0x8000
@@ -130,18 +128,15 @@
 
 		"\t.p2align 4,,15\n"
 
-		"5:"
+		"6:"
 		"\tmovw $-0x8000, (%%edi)\n"
 		"\tcmpl %%ecx, (%%ebx)\n"
-		"\tjnz 3b\n"
-		"\tadd %4, %%edi\n"
-		"\tadd %5, %%esi\n"
-		"\tadd %6, %%ebx\n"
+		"\tjnz 4b\n"
 		"\tdecl %0\n"
 		"\tjnz 1b\n"
 		// "\tjmp 6f\n"
 		
-		"6:"
+		"7:"
 
 		: /* no output regs */
 		: "m" (size), "m" (dst), "m" (src), "m" (sum), "m" (dst_step), "m" (src_step), "m" (sum_step)
@@ -174,17 +169,15 @@
 		"\tmovl %1, %%edi\n"
 		"\tmovl %2, %%esi\n"
 		"\tmovl %3, %%ebx\n"
-
-		/*
-		 * while (size-- > 0) {
-		 */
-		"\tcmpl $0, %0\n"
-		"jz 6f\n"
+		"\tjmp  2f\n"
 
 		"\t.p2align 4,,15\n"
-
 		"1:"
+		"\tadd %4, %%edi\n"
+		"\tadd %5, %%esi\n"
+		"\tadd %6, %%ebx\n"
 
+		"2:"
 		/*
 		 *   sample = *src;
 		 *   sum_sample = *sum;
@@ -192,14 +185,15 @@
 		 *     sample -= sum_sample;
 		 *   xadd(*sum, sample);
 		 */
-		"\tmovw $0, %%ax\n"
-		"\tmovw $1, %%cx\n"
+		"\txor  %%ax, %%ax\n"
+		"\tmovw %%ax, %%cx\n"
+		"\tincw %%cx\n"
 		"\tmovl (%%ebx), %%edx\n"
 		"\t" LOCK_PREFIX "cmpxchgw %%cx, (%%edi)\n"
 		"\tmovswl (%%esi), %%ecx\n"
-		"\tjnz 2f\n"
+		"\tjnz 3f\n"
 		"\tsubl %%edx, %%ecx\n"
-		"2:"
+		"3:"
 		"\t" LOCK_PREFIX "addl %%ecx, (%%ebx)\n"
 
 		/*
@@ -210,27 +204,20 @@
 		 *   } while (v != *sum);
 		 */
 
-		"3:"
+		"4:"
 		"\tmovl (%%ebx), %%ecx\n"
 		"\tmovd %%ecx, %%mm0\n"
 		"\tpackssdw %%mm1, %%mm0\n"
 		"\tmovd %%mm0, %%eax\n"
 		"\tmovw %%ax, (%%edi)\n"
 		"\tcmpl %%ecx, (%%ebx)\n"
-		"\tjnz 3b\n"
+		"\tjnz 4b\n"
 
 		/*
 		 * while (size-- > 0)
 		 */
-		"\tadd %4, %%edi\n"
-		"\tadd %5, %%esi\n"
-		"\tadd %6, %%ebx\n"
 		"\tdecl %0\n"
 		"\tjnz 1b\n"
-		"\tjmp 6f\n"
-
-		"6:"
-		
 		"\temms\n"
 
 		: /* no output regs */
@@ -265,12 +252,6 @@
 		"\tmovl %2, %%esi\n"
 		"\tmovl %3, %%ebx\n"
 
-		/*
-		 * while (size-- > 0) {
-		 */
-		"\tcmpl $0, %0\n"
-		"jz 6f\n"
-
 		"\t.p2align 4,,15\n"
 
 		"1:"
@@ -334,12 +315,12 @@
 		/*
 		 * while (size-- > 0)
 		 */
+		"\tdecl %0\n"
+		"\tjz 6f\n"
 		"\tadd %4, %%edi\n"
 		"\tadd %5, %%esi\n"
 		"\tadd %6, %%ebx\n"
-		"\tdecl %0\n"
-		"\tjnz 1b\n"
-		// "\tjmp 6f\n"
+		"\tjmp 1b\n"
 		
 		"6:"
 		: /* no output regs */
--- alsa-20040123/alsa-lib/src/shmarea_old.c	2004-01-23 12:18:09.000000000 +0100
+++ alsa-20040123/alsa-lib/src/shmarea.c	2004-01-23 12:23:54.000000000 +0100
@@ -56,17 +56,6 @@
 	return area;
 }
 
-static void _x_destroy(struct snd_shm_area *area)
-{
-	struct shmid_ds buf;
-
-	shmdt(area->ptr);
-	if (shmctl(area->shmid, IPC_STAT, &buf) >= 0) {
-		if (buf.shm_nattch == 0)
-			shmctl(area->shmid, IPC_RMID, NULL);
-	}
-}
-
 int snd_shm_area_destroy(struct snd_shm_area *area)
 {
 	if (area == NULL)
@@ -74,7 +63,7 @@
 	if (--area->share)
 		return 0;
 	list_del(&area->list);
-	_x_destroy(area);
+	shmdt(area->ptr);
 	free(area);
 	return 0;
 }
@@ -88,6 +77,6 @@
 
 	list_for_each(pos, &shm_areas) {
 		area = list_entry(pos, struct snd_shm_area, list);
-		_x_destroy(area);
+		shmdt(area->ptr);
 	}
 }

--------------060607010406040003080303--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
