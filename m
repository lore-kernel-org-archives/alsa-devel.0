Return-Path: <SRS0=zQEr=Y6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF369C5DF63
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Nov 2019 20:15:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D65D4214D8
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Nov 2019 20:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="brH5/Wvj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D65D4214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3A5721672;
	Wed,  6 Nov 2019 20:38:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3A5721672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573069184;
	bh=V61GpYcR2wfiVNGeF169irZYQCmpAgL035T1T3XYAH4=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=brH5/WvjXuJRQdFI3Umoa0aRyhPrjh4muBEzE9HsKotVtd7Nj7OqwroFSEY66IEe5
	 3csnIFjrMJTsx6Li8H5EVhaWc4Ui3GWGL4ITr67+4WTCZbpl8g9TQLdMa4ICkCUsIt
	 jSJcJgQRyB1DoDQq8EQ+RxTqsCCxi+IsSRs6BVQc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 33CC7F80321;
	Wed,  6 Nov 2019 20:30:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5950EF800F3; Wed,  6 Nov 2019 20:30:35 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 36060F800F3
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2019 20:30:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 36060F800F3
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Nov 2019 11:30:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; d="scan'208";a="205931904"
Received: from rbidasar-mobl.amr.corp.intel.com (HELO [10.251.0.251])
 ([10.251.0.251])
 by orsmga006.jf.intel.com with ESMTP; 06 Nov 2019 11:30:27 -0800
To: alsa-devel@alsa-project.org
References: <20191022234808.17432-1-pierre-louis.bossart@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <caa9b0cb-ea85-e7de-6ada-35ad906dec28@linux.intel.com>
Date: Wed, 6 Nov 2019 13:30:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191022234808.17432-1-pierre-louis.bossart@linux.intel.com>
Content-Language: en-US
Cc: tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com,
 slawomir.blauciak@intel.com, Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 0/3] soundwire: use UniqueID only when
 relevant
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



On 10/22/19 6:48 PM, Pierre-Louis Bossart wrote:
> The hardware UniqueID, typically enabled with pin-strapping, is
> required during enumeration to avoid conflicts between devices of the
> same type.
> 
> When there are no devices of the same type, using the UniqueID is
> overkill and results in a lot of probe errors due to mismatches
> between ACPI tables and hardware capabilities. For example it's not
> uncommon for BIOS vendors to copy/paste the same settings between
> platforms but the hardware pin-strapping is different. This is
> perfectly legit and permitted by MIPI specs.
> 
> With this patchset, the UniqueID is only used when multiple devices of
> the same type are detected. The loop to detect multiple identical
> devices is not super efficient but with typically fewer than 4 devices
> per link there's no real incentive to be smarter.
> 
> This change is only implemented for ACPI platforms, for DeviceTree
> there is no change.

Vinod, this series has been submitted for review on October 22 and I 
answered to your questions. There's been no feedback since October 24, 
so is there any sustained objection here?

ACPI platforms are completely unmanageable without this patchset.

> 
> Pierre-Louis Bossart (3):
>    soundwire: remove bitfield for unique_id, use u8
>    soundwire: slave: add helper to extract slave ID
>    soundwire: ignore uniqueID when irrelevant
> 
>   drivers/soundwire/bus.c       |  7 +--
>   drivers/soundwire/slave.c     | 98 +++++++++++++++++++++++++++--------
>   include/linux/soundwire/sdw.h |  4 +-
>   3 files changed, 84 insertions(+), 25 deletions(-)
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
