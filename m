From: "Michel Benoit" <murpme@gmail.com>
Subject: Re: alsa on Atmel at91
Date: Thu, 10 May 2007 15:44:07 +0200
Message-ID: <c88e466f0705100644q50f89fbfr3499a4491d741f2b@mail.gmail.com>
References: <c88e466f0704151238q326df219uf95679897f4c44@mail.gmail.com>
	<1176813173.32188.181.camel@a10072.wolfsonmicro.main>
	<c88e466f0704170857k27a7dc9fk63490e3d4acd172b@mail.gmail.com>
	<1176827782.32188.224.camel@a10072.wolfsonmicro.main>
	<c88e466f0704180218p708ba602h766f6a3f36c1add0@mail.gmail.com>
	<1176889951.32188.246.camel@a10072.wolfsonmicro.main>
	<c88e466f0704180500l2f016c4bs28c6a3c1a3663575@mail.gmail.com>
	<1176900272.32188.274.camel@a10072.wolfsonmicro.main>
	<c88e466f0704180745k1201ff11kc477d9cc8ebf899c@mail.gmail.com>
	<c88e466f0705100429w7a4e86deyfea22508370358fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.231])
	by alsa0.perex.cz (Postfix) with ESMTP id 58AA22439E
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2007 15:44:09 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id l8so557715nzf
	for <alsa-devel@alsa-project.org>; Thu, 10 May 2007 06:44:08 -0700 (PDT)
In-Reply-To: <c88e466f0705100429w7a4e86deyfea22508370358fd@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org

After digging through the assembler files it seems that for some
reason a function  called
__old_snd_pcm_hw_params_get_period_size that uses another procedure
calling standard is used.


Here is the code in libasound:

.symver __snd_pcm_hw_params_get_period_size,snd_pcm_hw_params_get_period_size@@ALSA_0.9.0rc4
	.symver __old_snd_pcm_hw_params_get_period_size,snd_pcm_hw_params_get_period_size@ALSA_0.9

	.align	2
	.global	__snd_pcm_hw_params_get_period_size
	.type	__snd_pcm_hw_params_get_period_size, %function
__snd_pcm_hw_params_get_period_size:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, lr}
	sub	sp, sp, #4
	mov	r3, r2
	mov	r4, r1
	mov	r2, sp
	mov	r1, #13
	bl	snd_pcm_hw_param_get(PLT)
	cmp	r0, #0
	ldrge	r3, [sp, #0]
	strge	r3, [r4, #0]
	add	sp, sp, #4
	ldmfd	sp!, {r4, pc}
	.size	__snd_pcm_hw_params_get_period_size,
.-__snd_pcm_hw_params_get_period_size
	.align	2
	.global	__old_snd_pcm_hw_params_get_period_size
	.type	__old_snd_pcm_hw_params_get_period_size, %function
__old_snd_pcm_hw_params_get_period_size:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 0, uses_anonymous_args = 0
	str	lr, [sp, #-4]!
	sub	sp, sp, #4
	mov	r2, r1
	mov	r1, sp
	bl	__snd_pcm_hw_params_get_period_size(PLT)
	mov	r3, #0
	cmp	r0, r3
	ldrge	r3, [sp, #0]
	mov	r0, r3
	add	sp, sp, #4
	ldmfd	sp!, {pc}
	.size	__old_snd_pcm_hw_params_get_period_size,
.-__old_snd_pcm_hw_params_get_period_size

	
And here is the code that calls the lib function:

       sub     r3, fp, #28
       sub     r2, fp, #32
       ldr     r0, [fp, #-40]
       mov     r1, r3
       bl      snd_pcm_hw_params_get_period_size
       mov     r3, r0
       str     r3, [fp, #-20]


Clearly if __old_snd_pwm_hw_params_get_period_size() is called then
'dir' gets 'val's address and the 'val' is some irrelevant data from
the stack.  Calling __snd_pwm_hw_params_get_period_size() directly
should work.

What is __old_snd_pwm_hw_params_get_period_size()  and how do I get rid of it?
What does @ALSA_0.9 mean?

Michel
