Return-Path: <SRS0=M4Y+=24=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6CBC33C8C
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:55:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D950207E0
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Dp3wFWYa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="jjYEdiq7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D950207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 15BAC181A;
	Tue,  7 Jan 2020 12:54:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 15BAC181A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578398126;
	bh=/GpLyHNFT6WtYTrz0bP3rVCrrKmAXb2g7QU2yiqrpuk=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dp3wFWYaRnikDlukENM6PJG//xs/joraqKYpomv/nuq2u7xX7Zz/+jdl8RapOQR08
	 JzIO5ClQtsdVq8KWzCgDwclKs+rOEBYGBsDFzJp5PBAFgn89fffWXrLQ3mhp4v5yqA
	 oBHtBATPXpjuXl5503FcC4m1KhR9Hfyz6yo2vA9A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 98087F80140;
	Tue,  7 Jan 2020 12:54:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F0EA5F8014A; Tue,  7 Jan 2020 12:54:33 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 78E2CF8010D
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2020 12:54:30 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 68C32A003F;
 Tue,  7 Jan 2020 12:54:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 68C32A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1578398070; bh=izrHSAxfOMBujDEpmws/4YpRYbdRqfoTtmBuUugHreY=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=jjYEdiq7utC3TxRG9GdRTMhO31uv0H6qUGkufOdBuZjox6eW0sSAr1DWswqu5WjIE
 z9CC2/Mt5X9myZcYcBxuNOcK5pvc17EFmcpkULDjrnLSDJtUQUmNhTTdax0YWtHAOQ
 XKrMhiQs7ia8AwrpSuGANPFNoUC4RlSplo57DWpg=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Tue,  7 Jan 2020 12:54:26 +0100 (CET)
To: Hans de Goede <hdegoede@redhat.com>
References: <20200106131159.476744-1-hdegoede@redhat.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <9f6ffcbe-10fe-91fa-3998-029c2837a39d@perex.cz>
Date: Tue, 7 Jan 2020 12:54:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200106131159.476744-1-hdegoede@redhat.com>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 youling 257 <youling257@gmail.com>
Subject: Re: [alsa-devel] [PATCH alsa-ucm-conf] bytcht-es8316: Fix missing
 including of HeadPhones.conf after ucm2 conversion
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Dne 06. 01. 20 v 14:11 Hans de Goede napsal(a):
> The conversion to ucm2 format missed adding an include for:
> 
> codecs/es8316/HeadPhones.conf
> 
> Leading to no sound on the headphones output, this commit adds the missing
> include fixing this.

Applied. Thank you for the fix.

					Jaroslav

> 
> Cc: youling 257 <youling257@gmail.com>
> Reported-by: youling 257 <youling257@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   ucm2/bytcht-es8316/HiFi-Components.conf | 2 ++
>   ucm2/bytcht-es8316/HiFi-LongName.conf   | 2 ++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/ucm2/bytcht-es8316/HiFi-Components.conf b/ucm2/bytcht-es8316/HiFi-Components.conf
> index 314d355..c40bd49 100644
> --- a/ucm2/bytcht-es8316/HiFi-Components.conf
> +++ b/ucm2/bytcht-es8316/HiFi-Components.conf
> @@ -20,6 +20,8 @@ If.mono {
>   	}
>   }
>   
> +<codecs/es8316/HeadPhones.conf>
> +
>   If.in1 {
>   	Condition {
>   		Type String
> diff --git a/ucm2/bytcht-es8316/HiFi-LongName.conf b/ucm2/bytcht-es8316/HiFi-LongName.conf
> index ea7d1c3..03cf17b 100644
> --- a/ucm2/bytcht-es8316/HiFi-LongName.conf
> +++ b/ucm2/bytcht-es8316/HiFi-LongName.conf
> @@ -20,6 +20,8 @@ If.mono {
>   	}
>   }
>   
> +<codecs/es8316/HeadPhones.conf>
> +
>   If.in1 {
>   	Condition {
>   		Type String
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
