From: "Michel Benoit" <murpme@gmail.com>
Subject: Re: alsa on Atmel at91
Date: Thu, 10 May 2007 15:28:24 +0200
Message-ID: <c88e466f0705100628j464b3876u90d48a8fe10e52cd@mail.gmail.com>
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
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 921EE2438E
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2007 15:28:25 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id l8so552168nzf
	for <alsa-devel@alsa-project.org>; Thu, 10 May 2007 06:28:24 -0700 (PDT)
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

After digging through the assembler files it seems that its
__old_snd_pcm_hw_params_get_period_size that is called.



sub	r3, fp, #28
	sub	r2, fp, #32
	ldr	r0, [fp, #-40]
	mov	r1, r3
	bl	snd_pcm_hw_params_get_period_size
	mov	r3, r0
	str	r3, [fp, #-20]
