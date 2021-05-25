Return-Path: <SRS0=iQjD=KU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F318C47086
	for <alsa-devel@archiver.kernel.org>; Tue, 25 May 2021 22:29:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3891161409
	for <alsa-devel@archiver.kernel.org>; Tue, 25 May 2021 22:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3891161409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F2031743;
	Wed, 26 May 2021 00:28:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F2031743
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621981787;
	bh=ZVrJeCfpFlTXm9/XaAoW4aG4wmIxQurS+SfAwt4IFhA=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YpzIUH/o8eV+Gqd7HIzg3TdA8WmZiNH549Zl1xCH5eqT0DMDA5v/CgrBMjkF/D2ju
	 I5ljB/bMNn5F3L1Ni+9PQrmeMtHNdyjj8vHv3F9TScO91C9Y3cu5WmVDTqNHWpbCtg
	 gcfiY6J3mHru2bxGVC1y0CipwW5u0EpdJU6jr+ac=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D2028F80032;
	Wed, 26 May 2021 00:28:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DA0B1F800CB; Wed, 26 May 2021 00:28:55 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 47285F80032
 for <alsa-devel@alsa-project.org>; Wed, 26 May 2021 00:28:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 47285F80032
IronPort-SDR: GnYfbynvQbhQPhyVnSPN1ZoqvzKuMN6ah/HFoBlblLILDaeQIb/zf0n77gmT9r/f3vdJg+SszM
 DOlIXSVQ+6iw==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="202075607"
X-IronPort-AV: E=Sophos;i="5.82,329,1613462400"; d="scan'208";a="202075607"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2021 15:28:43 -0700
IronPort-SDR: csg2KZq7KCjqoPJ3fRAPQ7Wy7MFIC0lRg6205lfAvjNUKak0XnQcDbz8QXIJJOvT2tmHmC7CIp
 wzeMw3jJPoYg==
X-IronPort-AV: E=Sophos;i="5.82,329,1613462400"; d="scan'208";a="546946330"
Received: from lnguyen-mobl1.amr.corp.intel.com (HELO [10.254.180.38])
 ([10.254.180.38])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2021 15:28:42 -0700
Subject: Re: [PATCH] ASoC: cs35l3x: Use neutral language in amp drivers
To: David Rhodes <drhodes@opensource.cirrus.com>,
 alsa-devel@alsa-project.org, broonie@kernel.org,
 patches@opensource.cirrus.com
References: <20210525194439.2232908-1-drhodes@opensource.cirrus.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c038169f-ea90-1003-c838-a6db098233cd@linux.intel.com>
Date: Tue, 25 May 2021 14:58:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210525194439.2232908-1-drhodes@opensource.cirrus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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



On 5/25/21 2:44 PM, David Rhodes wrote:
> Revise variable names and comments in
> cs35l35 and cs35l36 amp drivers.
> 
> Signed-off-by: David Rhodes <drhodes@opensource.cirrus.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
