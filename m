Return-Path: <SRS0=iUFt=IV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CD1C433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Mar 2021 13:28:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8277961974
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Mar 2021 13:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8277961974
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 16E7C1666;
	Tue, 23 Mar 2021 14:27:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 16E7C1666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616506118;
	bh=rQBfDYMFEiJw4DHlR6zQMYTJlg5EjzC1/boylnQBBY4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nE2R/32KDH4nlhbGy/h3Q5MLuqaNU8+QuZnIx8qMP0gANScBdRVIjQABOAYDK6qoH
	 xnug/znxLBBG4thvMq6LNhL48UTqrGHr4B+v9zpEUi1dj81TDDN8+xChtz/egY3YpX
	 xJZtqybcQ179+iWuCvTdsTb6N52lFlIVqUMBrJlE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 972AAF80155;
	Tue, 23 Mar 2021 14:27:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A0BFEF80257; Tue, 23 Mar 2021 14:27:45 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 28D30F80104
 for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2021 14:27:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 28D30F80104
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ACuICoes"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5417F61974;
 Tue, 23 Mar 2021 13:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616506049;
 bh=rQBfDYMFEiJw4DHlR6zQMYTJlg5EjzC1/boylnQBBY4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ACuICoesxC8oqVeQxm540X8VSv6hCE3GXz9YJ/hh8+UDCFYJTWEHpOy6wMUvdNW0d
 9oQa0TkxoBGlF4H/uogolCAG1TytUpi2zwjZL2ZQB+9PYrmexfRyP9VhyJr6SloSpN
 2TkgvpcvzZXjf+AZrn8moD+ZjA0ekwQh8TmwLlXajpXkWb9aK6QxwweVDeEQNavYqe
 +TXxx+o+WWSZ8qkGK8QbLEBSTplpIfhPVUv7uSFTL851pIOQuknnIP7z7ATjGBt9nk
 Ks/2hNEtrQtNWe1vXiqt2G01Nvoj3fGiY7AizFxSpwALH/6+dDWZW5G/qdmvj1chrq
 9yzGIXh6FJGjQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
 (envelope-from <johan@kernel.org>)
 id 1lOh4U-0003Q4-10; Tue, 23 Mar 2021 14:27:46 +0100
Date: Tue, 23 Mar 2021 14:27:46 +0100
From: Johan Hovold <johan@kernel.org>
To: caizhichao <tomstomsczc@163.com>
Subject: Re: [PATCH] sound/i2c: Simplify the return expression of
 snd_i2c_bit_sendbyte()
Message-ID: <YFns0gJzu4iN8x5F@hovoldconsulting.com>
References: <20210323121443.1276-1-tomstomsczc@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323121443.1276-1-tomstomsczc@163.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Zhichao Cai <caizhichao@yulong.com>, tiwai@suse.com
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

On Tue, Mar 23, 2021 at 08:14:43PM +0800, caizhichao wrote:
> From: Zhichao Cai <caizhichao@yulong.com>
> 
> Simplify the return expression.
> 
> Signed-off-by: Zhichao Cai <caizhichao@yulong.com>
> ---
>  sound/i2c/i2c.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/sound/i2c/i2c.c b/sound/i2c/i2c.c
> index 847e3b6..dfcc87e 100644
> --- a/sound/i2c/i2c.c
> +++ b/sound/i2c/i2c.c
> @@ -235,9 +235,7 @@ static int snd_i2c_bit_sendbyte(struct snd_i2c_bus *bus, unsigned char data)
>  	for (i = 7; i >= 0; i--)
>  		snd_i2c_bit_send(bus, !!(data & (1 << i)));
>  	err = snd_i2c_bit_ack(bus);
> -	if (err < 0)
> -		return err;
> -	return 0;
> +	return err < 0 ? err : 0;

This isn't a simplification, you're just making the code harder to read
for no good reason.

>  }
>  
>  static int snd_i2c_bit_readbyte(struct snd_i2c_bus *bus, int last)

Johan
