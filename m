From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: Re: dmix plugin
Date: Wed, 19 Feb 2003 14:49:45 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E538B79.26FEE5F6@libero.it>
References: <Pine.LNX.4.44.0302191131230.1224-100000@pnote.perex-int.cz> <3E5367B4.9BB02DED@libero.it>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------F27CE0E99BDED5320D02BE73"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>, Jaroslaw Sobierski <fycio@gucio.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------F27CE0E99BDED5320D02BE73
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Abramo Bagnara wrote:
> 
> Jaroslav Kysela wrote:
> >
> > On Wed, 19 Feb 2003, Abramo Bagnara wrote:
> >
> > > Jaroslav Kysela wrote:
> > > >
> > > > I've implemented the whole transfer and mix loop in assembly and it works
> > > > without any drastic impact on CPU usage. I tried to optimize the assembler
> > > > part as much as I can, but if some assembler guru want to give a glance,
> > > > I'll appreciate it. The function is named mix_areas1() in
> > > > alsa-lib/src/pcm/pcm_dmix.c.
> > >
> > > one comment:
> > >
> > > It's better to execute interleaved check once and not in mix_areas
> >
> > Done. I was tired enough yesterday to bother with these details.
> >
> > > one objection:
> > >
> > > I doubt very much that you gain anything coding the mixing loop in
> > > assembler, you've data showing that?
> >
> > I think that I spent some ticks by duplicating code for saturation and
> > also the main while{} loop is more effective than GCC generates. But it's
> > only guess.
> 
> I hope to find the time to check it this evening

I've stolen some time to paid work.

