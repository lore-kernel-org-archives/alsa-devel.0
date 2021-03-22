Return-Path: <SRS0=WNy5=IU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67822C433C1
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 19:38:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B69A619A2
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 19:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B69A619A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 39A74886;
	Mon, 22 Mar 2021 20:37:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 39A74886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616441918;
	bh=VWk8uu0aSUK+b9182ecdMUxjHvW81zw/utFFP1rD2BQ=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V3vFsYN7dOVD7bl8oFqDkmMWK7wYwot4CXVsLe/YkE1YNzaXeyMFIO9SWmWuPw8VG
	 rtU0xookM6U0YWUC6lHL/+CwZ8CzCzW1YhZYHnwGRpSa4C6YXZ2tO3pu9rYpDTOpmH
	 Inh4xxaAyghv+ZzU358R1J6VvHOQCQmjQLGHknvA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9B21BF80156;
	Mon, 22 Mar 2021 20:37:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 19572F8016B; Mon, 22 Mar 2021 20:37:45 +0100 (CET)
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 402E1F80155
 for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2021 20:37:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 402E1F80155
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="bs8xMQpY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
 :In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
 Reply-To:Cc:Content-ID:Content-Description;
 bh=tfnBSEYclohJjaV1MdPg0Tk1/ERGZoKsXMbl+7RXvpg=; b=bs8xMQpYmu2xpPxkDu2lPFpji5
 Bq1fBd2MhLdoQH8SKMj9I9qMpF8Zb5kpBpaxnz8r12zktUm9IKQPbbXP98XmACh8EeoGHW3NT4qow
 YyVh9ZiUhf4NPgqO1c23c7sePwWOgPMXpbWJxcIW8dm6+qdRUiCsLVhDFJnpludSgwa+aYAA5/u7Z
 JNrt04x0UXzJRpRlLdNygMNALsAwTfGDaKqzQj4Gu9P2o3JyVlGkOuCKqHAU1NmlpLYD7Tcz7rYZl
 EoO3sSH5/6ALv6oyBYeiYGO+mukXXLXKHRqRVn1yA6Za3HpQ7XFQ3qafWZITdbjrWfxT4GZRsAh2Q
 UzkYjBDw==;
Received: from [2601:1c0:6280:3f0::3ba4]
 by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lOQMo-00CRRu-0W; Mon, 22 Mar 2021 19:37:34 +0000
Subject: Re: [PATCH] ASoC: Intel: Fix a typo
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>, cezary.rojewski@intel.com,
 pierre-louis.bossart@linux.intel.com, liam.r.girdwood@linux.intel.com,
 yang.jie@linux.intel.com, broonie@kernel.org, perex@perex.cz,
 tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20210322065238.151920-1-unixbhaskar@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <226fbfc2-bb32-4ffc-fd61-5eabfd675bd8@infradead.org>
Date: Mon, 22 Mar 2021 12:37:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322065238.151920-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

On 3/21/21 11:52 PM, Bhaskar Chowdhury wrote:
> 
> s/struture/structure/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

The 3 patches with the same Subject: should all be merged into
one patch IMO.


> ---
>  sound/soc/intel/atom/sst-mfld-dsp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/atom/sst-mfld-dsp.h b/sound/soc/intel/atom/sst-mfld-dsp.h
> index 102b0e7eafb0..8d9e29b16e57 100644
> --- a/sound/soc/intel/atom/sst-mfld-dsp.h
> +++ b/sound/soc/intel/atom/sst-mfld-dsp.h
> @@ -256,7 +256,7 @@ struct snd_sst_tstamp {
>  	u32 channel_peak[8];
>  } __packed;
> 
> -/* Stream type params struture for Alloc stream */
> +/* Stream type params structure for Alloc stream */
>  struct snd_sst_str_type {
>  	u8 codec_type;		/* Codec type */
>  	u8 str_type;		/* 1 = voice 2 = music */
> --


-- 
~Randy

