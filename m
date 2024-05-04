Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27138C4345F
	for <alsa-devel@archiver.kernel.org>; Sat,  4 May 2024 20:49:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 81DA2DF9;
	Sat,  4 May 2024 22:49:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 81DA2DF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1714855792;
	bh=jfdEXZeeTOF7wa9xtIgso90NOu7WQ06SVQvV6IXYhKA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=okFEdwLpP00fZTrKzxbCPu3Z/3E5PPUnN4jFmq2mrYc3iA6t+0UsTdMJTUajOjWor
	 XezEPace48fqwi/YgkpuexZPhcrky0c+xKbUGu3I3YXYKSYl3Cblb0837GQEDjDZG3
	 E4GT+UitfllHR+k2ElW6HcZiq788op8nxfjYxku0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A719DF8057F; Sat,  4 May 2024 22:49:09 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0C83FF8057E;
	Sat,  4 May 2024 22:49:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 327FCF80266; Sat,  4 May 2024 22:47:26 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id ED009F8023A
	for <alsa-devel@alsa-project.org>; Sat,  4 May 2024 22:47:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ED009F8023A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1714855641158283472-webhooks-bot@alsa-project.org>
References: <1714855641158283472-webhooks-bot@alsa-project.org>
Subject: Fix seg. fault when accessing `ConstantObject` extra
Message-Id: <20240504204726.327FCF80266@alsa1.perex.cz>
Date: Sat,  4 May 2024 22:47:26 +0200 (CEST)
Message-ID-Hash: QQDEQV5ML76PDXHXDSPUF7MJKLPYIIEF
X-Message-ID-Hash: QQDEQV5ML76PDXHXDSPUF7MJKLPYIIEF
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QQDEQV5ML76PDXHXDSPUF7MJKLPYIIEF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-python pull request #10 was opened from FrancescoCeruti:

This fixes (#9) a segmentation fault that started happening with python 3.12, changes in the PyLongObject implementation have broken some pointer arithmetic, which, from what I understand, is not necessary.

Probably someone with a better understanding of C should check this :)

I've tested with 3.12, 3.11 and 3.7.

Request URL   : https://github.com/alsa-project/alsa-python/pull/10
Patch URL     : https://github.com/alsa-project/alsa-python/pull/10.patch
Repository URL: https://github.com/alsa-project/alsa-python
