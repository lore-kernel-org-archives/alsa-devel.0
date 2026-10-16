Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6234CCA463
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Oct 2026 03:05:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 011A2601F5;
	Fri, 16 Oct 2026 05:05:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 011A2601F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792119945;
	bh=LHpT1s3lottjChbFO79t4kouAaCsCtgkHHP41omKKag=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=bdMIVOLsn0vhXAsV0E74ZsqMHND3JhAndXLL2Mg1FY/9XZ0PW2HpYjLWSwPOnsOyi
	 BUPz1io6mpAXZTOsQSQ+WXZ0ssoJUvvyxv4R+u7ApdOBGNps2+CJ95Fr1UxTn+F2hr
	 I7lNRIjat6Aeh3AQjEZGeVzqf2axxw7QsOG4tXl0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9BB15F80602; Fri, 16 Oct 2026 05:05:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B60FAF805B6;
	Fri, 16 Oct 2026 05:05:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A19F4F80423; Fri, 16 Oct 2026 05:05:03 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1792119902;
	b=XVFqcv3WuwSKxq3gZGG90yEPevwWsjK/P2Gwyan0EXQO4NQQ7zCJRkWnECF5N2g4VuMy
	 1YQLnC2XVbGVZAvCFPHhFE6QsLPtoGhtmFLcrdtKqcGsJObNChjmEcidz+QO8Z4eQQW1a
	 LwfaSKcJRku45BMznNnoodgyvlSpUFhdhvMPnhlhV0O2xkHxgMhF4EEAN+XG+WYF5D6Kx
	 TrDWfrPvYWko1Ra8vz++S1B7kD1U8K0pdM7LbkTN5wQpYcLtSNYXVVf/H8NTzmemwo9Tv
	 rBwD7ZE+ryFFL6zCbZjfEdqyP6BxwBFiCmRXKBXzdmAStrFhmaQiZ3ORqrAQLs0AdHQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1792119902;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=LHpT1s3lottjChbFO79t4kouAaCsCtgkHHP41omKKag=;
	b=UCmQ3tWjZuylpCbxQLzxWOl24Jvyx13SL2t8Pp1royvjXUNu3LTh3cjSY1FgYsIkSA6I
	 H5rvdOvNsjXaR6tJAt6HKA82jIS688XsXHqyNmhVPiWYyC+QmpOPLqW1vKmq2bH7q47ha
	 k0WimWuE36DP/RemMvDLZZQ36XO1pfN7IwOpnQVWNWjMSNpnzf+fDi+NpqeC/Crmlz8tb
	 bs1O7huCCAZLHDg/SvFg9kBv43IstuiI/dQhLCrfp/B96ooP9PMl2QA/d1dnIE4pDw7Fl
	 zWfv35RpF+JTbISoSTGD0OJIahigOvAotHyMYq7JcQO+tb008eI9/Ne48ISL1iyLD/g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id C0098F800BD
	for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2026 05:05:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C0098F800BD
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18dee38e108c3f00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/885@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/885@alsa-project.org>
Subject: ucm2: soundwire: add rt766 device
Date: Fri, 16 Oct 2026 05:05:03 +0200 (CEST)
Message-ID-Hash: V3QMO2YKPPNYOTIGQ245PX6YA2VQEPRM
X-Message-ID-Hash: V3QMO2YKPPNYOTIGQ245PX6YA2VQEPRM
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/V3QMO2YKPPNYOTIGQ245PX6YA2VQEPRM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #885 was opened from shumingfan:

ucm2: soundwire: add rt766 device

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/885
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/885.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
