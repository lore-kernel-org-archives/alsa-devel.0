Return-Path: <SRS0=uLsF=D5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7051C4363A
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Oct 2020 09:38:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB37A223BF
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Oct 2020 09:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mFVDOEW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB37A223BF
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 149A31798;
	Thu, 22 Oct 2020 11:37:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 149A31798
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603359508;
	bh=O/qdQrkJoGNwaYjEhoAT65h1CYvJ3R0heJ6nHx50nyA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mFVDOEW9utO/Kue9HV3mB/Jfmi+JNmCp1fsKDM2E+KbG8fkPdTGKIv1qgDIQz/1W3
	 rlHEbq4iWoaSm+naM4UdiuiQ2SUCPbKkZVRgBt2MIYrCXPGFyKMm8pXHOfiPq4kvZ7
	 UN3+A9qlMSoIVbv1SGK92yj27AbJmVjbXIfc1evw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A3BA6F8049C;
	Thu, 22 Oct 2020 11:37:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 68262F804A9; Thu, 22 Oct 2020 11:37:34 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id B35B2F8025A
 for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2020 11:37:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B35B2F8025A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1603359446835998058-webhooks-bot@alsa-project.org>
References: <1603359446835998058-webhooks-bot@alsa-project.org>
Subject: Fix muted output and low ouput/input volume on a Dell Latitude 3410
Message-Id: <20201022093734.68262F804A9@alsa1.perex.cz>
Date: Thu, 22 Oct 2020 11:37:34 +0200 (CEST)
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

alsa-project/alsa-ucm-conf pull request #56 was opened from J-Bu:

Using following environment on a Dell Latitude 3410 results in muted master channel and low output/input volume:

 - alsa-libs 1.2.4
 - alsa-ucm-conf 1.2.4
 - alsa-topology-conf 1.2.4
 - alsa-utils 1.2.4
 - kernel 5.9.1 -> with commit 3dca35e applied on top of it 
 - sof-bin v1.6

The propused changes fixes the problem for me. I don't know why but the given values are not 1:1 mapped to levels in alsamixer, please see attached iamges for alsamixer levels before and after the change, the alsamixer levels where captured after running "alsactl init":

before:
![before](https://user-images.githubusercontent.com/15876551/96853514-bf0f5f80-145a-11eb-9c7f-751834a56491.png)

after:
![after](https://user-images.githubusercontent.com/15876551/96853530-c46caa00-145a-11eb-9057-5399382d195d.png)

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/56
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/56.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
