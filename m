From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Mix alternative comparison
Date: Wed, 19 Feb 2003 23:29:24 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E540544.8058F485@libero.it>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------C426B5AD31DEFDB6DCBCAB21"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------C426B5AD31DEFDB6DCBCAB21
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Here you have the second round.

I think to have enough data to affirm the following:

1) current hand made asm has some serious bug about both correctness and
efficiency
2) naive approach has a non marginal failure rate 
3) server-less approach is much less efficient than server based
approach

Take in consideration these results:
$ ./sum 2048 8 16384
CPU clock: 1460475899.426625
mix_areas0: 87191 0.032139%
mix_areas1: 145666 0.053692% (365)
mix_areas2: 3034611 1.118555% (1217)
mix_areas3: 327412 0.120684% (0)

The server based approach needs about 0.03% of CPU power to mix one
stream stereo s16 @44100 Hz.
The fastest server-less approach I'm now able to invent needs 0.12%.

It's not a big fraction, but I think that to have a lot of machine power
available is never an excuse to waste it.

The naive approach is much better but with 8 random mixed streams it has
near 18% probability to give wrong results (with an average power for
each stream of 25%).

I'd suggest to use dmix like approach for pcm_share, pcm_snoop and for
the sum part of pcm_mix, but to use a separate thread for saturate,
transfer to hardware and silence.

I hope this will be useful for ALSA to take the right path.

P.S. I was almost forgetting how much is enjoyable to work for ALSA ;-)

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy
--------------C426B5AD31DEFDB6DCBCAB21
Content-Type: text/plain; charset=us-ascii;
 name="sum.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sum.c"

#include <stdlib.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/time.h>

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
		LOCK_PREFIX "addl %1,%0"
		:"=m" (*dst)
		:"ir" (v), "m" (*dst));
}


static double
detect_cpu_clock()
{
        struct timeval tm_begin, tm_end;
        unsigned long long tsc_begin, tsc_end;

        /* Warm cache */
        gettimeofday(&tm_begin, 0);

        rdtscll(tsc_begin);
        gettimeofday(&tm_begin, 0);

        usleep(1000000);

        rdtscll(tsc_end);
        gettimeofday(&tm_end, 0);

        return (tsc_end - tsc_begin) / (tm_end.tv_sec - tm_begin.tv_sec + (tm_end.tv_usec - tm_begin.tv_usec) / 1e6);
}

void mix_areas0(unsigned int size,
		const s16 *src,
		volatile s32 *sum,
		unsigned int src_step)
{
	while (size-- > 0) {
		atomic_add(sum, *src);
		src += src_step;
		sum++;
	}
}

void saturate(unsigned int size,
	      s16 *dst, const s32 *sum,
	      unsigned int dst_step)
{
	while (size-- > 0) {
		s32 sample = *sum;
		if (unlikely(sample < -0x8000))
			*dst = -0x8000;
		else if (unlikely(sample > 0x7fff))
			*dst = 0x7fff;
		else
			*dst = sample;
		dst += dst_step;
		sum++;
	}
}

void mix_areas1(unsigned int size,
		volatile s16 *dst, const s16 *src,
		unsigned int dst_step, unsigned int src_step)
{
	while (size-- > 0) {
		s32 sample = *dst + *src;
		if (unlikely(sample < -0x8000))
			*dst = -0x8000;
		else if (unlikely(sample > 0x7fff))
			*dst = 0x7fff;
		else
			*dst = sample;
		dst += dst_step;
		src += src_step;
	}
}

void mix_areas2(unsigned int size,
		volatile s16 *dst, const s16 *src,
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


void mix_areas3(unsigned int size,
		volatile s16 *dst, const s16 *src,
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
			if (unlikely(sample < -0x8000))
				*dst = -0x8000;
			else if (unlikely(sample > 0x7fff))
				*dst = 0x7fff;
			else
				*dst = sample;
		} while (unlikely(sample != *sum));
		sum++;
		dst += dst_step;
		src += src_step;
	}
}

int compare(const s16* b1, const s16 *b2, unsigned int size)
{
	unsigned int c = 0;
	while (size-- > 0) {
		if (*b1 != *b2)
			c++;
		b1++;
		b2++;
	}
	return c;
}

int main(int argc, char **argv)
{
	int size = atoi(argv[1]);
	int n = atoi(argv[2]);
	int max = atoi(argv[3]);
	int i;
	unsigned long long begin, end;
	s16 *dst = malloc(sizeof(*dst) * size);
	s16 *check = malloc(sizeof(*check) * size);
	s32 *sum = malloc(sizeof(*sum) * size);
	s16 **srcs = malloc(sizeof(*srcs) * n);
	double cpu_clock = detect_cpu_clock();
	printf("CPU clock: %f\n", cpu_clock);
	for (i = 0; i < n; i++) {
		int k;
		s16 *s;
		srcs[i] = s = malloc(sizeof(s16) * size);
		for (k = 0; k < size; ++k, ++s) {
			*s = (rand() % (max * 2)) - max;
		}
	}

	memset(sum, 0, sizeof(*sum) * size);
	rdtscll(begin);
	for (i = 0; i < n; i++) {
		mix_areas0(size, srcs[i], sum, 1);
	}
	saturate(size, check, sum, 1);
	rdtscll(end);
	printf("mix_areas0: %lld %f%%\n", end - begin, 100*2*44100.0*(end - begin)/(size*n*cpu_clock));

	memset(dst, 0, sizeof(*dst) * size);
	rdtscll(begin);
	for (i = 0; i < n; i++) {
		mix_areas1(size, dst, srcs[i], 1, 1);
	}
	rdtscll(end);
	printf("mix_areas1: %lld %f%% (%d)\n", end - begin, 100*2*44100.0*(end - begin)/(size*n*cpu_clock), compare(dst, check, size));

	memset(sum, 0, sizeof(*sum) * size);
	rdtscll(begin);
	for (i = 0; i < n; i++) {
		mix_areas2(size, dst, srcs[i], sum, 1, 1, 1);
	}
	rdtscll(end);
	printf("mix_areas2: %lld %f%% (%d)\n", end - begin, 100*2*44100.0*(end - begin)/(size*n*cpu_clock), compare(dst, check, size));

	memset(sum, 0, sizeof(*sum) * size);
	rdtscll(begin);
	for (i = 0; i < n; i++) {
		mix_areas3(size, dst, srcs[i], sum, 1, 1);
	}
	rdtscll(end);
	printf("mix_areas3: %lld %f%% (%d)\n", end - begin, 100*2*44100.0*(end - begin)/(size*n*cpu_clock), compare(dst, check, size));
	return 0;
}

--------------C426B5AD31DEFDB6DCBCAB21--



-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
