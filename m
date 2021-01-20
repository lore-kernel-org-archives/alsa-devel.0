Return-Path: <SRS0=/R4B=GX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75493C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 16:13:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77C68233CE
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 16:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C68233CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0929517AA;
	Wed, 20 Jan 2021 17:13:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0929517AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611159231;
	bh=g5aWV2ZsXwSqlneM7lI/8CqFlg2yHZwYDF7X3lUPXm4=;
	h=From:To:Subject:Date:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i4ZQKvw0tABnqseVxtjA3NhItnEpY1UGDt+OGyMotROebfbHk8nhkQujT/cD8guyH
	 4T0O1QO9v3bI4LcSkiETRSsn/uagt5DzjCpnLQa5GmEWx2JiNuzuXkbdTjKVYQEPnT
	 RW8LhrDygInXoDS5/LXJDWzeYZPdrsJ4ur5oP6B8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 98CD6F80164;
	Wed, 20 Jan 2021 17:13:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E99EDF8016E; Wed, 20 Jan 2021 17:12:59 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5A584F80164
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2021 17:12:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5A584F80164
IronPort-SDR: E0p5kX2/x3M7lsGnQ4H0lq5YsrNtkJBk+NkHwa12izqYugYLVqU+kxX0CoLbF2ntK5OJCQA+4q
 at0VEmJoIp6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="243202275"
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; d="scan'208";a="243202275"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2021 08:12:47 -0800
IronPort-SDR: r4xfOhO7EnCqsrR5Pks3sKCwlJtDKyEOyPs9w1LJ+jLj8AhoQ7Ip8GeurbkQ8TGm7ncZeiqWhi
 xFJJonZ8l6iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; d="scan'208";a="366297741"
Received: from irsmsx606.ger.corp.intel.com ([163.33.146.139])
 by orsmga002.jf.intel.com with ESMTP; 20 Jan 2021 08:12:46 -0800
Received: from irsmsx601.ger.corp.intel.com (163.33.146.7) by
 IRSMSX606.ger.corp.intel.com (163.33.146.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 20 Jan 2021 16:12:45 +0000
Received: from irsmsx601.ger.corp.intel.com ([163.33.146.7]) by
 irsmsx601.ger.corp.intel.com ([163.33.146.7]) with mapi id 15.01.1713.004;
 Wed, 20 Jan 2021 16:12:45 +0000
From: "Rojewski, Cezary" <cezary.rojewski@intel.com>
To: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>
Subject: RE: [PATCH 1/3] ASoC: intel: skl: Simplify with
 dma_set_mask_and_coherent()
Thread-Topic: [PATCH 1/3] ASoC: intel: skl: Simplify with
 dma_set_mask_and_coherent()
Thread-Index: AQHW6nouJikQ0U2CKkGNq1grs7X506owuLSw
Date: Wed, 20 Jan 2021 16:12:45 +0000
Message-ID: <45d36cfa12ed4f8885f678d642d15f0a@intel.com>
References: <20210114133337.1039-1-tiwai@suse.de>
 <20210114133337.1039-2-tiwai@suse.de>
In-Reply-To: <20210114133337.1039-2-tiwai@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [163.33.253.164]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Cc: Mark Brown <broonie@kernel.org>
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

On 2021-01-14 2:33 PM, Takashi Iwai wrote:
> ASoC Intel Skylake driver still has explicit calls of dma_set_mask()
> and dma_set_coherent_mask().
>=20
> Let's simplify with dma_set_mask_and_coherent().
>=20
> Cc: Cezary Rojewski <cezary.rojewski@intel.com>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Somehow CC did not get to me.

Thanks for the patch, Takashi. Small nitpick: s/skl/Skylake/ in
commit's title. No need for resend if that's the only missing piece
found.

Acked-by: Cezary Rojewski <cezary.rojewski@intel.com>

