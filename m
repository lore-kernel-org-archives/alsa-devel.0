From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH V4 1/5] The macro spin_event_timeout() takes a condition
	and timeout value
Date: Tue, 26 May 2009 09:29:31 +0200 (CEST)
Message-ID: <alpine.LRH.2.00.0905260928320.31893@vixen.sonytel.be>
References: <20090525221406.21370.30326.stgit@terra>
	<20090525221507.21370.68301.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org>
In-Reply-To: <20090525221507.21370.68301.stgit@terra>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk, timur@freescale.com
List-Id: alsa-devel@alsa-project.org

On Mon, 25 May 2009, Jon Smirl wrote:
> (in microseconds) as parameters.  It spins until either the condition is =
true
> or the timeout expires.  It returns the result of the condition when the =
loop
> was terminated.
> =

> This primary purpose of this macro is to poll on a hardware register unti=
l a
> status bit changes.  The timeout ensures that the loop still terminates i=
f the
> bit doesn't change as expected.  This macro makes it easier for driver
> developers to perform this kind of operation properly.
> =

> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>  arch/powerpc/include/asm/delay.h |   33 +++++++++++++++++++++++++++++++++
>  1 files changed, 33 insertions(+), 0 deletions(-)
> =

> diff --git a/arch/powerpc/include/asm/delay.h b/arch/powerpc/include/asm/=
delay.h
> index f9200a6..fedf037 100644
> --- a/arch/powerpc/include/asm/delay.h
> +++ b/arch/powerpc/include/asm/delay.h
> @@ -2,8 +2,11 @@
>  #define _ASM_POWERPC_DELAY_H
>  #ifdef __KERNEL__
>  =

> +#include <asm/time.h>
> +
>  /*
>   * Copyright 1996, Paul Mackerras.
> + * Copyright (C) 2009 Freescale Semiconductor, Inc. All rights reserved.
>   *
>   * This program is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU General Public License
> @@ -30,5 +33,35 @@ extern void udelay(unsigned long usecs);
>  #define mdelay(n)	udelay((n) * 1000)
>  #endif
>  =

> +/**
> + * spin_event_timeout - spin until a condition gets true or a timeout el=
apses
> + * @condition: a C expression to evalate
> + * @timeout: timeout, in microseconds
> + * @delay: the number of microseconds to delay between eache evaluation =
of
> + *         @condition
> + * @rc: the last value of the condition
> + *
> + * The process spins until the condition evaluates to true (non-zero) or=
 the
> + * timeout elapses.  Upon exit, @rc contains the value of the condition.=
 This
> + * allows you to test the condition without incurring any side effects.
> + *
> + * This primary purpose of this macro is to poll on a hardware register
> + * until a status bit changes.  The timeout ensures that the loop still
> + * terminates even if the bit never changes.  The delay is for devices t=
hat
> + * need a delay in between successive reads.
> + *
> + * gcc will optimize out the if-statement if @delay is a constant.
> + */
> +#define spin_event_timeout(condition, timeout, delay, rc)               =
    \

static inline function, returning rc, instead of a macro?

> +{                                                                       =
    \
> +	unsigned long __loops =3D tb_ticks_per_usec * timeout;                \
> +	unsigned long __start =3D get_tbl();                                  \
> +	while ((rc =3D (condition)) && (tb_ticks_since(__start) <=3D __loops)) \
> +		if (delay)                                                  \
> +			udelay(delay);                                      \
> +		else	                                                    \
> +			cpu_relax();                                        \
> +}
> +
>  #endif /* __KERNEL__ */
>  #endif /* _ASM_POWERPC_DELAY_H */

With kind regards,

Geert Uytterhoeven
Software Architect
Techsoft Centre

Technology and Software Centre Europe
The Corporate Village =B7 Da Vincilaan 7-D1 =B7 B-1935 Zaventem =B7 Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 =B7 RPR Brussels
Fortis =B7 BIC GEBABEBB =B7 IBAN BE41293037680010
