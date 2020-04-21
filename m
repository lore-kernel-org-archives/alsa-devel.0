Return-Path: <SRS0=/Ps/=6F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4897FC2BA19
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Apr 2020 06:09:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C611F2076C
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Apr 2020 06:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MSy7T3Lf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="fnBot7Fc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C611F2076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2FDBE168B;
	Tue, 21 Apr 2020 08:08:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2FDBE168B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587449354;
	bh=8Wr3vmYu/mq/w8uhafZUqAy14r7YDvdzZq2xhQI2OGk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MSy7T3LfEbKCHc4Q4zddzoZ1rDFfqEkb6YmUgk1FB3czjC68OUxjaT4e3Y01z0K4b
	 WHlvw1U2tkttrF/oX7W1nWx+uiGQ+CaMoL3An2wVd5VCBLrynsS3odRdu1kJviLFC5
	 iRACx8+jsLTsQzru3jLPXlU47c+h/gIvTODIlsd4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 25DC9F802A7;
	Tue, 21 Apr 2020 08:04:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E53F1F801D9; Tue, 21 Apr 2020 03:05:11 +0200 (CEST)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 50C21F8012F
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2020 03:05:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 50C21F8012F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au
 header.b="fnBot7Fc"
Received: by mail-ej1-x642.google.com with SMTP id x1so9573827ejd.8
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2020 18:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=t8z5VWgZjAeVfvVL0BHA/W6t+TdOdX0ymrvMNRwoeHU=;
 b=fnBot7Fca5TUmQ+L/rzFjjgDHgWyUpL6VYXI3UIDIxDcBP3XiNLfj1Nx9+mgYro9E8
 nOzgZqN3ff21PyjfYlwWFvZ/SwF90ECV1p10n/SHiVSwYLkIqkgl3cnWutvLcN0DIVvA
 TO3s9vVb1oQnnCvYdRxldq2yl2Y5BucmZzJpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=t8z5VWgZjAeVfvVL0BHA/W6t+TdOdX0ymrvMNRwoeHU=;
 b=VYElflE0vl27itSy7bA7DmqGQp3x0ospCB+iesoP17aP8cQeV5fqlwIXV/TJW+3glD
 0oJVNQYV+iehh9gcqI4byyE7cLjdhqL8CXdyiEOPFgd/5wFbfc+mj3PPU2LUZw3a5PHn
 r0Te2CXyKAWEoCj/nsqvt+13cFFNyezWbAyybMCL2/lROWTeJNI49QQKJMsKI0dFvr++
 ixb2cQVLLf/uqU0eoOOT1v3vmHad+MPTJiHqG54wb8ElKJe9L9dMEl1Ir63pOrbkIT4t
 PfNrE1mempdCgaq18pwblWrmJbaWq/jTBrVnIU1FfMOR82p4Ny2Dv28bB6qGVixRMwrB
 cxkA==
X-Gm-Message-State: AGi0PuYqwI9xUwCKmqUM7QxtwC68o32rgzTTSzzSU92mVzwUZQMGsdgt
 NPJeumqo+QY85TuYQ3DzqnqMYz0VIeiAjj+dE4o=
X-Google-Smtp-Source: APiQypJ9RQ8Y7J3lsg/SXPX3NDFzgPc/25FyFFqsjHr5dq96MspGxBWOZgQtwUEIsHMU5TVbe4X9G0cCfOVIHxGNmF0=
X-Received: by 2002:a17:907:2155:: with SMTP id
 rk21mr19400529ejb.163.1587431100366; 
 Mon, 20 Apr 2020 18:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <a5945463f86c984151962a475a3ee56a2893e85d.1587407777.git.christophe.leroy@c-s.fr>
 <bb0a6081f7b95ee64ca20f92483e5b9661cbacb2.1587407777.git.christophe.leroy@c-s.fr>
In-Reply-To: <bb0a6081f7b95ee64ca20f92483e5b9661cbacb2.1587407777.git.christophe.leroy@c-s.fr>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 21 Apr 2020 01:04:48 +0000
Message-ID: <CACPK8Xf+h378ddF_YakTT++gv_Zx-raBqg54VkKPS3=qe6193Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] powerpc: Remove _ALIGN_UP(),
 _ALIGN_DOWN() and _ALIGN()
To: Christophe Leroy <christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 21 Apr 2020 08:04:35 +0200
Cc: linux-fbdev@vger.kernel.org, kvm@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel@lists.freedesktop.org, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Mon, 20 Apr 2020 at 18:39, Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>
> These three powerpc macros have been replaced by
> equivalent generic macros and are not used anymore.
>
> Remove them.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Reviewed-By: Joel Stanley <joel@jms.id.au>

riscv has a copy of these too that could probably be removed:

arch/riscv/include/asm/page.h:#define _ALIGN_UP(addr, size)
(((addr)+((size)-1))&(~((size)-1)))
arch/riscv/include/asm/page.h:#define _ALIGN(addr, size)
_ALIGN_UP(addr, size)



> ---
>  arch/powerpc/include/asm/page.h | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
> index 3ee8df0f66e0..a63fe6f3a0ff 100644
> --- a/arch/powerpc/include/asm/page.h
> +++ b/arch/powerpc/include/asm/page.h
> @@ -249,13 +249,6 @@ static inline bool pfn_valid(unsigned long pfn)
>  #include <asm/page_32.h>
>  #endif
>
> -/* align addr on a size boundary - adjust address up/down if needed */
> -#define _ALIGN_UP(addr, size)   __ALIGN_KERNEL(addr, size)
> -#define _ALIGN_DOWN(addr, size)        ((addr)&(~((typeof(addr))(size)-1)))
> -
> -/* align addr on a size boundary - adjust address up if needed */
> -#define _ALIGN(addr,size)     _ALIGN_UP(addr,size)
> -
>  /*
>   * Don't compare things with KERNELBASE or PAGE_OFFSET to test for
>   * "kernelness", use is_kernel_addr() - it should do what you want.
> --
> 2.25.0
>
