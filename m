Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7F5C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jun 2022 10:49:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 76C2B176C;
	Tue, 14 Jun 2022 12:48:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 76C2B176C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655203761;
	bh=YO1Op3mIvLGwlmRWEXF988xJ5uMSPfotPbWr7uvCz4E=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KtsEF6wAN5aYx01XxhLV3tBWWunIcs+CQ96imWtuwoFsKWUY7CmOQ8IQqDQZeDt4a
	 pLjl9xT9mEuqlpq/vNE1CVDXS75KHSQZtRsJVrAPztUjoRIebU/L6f7mofx7O0/XyC
	 CaIT9Ha3KfCm5X2erIv/1A9f57v9SRUiNBbAucWM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0FCB6F800D8;
	Tue, 14 Jun 2022 12:48:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1F2AAF80139; Tue, 14 Jun 2022 12:48:30 +0200 (CEST)
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4D4FCF800D8
 for <alsa-devel@alsa-project.org>; Tue, 14 Jun 2022 12:48:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4D4FCF800D8
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by hi1smtp01.de.adit-jv.com (Postfix) with ESMTPS id C8C5B520712;
 Tue, 14 Jun 2022 12:48:14 +0200 (CEST)
Received: from lxhi-065 (10.72.94.27) by hi2exch02.adit-jv.com (10.72.92.28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.27; Tue, 14 Jun
 2022 12:48:14 +0200
Date: Tue, 14 Jun 2022 12:48:09 +0200
From: Eugeniu Rosca <erosca@de.adit-jv.com>
To: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH] ALSA: pcm: Test for "silence" field in struct
 "pcm_format_data"
Message-ID: <20220614104809.GA4471@lxhi-065>
References: <20220409012655.9399-1-fmdefrancesco@gmail.com>
 <20220614095851.GA4199@lxhi-065> <2245197.ElGaqSPkdT@opensuse>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2245197.ElGaqSPkdT@opensuse>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.94.27]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
Cc: alsa-devel@alsa-project.org, Eugeniu Rosca <roscaeugeniu@gmail.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 syzbot+205eb15961852c2c5974@syzkaller.appspotmail.com,
 Mark Brown <broonie@kernel.org>, naveenkumar.sunkari@in.bosch.com,
 Eugeniu Rosca <erosca@de.adit-jv.com>
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

Dear Takashi, dear Fabio,

Thank you for your prompt feedback.
Please, keep me in the loop in case a revert/fix is submitted to LKML.

BR, Eugeniu.
