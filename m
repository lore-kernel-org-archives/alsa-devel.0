Return-Path: <SRS0=WcGQ=EZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94CEC5519F
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Nov 2020 00:55:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84003246A7
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Nov 2020 00:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="c2iPD/oo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84003246A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=flatmax.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BA46516C6;
	Thu, 19 Nov 2020 01:54:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BA46516C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605747301;
	bh=hYUFkBN0JkissVoiRF141eTj7U9JPThcVdS1mH9nP4Y=;
	h=From:Subject:To:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=c2iPD/oomvpYQOLGz2Lq82VkvO6FxgtXQKWSN11w/k0jCIUB+bqW/9X36A03m+Hjk
	 nbk63LMflRos3GvfYcCVDK0BCCcFhcfhXaDbH/+iIg7eICnD+eELxdDkujEJOLIrrt
	 +GvL1oGDjZ+K41sxTNdy85HIwtQf+lEu504oJRM0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3D65AF80168;
	Thu, 19 Nov 2020 01:54:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8BA83F8016C; Thu, 19 Nov 2020 01:54:02 +0100 (CET)
Received: from mx.flatmax.org (mx.flatmax.org [13.55.16.222])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5D7E2F800EE
 for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2020 01:53:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5D7E2F800EE
Received: from [203.23.175.70] (helo=[192.168.10.75])
 by mx.flatmax.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <flatmax@flatmax.org>) id 1kfYCu-00029K-Jp
 for alsa-devel@alsa-project.org; Thu, 19 Nov 2020 11:53:52 +1100
From: Matt Flax <flatmax@flatmax.org>
Subject: ESS Sabre DAC ES901x Codec drivers
To: Linux-ALSA <alsa-devel@alsa-project.org>
Message-ID: <715ab610-54fe-3255-e64d-db62cae9ff18@flatmax.org>
Date: Thu, 19 Nov 2020 11:53:52 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-AU
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

Are there any ESS DAC codec drivers out there ?

For example ES9012, ES9018 DACs.

http://www.esstech.com/files/2816/0453/7571/ES9018S_Datasheet_v2.2.pdf

Matt


