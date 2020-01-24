Return-Path: <SRS0=dQ5X=3N=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63586C2D0DB
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Jan 2020 20:28:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5A6F2075D
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Jan 2020 20:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MxoKc18+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A6F2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E56051693;
	Fri, 24 Jan 2020 21:28:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E56051693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579897735;
	bh=lfoMnxilf2b8PApWl9LyUkrLTpI62WDu7uMOKPaNcM8=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MxoKc18+9ZrdsvuMa3WfZ890mGEAbr2J2bJi/cW3IKrQRPRIxvTVJhAmnXy9Iz2wo
	 mUdbSMlj8rsOVEAlQw1xHbSaLRY3l0htj8TCRYUcMq1T0SXtbwDj7kc+ttJt5JvBl6
	 cg1zO2foReG01l+0PV95/GIbbS+K/C0umKGYNnWA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B0B4DF8029B;
	Fri, 24 Jan 2020 21:24:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CE118F8028C; Fri, 24 Jan 2020 21:24:26 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6A1FCF80229
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2020 21:24:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6A1FCF80229
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Jan 2020 12:24:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,358,1574150400"; d="scan'208";a="400759981"
Received: from iifeduba-mobl1.amr.corp.intel.com (HELO [10.254.110.26])
 ([10.254.110.26])
 by orsmga005.jf.intel.com with ESMTP; 24 Jan 2020 12:24:11 -0800
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
References: <20200124190413.18154-1-cezary.rojewski@intel.com>
 <20200124190413.18154-11-cezary.rojewski@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9edc0e32-b3af-3f98-613c-68ee7bcb80ed@linux.intel.com>
Date: Fri, 24 Jan 2020 14:22:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200124190413.18154-11-cezary.rojewski@intel.com>
Content-Language: en-US
Cc: broonie@kernel.org, tiwai@suse.com, lgirdwood@gmail.com
Subject: Re: [alsa-devel] [PATCH 10/12] ASoC: SOF: Provide probe debugfs
	support
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

You should probably add a higher-level explanation in the commit message 
that to make use of probes, the user needs to specific which buffers of 
the firmware topology they want to extract data from, and that debugfs 
is the configuration interface. The streaming part is handled via the 
compressed interface.

> Define debugfs subdirectory delegated for IPC communitation with DSP.

communication.

> Input format: uint,uint,(...) which are later translated into DWORDS
> sequence and further into instances of struct of interest given the IPC
> type.

we should probably add a documentation part that specifies the values 
expected, as you did some time back.

> For Extractor probes, following have been enabled:
> - PROBE_POINT_ADD (echo <..> probe_points)
> - PROBE_POINT_REMOVE (echo <..> probe_points_remove)
> - PROBE_POINT_INFO (cat probe_points)

Doesn't appear very intuitive to me, is this the same as in previous 
solutions or a new design of your own?

> +static ssize_t ppoints_read(struct file *file,
> +		char __user *to, size_t count, loff_t *ppos)

avoid ppoints acronym, use probe_points_read? same in the rest of the patch.

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
