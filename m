Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0223BC2BB3F
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Nov 2023 13:53:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8018284B;
	Mon, 20 Nov 2023 14:52:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8018284B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1700488397;
	bh=axElS+akCQC5pbpDeFteHojdigDQQBGbk1NfJU+kufg=;
	h=Subject:From:To:CC:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=aey52Sgbi4n+LsV177Uyu6VMWyZTSKNrpzxEdUdy51YNmrwd9ezsLyHCngip167FB
	 pJqHH/tRBe/ADeQHw0zcUNJtT1hlrPaBnz/UdcnUTPYMlkMav6mdTk7tIZaUUCRjEI
	 oYTpn/RsbiBvE+CXdDAphh0LVnQNUPfMJajolbEM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 588DEF8047D; Mon, 20 Nov 2023 14:52:01 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7546BF80254;
	Mon, 20 Nov 2023 14:51:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 63748F80254; Mon, 20 Nov 2023 14:51:47 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C8D9EF80246
	for <alsa-devel@alsa-project.org>; Mon, 20 Nov 2023 14:51:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C8D9EF80246
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=apkbQCAg
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3AK7gLuL013978;
	Mon, 20 Nov 2023 07:51:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=
	PODMain02222019; bh=hHUDeNKVn2Q63s7c31O4N6WqAJjj0/zhNnzg5Jp1P0s=; b=
	apkbQCAgTMla8LcuoLIjOwfRyBCEfMNMc6VlCq3NIOEZ4jvcb4GJeqG5LharH5HT
	wBPvR58C9zkoFy8ZqTtyjTuF7Zt3VYKMt9tjALqi6+0C7I72Ug5E2VKoaCM5xmn3
	QmdXILhB1QruEQztfLVVHLgtslg3rswnIqN/CEUYRDF5pz5yotfmnnR5uQZ81rur
	RbBSRQWHux/87MvkYB6cSpTstwjOfr191JeR3JEMaAow6OtLVQXAXJP8F0zeUe7W
	tCXJN4Zj+qSJrDhmDFekHoWCuFyJkDWHO8iAaYff7hSZEx+0WElZLLzojuMR8TZl
	hqUIEloM0Dq7vLsKDp+MPQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ueuj29u7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Nov 2023 07:51:35 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 20 Nov
 2023 13:51:33 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.39 via Frontend
 Transport; Mon, 20 Nov 2023 13:51:33 +0000
Received: from ediswws03.ad.cirrus.com (ediswws03.ad.cirrus.com
 [198.90.251.123])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2366515B9;
	Mon, 20 Nov 2023 13:51:33 +0000 (UTC)
Message-ID: 
 <e9698a93d2eeae8c00cfcebdfa69f686849ded0b.camel@opensource.cirrus.com>
Subject: Re: [PATCH v2 6/7] ASoC: cs43130: Allow driver to work without IRQ
 thread
From: Maciej Strozek <mstrozek@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
CC: James Schulman <james.schulman@cirrus.com>,
        David Rhodes
	<david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Date: Mon, 20 Nov 2023 13:51:33 +0000
In-Reply-To: <7d8bf03f-e9a5-405b-8753-a360f46a04df@sirena.org.uk>
References: <20231120104153.76248-1-mstrozek@opensource.cirrus.com>
	 <7d8bf03f-e9a5-405b-8753-a360f46a04df@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1+deb11u2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GeAWVfhstnj9i4jJ6lXjygZ-GSPFwGKy
X-Proofpoint-GUID: GeAWVfhstnj9i4jJ6lXjygZ-GSPFwGKy
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: VASYI44KSITCZ2ZYBHRV7ETO5BDO7WRR
X-Message-ID-Hash: VASYI44KSITCZ2ZYBHRV7ETO5BDO7WRR
X-MailFrom: prvs=668862412b=mstrozek@opensource.cirrus.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VASYI44KSITCZ2ZYBHRV7ETO5BDO7WRR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

W dniu pon, 20.11.2023 o godzinie 12∶31 +0000, użytkownik Mark Brown
napisał:
> On Mon, Nov 20, 2023 at 10:41:53AM +0000, Maciej Strozek wrote:
> > This is to support systems without physical IRQ connection. The
> > device
> > only requires the IRQ for a couple of internal delays, this polling
> > mechanism is a fallback when no IRQ is specified.
> 
> Your changelog here doesn't describe the change - is then intention
> here
> to remove the IRQ thread (and presumably open code?) or to make
> interrupts entirely optional?
> 
> I'm assuming there aren't six more patches in this series?  The whole
> point in numbering patches is to order things, if you're only sending
> one patch you don't need numbering at all.

Apologies, I thought the word "fallback" would describe the intention
of making an optional way for the driver to work in absence of IRQ
rather than removing the IRQ thread. Will send an amended (and
unnumbered) v3.

