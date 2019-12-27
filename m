Return-Path: <SRS0=/8xD=2R=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAD1C2D0DA
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Dec 2019 18:17:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7874D20CC7
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Dec 2019 18:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="H3FhZcuh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="XfnDZouW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7874D20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7CEE21753;
	Fri, 27 Dec 2019 19:16:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7CEE21753
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1577470619;
	bh=sGXFisSyu+gC1oDtxGhpit3dIGqQ9eLDs1Eu6Vupc3c=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=H3FhZcuh+MKRIZoGtwurRIBEJnwUaLXxrbSVMmEZnYQ0k0LWxPkerchQDmUBRyoY3
	 mUEP3hUu+ToIu8eiG393inPERKfG8XdisDtQugTWT0tVKtBVQADcshgtoRtLYpbQWa
	 yOSIgc8QOMSUoBezCrYlTzXjWXIyINW3DE1+8zmQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7720EF8013D;
	Fri, 27 Dec 2019 19:15:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3F295F80147; Fri, 27 Dec 2019 19:15:57 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C4D1AF800CD
 for <alsa-devel@alsa-project.org>; Fri, 27 Dec 2019 19:15:54 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id A925EA0055;
 Fri, 27 Dec 2019 19:15:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz A925EA0055
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1577470553; bh=ySOmZ+8azTykAyCVE/0pg1TD58i3W9JZpYQDC5k97Wc=;
 h=From:Subject:To:Cc:Date:From;
 b=XfnDZouWh6MSAJExPaUlwULIW0CU3afYAK8j0LNZJOTUtdei6Pc4VB1MVqHBf50rd
 ASFeJVuBUahD996wQ25QFpL5J2TvVGVg/Z0f3TisUaNR4KIuL3AcCsXobKqZq5tPsz
 ec3/Ga4MUDgmxA1OcsipWlDDnUEWLJnpFg6MtVQA=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Fri, 27 Dec 2019 19:15:48 +0100 (CET)
From: Jaroslav Kysela <perex@perex.cz>
To: ALSA development <alsa-devel@alsa-project.org>
Message-ID: <2cae9b3c-8634-7aff-3d76-7a16b1807abf@perex.cz>
Date: Fri, 27 Dec 2019 19:15:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Language: en-US
Cc: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>,
 Mengdong Lin <mengdong.lin@linux.intel.com>,
 Pan Xiuli <xiuli.pan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] topology file broadwell.conf
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

Hi all,

	I am working on some (major) cleanups for the topology library and I hit the 
issue with the topology file broadwell.conf in upstream. It cannot be compiled 
with the latest alsatplg / libatopology, because the SectionPCMConfig was 
removed in commit 368e4f2a897b5500573a2ee525f5504c135cfca2 in alsa-lib.
	Which driver is using this topology in the current linux kernel?

					Thanks,
						Jaroslav	

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
