From: matt yee-king <yeeking@no-future.com>
Subject: Re: modprobe of snd-powermac fails
Date: 26 Apr 2002 13:35:06 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1019828111.786.24.camel@bennyhill.belmont>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


heres all the warnings:

_______________________________

 pdplus.c:3032: warning: #warning "This dr
iver need to be ported to new hw_info"
pdplus.c:3082: warning: #warning "This driver need to be ported to new
hw_info"
pdplus.c:3107: warning: #warning "This driver need to be ported to new
hw_info"
pdplus.c:3136: warning: #warning "The S/PDIF setup code needs to be
rewritten."
pdplus.c:3212: warning: #warning "This driver need to be ported to new
hw_info"
In file included from pcm_lib.c:1:
../alsa-kernel/core/pcm_lib.c: In function
`snd_pcm_hw_param_first_R453796f4':
../alsa-kernel/core/pcm_lib.c:1141: warning: unused variable `err'
../alsa-kernel/core/pcm_lib.c: In function
`snd_pcm_hw_param_last_R8ef19ab1':
../alsa-kernel/core/pcm_lib.c:1179: warning: unused variable `err'
../alsa-kernel/ppc/powermac.c:40: warning: `snd_enable' defined but not
used
In file included from pmac.c:1:
../alsa-kernel/ppc/pmac.c: In function `snd_pmac_suspend':
../alsa-kernel/ppc/pmac.c:1321: warning: implicit declaration of
function `disab
le_irq_R3ce4ca6f'
../alsa-kernel/ppc/pmac.c: In function `snd_pmac_resume':
../alsa-kernel/ppc/pmac.c:1350: warning: implicit declaration of
function `enabl
e_irq_Rfcec0987'
In file included from keywest.c:1:
../alsa-kernel/ppc/keywest.c: In function `keywest_writeb_wait':
../alsa-kernel/ppc/keywest.c:51: warning: implicit declaration of
function `udel
ay'

_______________________

heres /usr/include/asm/delay.h
_______________________

/*
 * BK Id: SCCS/s.delay.h 1.7 05/17/01 18:14:24 cort
 */
#ifdef __KERNEL__
#ifndef _PPC_DELAY_H
#define _PPC_DELAY_H

#include <asm/param.h>

/*
 * Copyright 1996, Paul Mackerras.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version
 * 2 of the License, or (at your option) any later version.
 */

extern unsigned long loops_per_jiffy;

/* maximum permitted argument to udelay */
#define __MAX_UDELAY    1000000

extern void __delay(unsigned int loops);

/* N.B. the `secs' parameter here is a fixed-point number with
   the binary point to the left of the most-significant bit. */
extern __inline__ void __const_udelay(unsigned int secs)
{
        unsigned int loops;

        __asm__("mulhwu %0,%1,%2" : "=r" (loops) :
                "r" (secs), "r" (loops_per_jiffy));
        __delay(loops * HZ);


/*
 * note that 4294 == 2^32 / 10^6, multiplying by 4294 converts from
 * microseconds to a 32-bit fixed-point number of seconds.
 */
extern __inline__ void __udelay(unsigned int usecs)
{
        __const_udelay(usecs * 4294);
}

extern void __bad_udelay(void);         /* deliberately undefined */

#define udelay(n) (__builtin_constant_p(n)? \
                   ((n) > __MAX_UDELAY? __bad_udelay():
__const_udelay((n) * 4294u)) : \
                   __udelay(n))

#endif /* defined(_PPC_DELAY_H) */
#endif /* __KERNEL__ */

_________________



any ideas?

 - matthew

:
