From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: dmix plugin
Date: Wed, 19 Feb 2003 19:34:41 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302191931340.1224-100000@pnote.perex-int.cz>
References: <3E538B79.26FEE5F6@libero.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E538B79.26FEE5F6@libero.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Abramo Bagnara <abramo.bagnara@libero.it>
Cc: Jaroslaw Sobierski <fycio@gucio.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 19 Feb 2003, Abramo Bagnara wrote:

> The results are amazing and I'd say Jaroslav has done some mistakes in
> his handmade asm.

I don't think so. It seems that my brain still remembers assembler ;-)
You passed wrong values to my code so it did unaligned accesses.

Fixes to make things same:

--- sum.c	2003-02-19 18:55:20.000000000 +0100
+++ a.c	2003-02-19 19:31:00.000000000 +0100
@@ -11,6 +11,8 @@
 typedef short int s16;
 typedef int s32;
 
+#define CONFIG_SMP
+
 #ifdef CONFIG_SMP
 #define LOCK_PREFIX "lock ; "
 #else
@@ -54,7 +56,7 @@
 static inline void atomic_add(volatile int *dst, int v)
 {
 	__asm__ __volatile__(
-		LOCK_PREFIX "addl %0,%1"
+		LOCK_PREFIX "addl %1,%0"
 		:"=m" (*dst)
 		:"ir" (v));
 }
@@ -62,7 +64,9 @@
 void mix_areas0(unsigned int size,
 		volatile s16 *dst, s16 *src,
 		volatile s32 *sum,
-		unsigned int dst_step, unsigned int src_step)
+		unsigned int dst_step,
+		unsigned int src_step,
+		unsigned int sum_step)
 {
 	while (size-- > 0) {
 		s32 sample = *dst + *src;
@@ -70,8 +74,8 @@
 			*dst = sample > 0 ? 0x7fff : -0x8000;
 		else
 			*dst = sample;
-		dst += dst_step;
-		src += src_step;
+		((char *)dst) += dst_step;
+		((char *)src) += src_step;
 	}
 }
 
@@ -194,7 +198,9 @@
 void mix_areas2(unsigned int size,
 		volatile s16 *dst, s16 *src,
 		volatile s32 *sum,
-		unsigned int dst_step, unsigned int src_step)
+		unsigned int dst_step,
+		unsigned int src_step,
+		unsigned int sum_step)
 {
 	while (size-- > 0) {
 		s32 sample = *src;
@@ -204,15 +210,15 @@
 		do {
 			sample = *sum;
 			s16 s;
-			if (unlikely(sample & 0xffff0000))
+			if (unlikely(sample & 0x7fff0000))
 				s = sample > 0 ? 0x7fff : -0x8000;
 			else
 				s = sample;
 			*dst = s;
 		} while (unlikely(sample != *sum));
-		sum++;
-		dst += dst_step;
-		src += src_step;
+		((char *)sum) += sum_step;
+		((char *)dst) += dst_step;
+		((char *)src) += src_step;
 	}
 }
 
@@ -236,19 +242,19 @@
 	}
 	rdtscll(begin);
 	for (i = 0; i < n; i++) {
-		mix_areas0(size, dst, srcs[i], sum, 1, 1);
+		mix_areas0(size, dst, srcs[i], sum, 2, 2, 4);
 	}
 	rdtscll(end);
 	printf("mix_areas0: %lld\n", end - begin);
 	rdtscll(begin);
 	for (i = 0; i < n; i++) {
-		mix_areas1(size, dst, srcs[i], sum, 1, 1, 1);
+		mix_areas1(size, dst, srcs[i], sum, 2, 2, 4);
 	}
 	rdtscll(end);
 	printf("mix_areas1: %lld\n", end - begin);
 	rdtscll(begin);
 	for (i = 0; i < n; i++) {
-		mix_areas2(size, dst, srcs[i], sum, 1, 1);
+		mix_areas2(size, dst, srcs[i], sum, 2, 2, 4);
 	}
 	rdtscll(end);
 	printf("mix_areas2: %lld\n", end - begin);

perex@pnote:~> cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 847.473
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse
bogomips        : 1679.36

perex@pnote:~> ./a.out 2048 4 32267
mix_areas0: 170691
mix_areas1: 675795
mix_areas2: 708995


					Have fun,
						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
