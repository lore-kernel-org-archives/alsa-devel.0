Return-Path: <SRS0=wWF8=AF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D142C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jun 2020 17:54:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFF272077D
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jun 2020 17:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FYI7tUKz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="i0fzv4O/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF272077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5871D1888;
	Wed, 24 Jun 2020 19:54:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5871D1888
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593021296;
	bh=NAp9DR/7JXVAXVwsq4PWt4yrvcZTuC0RDz0tyTPF19I=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FYI7tUKzQ6ecbQf6c2KzEDiDGnR1P+B4XtGUxqpVq9lFq3aEri9/+Pf80zATK8I46
	 W1YLcqg0W37JIvnrqT9KmUlSt89Y8OruiaNbeVTnBtgXG1+VhPNz+Lt9axKhFnPqn8
	 caSKVQg949XU+ZX+9A5/JgIiuxB+j9vkn9nJSnOY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 06D66F8015A;
	Wed, 24 Jun 2020 19:52:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6C36CF8015B; Wed, 24 Jun 2020 19:52:03 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1D6CFF800B2
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2020 19:51:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1D6CFF800B2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="i0fzv4O/"
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05OHpwY8130169;
 Wed, 24 Jun 2020 12:51:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1593021118;
 bh=NAp9DR/7JXVAXVwsq4PWt4yrvcZTuC0RDz0tyTPF19I=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=i0fzv4O/eJCWYYYZVR0/9l1A8UJbIdRAfxtDUBD/pr2XbgrlwMXRcHbuyKeep1bPt
 QCEi11KYPwB0NNTHC/CX+YTgZCOUFu4ZyepHEIUA68ai/5Gga+adm5HtJMMaxl2C7l
 H5lo/8sYvV1qD/COe/K3pfPZ7z7S+eo8YTAvKeQ4=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05OHpwut073572
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 24 Jun 2020 12:51:58 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 24
 Jun 2020 12:51:58 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 24 Jun 2020 12:51:58 -0500
Received: from [10.250.52.63] (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05OHpvwh039637;
 Wed, 24 Jun 2020 12:51:57 -0500
Subject: Re: [PATCH v5 3/7] ASoC: tas2562: Fix format issue for extra space
 before a comma
To: Mark Brown <broonie@kernel.org>
References: <20200624161459.19248-1-dmurphy@ti.com>
 <20200624161459.19248-4-dmurphy@ti.com> <20200624162917.GK5472@sirena.org.uk>
 <c4a26be8-88cc-1dfa-61e0-844b9c19eb52@ti.com>
 <370c71e3-731b-3549-adb0-597abb217cfc@ti.com>
 <20200624174813.GN5472@sirena.org.uk>
From: Dan Murphy <dmurphy@ti.com>
Message-ID: <d2227f18-7585-d5a2-8438-57ee8717318a@ti.com>
Date: Wed, 24 Jun 2020 12:51:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624174813.GN5472@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: robh@kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, tiwai@suse.com, devicetree@vger.kernel.org
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

Mark

On 6/24/20 12:48 PM, Mark Brown wrote:
> On Wed, Jun 24, 2020 at 12:36:02PM -0500, Dan Murphy wrote:
>
>> Can this patchset get a review as well so I can fix before I post v6?
>> Not sure what the current work load is for review or merge.
> Well, it's less work to review if it's been fixed...

Ok fixed and sent v6

