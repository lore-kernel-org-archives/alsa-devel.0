Return-Path: <SRS0=qqgH=3Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89894C2D0DB
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jan 2020 15:58:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14DB8206D5
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jan 2020 15:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="F5HSUSFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14DB8206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6177914E;
	Mon, 27 Jan 2020 16:57:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6177914E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580140712;
	bh=RdeHDUuarnTpFc1mcTRIp8COc2Y6EdlvxswQPpa4oj4=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F5HSUSFSUeusp1Qn0aB+Yw2/VxCbDE8nrDiBtcaVQ8ddoYi/6kYRdozvWw/sFyzL8
	 kdPvK2hpn2fHKBg7ada7nmCdub6yvTf17dDJJCBF54CYJ/B3Ud+YATUlEJdNMnV07n
	 OuJ1wCHO3Qd5F75WRzKNRN1WYGMxPUtrbw8c1v5Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C61B0F80085;
	Mon, 27 Jan 2020 16:57:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D4366F80085; Mon, 27 Jan 2020 16:57:39 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BA37BF80085
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2020 16:57:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BA37BF80085
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jan 2020 07:57:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,370,1574150400"; d="scan'208";a="223277221"
Received: from vvaddepa-mobl.amr.corp.intel.com (HELO [10.252.204.5])
 ([10.252.204.5])
 by fmsmga008.fm.intel.com with ESMTP; 27 Jan 2020 07:57:32 -0800
To: Takashi Iwai <tiwai@suse.de>
References: <20200124213625.30186-1-pierre-louis.bossart@linux.intel.com>
 <20200124213625.30186-4-pierre-louis.bossart@linux.intel.com>
 <s5hpnf7251e.wl-tiwai@suse.de>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <8749c7b5-c3c3-aff7-ada7-2a4ab422dc94@linux.intel.com>
Date: Mon, 27 Jan 2020 09:08:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <s5hpnf7251e.wl-tiwai@suse.de>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org, broonie@kernel.org,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 3/7] ASoC: SOF: core: release resources on
 errors in probe_continue
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



On 1/25/20 4:39 AM, Takashi Iwai wrote:
> On Fri, 24 Jan 2020 22:36:21 +0100,
> Pierre-Louis Bossart wrote:
>>
>> The initial intent of releasing resources in the .remove does not work
>> well with HDaudio codecs. If the probe_continue() fails in a work
>> queue, e.g. due to missing firmware or authentication issues, we don't
>> release any resources, and as a result the kernel oopses during
>> suspend operations.
>>
>> The suggested fix is to release all resources during errors in
>> probe_continue(), and use fw_state to track resource allocation
>> state, so that .remove does not attempt to release the same
>> hardware resources twice. PM operations are also modified so that
>> no action is done if DSP resources have been freed due to
>> an error at probe.
>>
>> Reported-by: Takashi Iwai <tiwai@suse.de>
>> Co-developed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
>> Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
>> Bugzilla:  http://bugzilla.suse.com/show_bug.cgi?id=1161246
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> This deserves for Cc to stable, as the bug already hits on both 5.4
> and 5.5 kernels.
> 
> Reviewed-by: Takashi Iwai <tiwai@suse.de>

Patch 2 would need to be Cc:'ed to stable as well, otherwise this patch3 
will not apply.

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
