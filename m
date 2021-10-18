Return-Path: <SRS0=JS7s=PG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4018DC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Oct 2021 21:15:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F13EB6115A
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Oct 2021 21:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F13EB6115A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9BDF316BC;
	Mon, 18 Oct 2021 23:14:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9BDF316BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634591698;
	bh=d8bsQ+B9xcFLV30FPz+woYAVYPS9fJw94srOhmPs1uM=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n1OrMEpWL1j0HHRKd7l8hKm+9cDQFJ3Yb3rHMWfZiexjm5vls4DfvgbSdijWYMMrF
	 6ssZQXpwex9eUtWKReyRAPrRrH11K2htmA3a21s2/+sFAelutXwiN7aL6DRKWGA7Rt
	 OusmEH+DPWt/dISIRebHd7AXaQJtTmfcqgwtTXfQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 150CFF80217;
	Mon, 18 Oct 2021 23:14:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 703D4F80224; Mon, 18 Oct 2021 23:14:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CB6B0F80159
 for <alsa-devel@alsa-project.org>; Mon, 18 Oct 2021 23:14:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CB6B0F80159
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="Yp5k+3H3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634591641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6eBzORXCbFEMu4YDfNXk+RL3umCNwL4ub/VK7Fp9vPc=;
 b=Yp5k+3H349YrCUHrKhtOtOD35uPxmJPLz0gnEkDYVicgk6eZJnEF9DESUK24VjdrnCk1ga
 HQhuoAvvh/YxLX03Powm5AOfNyRCxOn/SSOhTmmpXpOhekVbmC18796vf5JC1ndhcr09WJ
 GuQAFQ2k1rDYaHTJwaljWslRbZopcOc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-nlGKvzbuPlSwqYSTphYAxw-1; Mon, 18 Oct 2021 17:13:59 -0400
X-MC-Unique: nlGKvzbuPlSwqYSTphYAxw-1
Received: by mail-ed1-f69.google.com with SMTP id
 g28-20020a50d0dc000000b003dae69dfe3aso15567479edf.7
 for <alsa-devel@alsa-project.org>; Mon, 18 Oct 2021 14:13:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=6eBzORXCbFEMu4YDfNXk+RL3umCNwL4ub/VK7Fp9vPc=;
 b=gYeXkd5LOo04VeV+XJ7Nlsl3qyt3OuhIsgFG4y6x6aW7mAGCbNhT/J3LxhQqZAOpmL
 DmAPv9cq46/epioesSgajyZ9V6NqfV/sXriH02tuQJIIzQ29mtNrquslObu14V63dAAe
 kzsVKpCCKNaPFyZgVkr0VEhLqmk5ASwgLAhFwSjY5Zh6f6TbS8sWSJiDe+GPkv3rX/8W
 LTAgfQcxw1nrRDFPKrM5cgg94fZJgum7c3ef1Xq7YVD6UP3XW5CR9auwpjs0Oze/ScCO
 OOj+eC8kSx4WNFAje0lK+WPV/z46W88dXS7zFZiojbC0zGr+8jVOofLhQ9BhIlWDDnRU
 rT/A==
X-Gm-Message-State: AOAM532el8LAq/SzUi5jmthhTONILjKoY9XLFGl05u41/JH59ZsQpPL5
 ObvCyT5HB4rbguveUc1/J3io0S/WRobVxzglEziPG9FO2Md28NST0bHZL1H7m21FQGLyA4v9MWF
 Ye2lc3uHu1GfqWq7D0Z+7Zhc=
X-Received: by 2002:a17:906:4895:: with SMTP id
 v21mr33861134ejq.299.1634591638507; 
 Mon, 18 Oct 2021 14:13:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxR/1A9wzRRVEB3L+RBQpU75fFxxxvftqHqqkyF3AqtMVIPa7tvvcHIcNFBuxFp+GpIaMN07g==
X-Received: by 2002:a17:906:4895:: with SMTP id
 v21mr33861086ejq.299.1634591638159; 
 Mon, 18 Oct 2021 14:13:58 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214?
 (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
 by smtp.gmail.com with ESMTPSA id z13sm6933808ejl.106.2021.10.18.14.13.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Oct 2021 14:13:57 -0700 (PDT)
Message-ID: <c34cc4b8-31c8-9425-214f-2a0f39f048d9@redhat.com>
Date: Mon, 18 Oct 2021 23:13:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 1/3] ASoC: Intel: Move soc_intel_is_foo() helpers to a
 generic header
To: Mark Brown <broonie@kernel.org>
References: <20211018143324.296961-1-hdegoede@redhat.com>
 <20211018143324.296961-2-hdegoede@redhat.com>
 <YW2UNRAWUphJqhyW@sirena.org.uk>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YW2UNRAWUphJqhyW@sirena.org.uk>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Gross <markgross@kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, linux-input@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, Andy Shevchenko <andy@infradead.org>
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

Hi Mark,

On 10/18/21 17:35, Mark Brown wrote:
> On Mon, Oct 18, 2021 at 04:33:22PM +0200, Hans de Goede wrote:
>> The soc_intel_is_foo() helpers from
>> sound/soc/intel/common/soc-intel-quirks.h are useful outside of the
>> sound subsystem too.
> 
> Acked-by: Mark Brown <broonie@kernel.org>

Does this mean that you are ok with me merging patch 1 + 2 through
the drivers/platform/x86 tree ?

Regards,

Hans