The results are amazing and I'd say Jaroslav has done some mistakes in
his handmade asm.

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) XP 1700+
stepping        : 2
cpu MHz         : 1460.471
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 2916.35
$ gcc -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/3.2.1/specs
Configured with: ../configure --prefix=/usr --mandir=/usr/share/man
--infodir=/usr/share/info --enable-shared --enable-threads=posix
--disable-checking --with-system-zlib --enable-__cxa_atexit
--host=i386-redhat-linux
Thread model: posix
gcc version 3.2.1 20021125 (Red Hat Linux 8.0 3.2.1-1)
$ make
gcc -O6 -W -Wall   -c -o sum.o sum.c
sum.c: In function `main':
sum.c:242: warning: implicit declaration of function `printf'
sum.c:219: warning: unused parameter `argc'
sum.c:255: warning: control reaches end of non-void function
sum.c: In function `mix_areas0':
sum.c:64: warning: unused parameter `sum'
gcc   sum.o   -o sum
$ ./sum 2048 4 32767
mix_areas0: 110603
mix_areas1: 1512610
mix_areas2: 157597

mix_areas0 is the naive, incorrect version
mix_areas1 is Jaroslav asm
mix_areas2 is my best attempt

Time in clock ticks.

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy
--------------F27CE0E99BDED5320D02BE73
Content-Type: text/plain; charset=us-ascii;
 name="sum.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sum.c"

#include <stdlib.h>
#include <stdlib.h>
#include <string.h>

#define rdtscll(val) \
     __asm__ __volatile__("rdtsc" : "=A" (val))

#define likely(x)       __builtin_expect((x),1)
#define unlikely(x)     __builtin_expect((x),0)

typedef short int s16;
typedef int s32;

#ifdef CONFIG_SMP
#define LOCK_PREFIX "lock ; "
#else
#define LOCK_PREFIX ""
#endif

struct __xchg_dummy { unsigned long a[100]; };
#define __xg(x) ((struct __xchg_dummy *)(x))

static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
				      unsigned long new, int size)
{
	unsigned long prev;
	switch (size) {
	case 1:
		__asm__ __volatile__(LOCK_PREFIX "cmpxchgb %b1,%2"
				     : "=a"(prev)
				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
				     : "memory");
		return prev;
	case 2:
		__asm__ __volatile__(LOCK_PREFIX "cmpxchgw %w1,%2"
				     : "=a"(prev)
				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
				     : "memory");
		return prev;
	case 4:
		__asm__ __volatile__(LOCK_PREFIX "cmpxchgl %1,%2"
				     : "=a"(prev)
				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
				     : "memory");
		return prev;
	}
	return old;
}

#define cmpxchg(ptr,o,n)\
	((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
					(unsigned long)(n),sizeof(*(ptr))))

static inline void atomic_add(volatile int *dst, int v)
{
	__asm__ __volatile__(
		LOCK_PREFIX "addl %0,%1"
		:"=m" (*dst)
		:"ir" (v));
}

void mix_areas0(unsigned int size,
		volatile s16 *dst, s16 *src,
		volatile s32 *sum,
		unsigned int dst_step, unsigned int src_step)
{
	while (size-- > 0) {
		s32 sample = *dst + *src;
		if (unlikely(sample & 0xffff0000))
			*dst = sample > 0 ? 0x7fff : -0x8000;
		else
			*dst = sample;
		dst += dst_step;
		src += src_step;
	}
}

void mix_areas1(unsigned int size,
		volatile s16 *dst, s16 *src,
		volatile s32 *sum, unsigned int dst_step,
		unsigned int src_step, unsigned int sum_step)
{
	/*
	 *  ESI - src
	 *  EDI - dst
	 *  EBX - sum
	 *  ECX - old sample
	 *  EAX - sample / temporary
	 *  EDX - size
	 */
	__asm__ __volatile__ (
		"\n"

		/*
		 *  initialization, load EDX, ESI, EDI, EBX registers
		 */
		"\tmovl %0, %%edx\n"
		"\tmovl %1, %%edi\n"
		"\tmovl %2, %%esi\n"
		"\tmovl %3, %%ebx\n"

		/*
		 * while (size-- > 0) {
		 */
		"\tcmp $0, %%edx\n"
		"jz 6f\n"

		"1:"

		/*
		 *   sample = *src;
		 *   if (cmpxchg(*dst, 0, 1) == 0)
		 *     sample -= *sum;
		 *   xadd(*sum, sample);
		 */
		"\tmovw $0, %%ax\n"
		"\tmovw $1, %%cx\n"
		"\tlock; cmpxchgw %%cx, (%%edi)\n"
		"\tmovswl (%%esi), %%ecx\n"
		"\tjnz 2f\n"
		"\tsubl (%%ebx), %%ecx\n"
		"2:"
		"\tlock; addl %%ecx, (%%ebx)\n"

		/*
		 *   do {
		 *     sample = old_sample = *sum;
		 *     saturate(v);
		 *     *dst = sample;
		 *   } while (v != *sum);
		 */

		"3:"
		"\tmovl (%%ebx), %%ecx\n"
		"\tcmpl $0x7fff,%%ecx\n"
		"\tjg 4f\n"
		"\tcmpl $-0x8000,%%ecx\n"
		"\tjl 5f\n"
		"\tmovw %%cx, (%%edi)\n"
		"\tcmpl %%ecx, (%%ebx)\n"
		"\tjnz 3b\n"

		/*
		 * while (size-- > 0)
		 */
		"\tadd %4, %%edi\n"
		"\tadd %5, %%esi\n"
		"\tadd %6, %%ebx\n"
		"\tdecl %%edx\n"
		"\tjnz 1b\n"
		"\tjmp 6f\n"

		/*
		 *  sample > 0x7fff
		 */

		"4:"
		"\tmovw $0x7fff, %%ax\n"
		"\tmovw %%ax, (%%edi)\n"
		"\tcmpl %%ecx,(%%ebx)\n"
		"\tjnz 3b\n"
		"\tadd %4, %%edi\n"
		"\tadd %5, %%esi\n"
		"\tadd %6, %%ebx\n"
		"\tdecl %%edx\n"
		"\tjnz 1b\n"
		"\tjmp 6f\n"

		/*
		 *  sample < -0x8000
		 */

		"5:"
		"\tmovw $-0x8000, %%ax\n"
		"\tmovw %%ax, (%%edi)\n"
		"\tcmpl %%ecx, (%%ebx)\n"
		"\tjnz 3b\n"
		"\tadd %4, %%edi\n"
		"\tadd %5, %%esi\n"
		"\tadd %6, %%ebx\n"
		"\tdecl %%edx\n"
		"\tjnz 1b\n"
		// "\tjmp 6f\n"
		
		"6:"

		: /* no output regs */
		: "m" (size), "m" (dst), "m" (src), "m" (sum), "m" (dst_step), "m" (src_step), "m" (sum_step)
		: "esi", "edi", "edx", "ecx", "ebx", "eax"
	);
}


void mix_areas2(unsigned int size,
		volatile s16 *dst, s16 *src,
		volatile s32 *sum,
		unsigned int dst_step, unsigned int src_step)
{
	while (size-- > 0) {
		s32 sample = *src;
		if (cmpxchg(dst, 0, 1) == 0)
			sample -= *sum;
		atomic_add(sum, sample);
		do {
			sample = *sum;
			s16 s;
			if (unlikely(sample & 0xffff0000))
				s = sample > 0 ? 0x7fff : -0x8000;
			else
				s = sample;
			*dst = s;
		} while (unlikely(sample != *sum));
		sum++;
		dst += dst_step;
		src += src_step;
	}
}

int main(int argc, char **argv)
{
	int size = atoi(argv[1]);
	int n = atoi(argv[2]);
	int max = atoi(argv[3]);
	int i;
	unsigned long long begin, end;
	s16 *dst = malloc(sizeof(*dst) * size);
	s32 *sum = calloc(size, sizeof(*sum));
	s16 **srcs = malloc(sizeof(*srcs) * n);
	for (i = 0; i < n; i++) {
		int k;
		s16 *s;
		srcs[i] = s = malloc(sizeof(s16) * size);
		for (k = 0; k < size; ++k, ++s) {
			*s = (rand() % (max * 2)) - max;
		}
	}
	rdtscll(begin);
	for (i = 0; i < n; i++) {
		mix_areas0(size, dst, srcs[i], sum, 1, 1);
	}
	rdtscll(end);
	printf("mix_areas0: %lld\n", end - begin);
	rdtscll(begin);
	for (i = 0; i < n; i++) {
		mix_areas1(size, dst, srcs[i], sum, 1, 1, 1);
	}
	rdtscll(end);
	printf("mix_areas1: %lld\n", end - begin);
	rdtscll(begin);
	for (i = 0; i < n; i++) {
		mix_areas2(size, dst, srcs[i], sum, 1, 1);
	}
	rdtscll(end);
	printf("mix_areas2: %lld\n", end - begin);
}

--------------F27CE0E99BDED5320D02BE73--



-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
