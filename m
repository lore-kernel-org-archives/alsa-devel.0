Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2EAC4332F
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Nov 2022 03:43:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F1FA91697;
	Fri, 18 Nov 2022 04:42:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F1FA91697
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668742998;
	bh=7PBcqk2ClhQYoKBS8Ds44tRRYAvQ1MqcJdEyoMYD760=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U6X2NmzaUKDMKxAgJs47FtxOV/mopvuxr6Zkw7+PcAAKSUwfP/TEFpMtvL7QRfpUC
	 utEVSI3zxT0FS3Re8XmvkaS8hx8+/fbRYjJiulKmpSfaQHCpuqHa3fpG5OLC8xzxt8
	 PF7yTs+hL5p2Ke8F8oD8e6kuw4o9M8GBcKJAEwJE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9CF36F8016E;
	Fri, 18 Nov 2022 04:42:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DF544F801D8; Fri, 18 Nov 2022 04:42:25 +0100 (CET)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D90B5F800B8
 for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2022 04:42:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D90B5F800B8
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ND2Zg0NrSzJnjl;
 Fri, 18 Nov 2022 11:39:07 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 11:42:17 +0800
Subject: Re: [PATCH] ASoC: amd: acp: Fix possible UAF in acp_dma_open
To: Mark Brown <broonie@kernel.org>
References: <20221117061248.3018292-1-cuigaosheng1@huawei.com>
 <Y3YX/LsLzSU+jQ7A@sirena.org.uk>
From: cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <2e8cfa9c-ed53-a218-69cb-b45c8c156de4@huawei.com>
Date: Fri, 18 Nov 2022 11:42:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <Y3YX/LsLzSU+jQ7A@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.176]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
 error27@gmail.com, AjitKumar.Pandey@amd.com, venkataprasad.potturu@amd.com,
 tiwai@suse.com, lgirdwood@gmail.com, nathan@kernel.org,
 Vijendar.Mukunda@amd.com, Vsujithkumar.Reddy@amd.com
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

> Is it not better to only add the newly allocated stream to the
> list once it's fully initialised?  Otherwise something could be
> using a partially initialised item from the list.

Thanks for taking time to review this patch.

I have made a patch v2 and submit it, fix it by adding the newly allocated stream to the
list once it's fully initialised.

On 2022/11/17 19:16, Mark Brown wrote:
> On Thu, Nov 17, 2022 at 02:12:48PM +0800, Gaosheng Cui wrote:
>> Smatch report warning as follows:
>>
>> sound/soc/amd/acp/acp-platform.c:199 acp_dma_open() warn:
>>    '&stream->list' not removed from list
>>
>> If snd_pcm_hw_constraint_integer() fails in acp_dma_open(),
>> stream will be freed, but stream->list will not be removed from
>> adata->stream_list, then list traversal may cause UAF.
> Is it not better to only add the newly allocated stream to the
> list once it's fully initialised?  Otherwise something could be
> using a partially initialised item from the list.
