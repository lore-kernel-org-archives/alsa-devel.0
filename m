Return-Path: <SRS0=heU4=AM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A95C433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 19:47:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3D9F2082F
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 19:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fj1kVoPD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3D9F2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 90FFD1679;
	Wed,  1 Jul 2020 21:46:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 90FFD1679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593632859;
	bh=gu6E/P4pw1FlroVHH+Y2/b1qr5Hh2j3CZbuR7tDONJI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fj1kVoPDrQACfcrY0WLoiD3kbfG8aVrzBFMq8A28eOZK2sI49QrXzsNavn3RENOlo
	 I09UsDGSyUZJGcpJ9ggD4hejze6yKuA6d1J1yidM8zi+RGIIzH1B116a9iNqOIGsMj
	 UOa+Kk3pas+wJ8VKiXmrMPvdpwEp8k6RTuPDv0aY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 14F29F8020C;
	Wed,  1 Jul 2020 21:46:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 56AE8F80217; Wed,  1 Jul 2020 21:46:47 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EBC66F800C1
 for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2020 21:46:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EBC66F800C1
IronPort-SDR: RAyaQ5aQ48ypO+sICKiiS2Qy891v7i+9hAj64YOlgtLiwHqdUkDLUQCD7njEfU0a8VKjQOMz/l
 xyj7SenZ0DHw==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="145777832"
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; d="scan'208";a="145777832"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2020 12:46:40 -0700
IronPort-SDR: qvtnx4bm3+4pxd36Ik9wvC7W1BPk5Cmx9bMDuTWRDCyrb2afNfWbRXGtGr+nuTmVFTt6rONibS
 SAxQpcWzktww==
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; d="scan'208";a="266844800"
Received: from sawhitac-mobl.amr.corp.intel.com (HELO [10.254.111.76])
 ([10.254.111.76])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2020 12:46:40 -0700
Subject: Re: [PATCH 1/6] ASoC: Intel: cht_bsw_rt5672: Change bus format to I2S
 2 channel
To: Sasha Levin <sashal@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>
References: <20200628155231.71089-2-hdegoede@redhat.com>
 <20200701193320.C948B20870@mail.kernel.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <869046c6-030c-9243-784d-ecabdb774fa7@linux.intel.com>
Date: Wed, 1 Jul 2020 14:46:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200701193320.C948B20870@mail.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org
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



On 7/1/20 2:33 PM, Sasha Levin wrote:
> Hi
> 
> [This is an automated email]
> 
> This commit has been processed because it contains a -stable tag.
> The stable tag indicates that it's relevant for the following trees: all
> 
> The bot has tested the following trees: v5.7.6, v5.4.49, v4.19.130, v4.14.186, v4.9.228, v4.4.228.
> 
> v5.7.6: Build OK!
> v5.4.49: Failed to apply! Possible dependencies:
>      0d1571c197a92 ("ASoC: intel: use asoc_rtd_to_cpu() / asoc_rtd_to_codec() macro for DAI pointer")

This patch is probably the missing dependency, but it's quite large and 
invasive.

if we wanted to apply this patch to stable versions < 5.7, we should 
replace all occurrences of

asoc_rtd_to_cpu(rtd, 0) by rtd->cpu_dai

and

asoc_rtd_to_codec(rtd, 0) by rtd->codec_dai


