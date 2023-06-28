Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACD5EB64D7
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Jun 2023 23:58:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E96EB839;
	Thu, 29 Jun 2023 01:57:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E96EB839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687996713;
	bh=/ecU/vRlyWCLdN61xy1BnAb0dARS38sGOsvDkZ3/Xfk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=U7aBioSQN7KV6v/RedOSnFf8K+0gNodxZd2F7REc0LR4rRXw/mViTgay/u5C6E1jG
	 wNFxcXM3r+d7DuysYaWs6pIRShbu7S+1NvFyqPFGJyaCVmra8/5IAQjsZbEjJhZf9P
	 koUV4n1MFIdu3MfCyhj6PD315cJPepJirtk2TEdk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DD2BDF8053B; Thu, 29 Jun 2023 01:57:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 567E1F80246;
	Thu, 29 Jun 2023 01:57:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8BDE6F80246; Thu, 29 Jun 2023 01:57:13 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 0BFD7F80093
	for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2023 01:57:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0BFD7F80093
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1687996631681684971-webhooks-bot@alsa-project.org>
References: <1687996631681684971-webhooks-bot@alsa-project.org>
Subject: configure: Add large file support via CFLAGS
Message-Id: <20230628235713.8BDE6F80246@alsa1.perex.cz>
Date: Thu, 29 Jun 2023 01:57:13 +0200 (CEST)
Message-ID-Hash: 4XDONOU3RCYASWPSFGQII2Q7OR5A7EIT
X-Message-ID-Hash: 4XDONOU3RCYASWPSFGQII2Q7OR5A7EIT
X-MailFrom: github@alsa-project.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4XDONOU3RCYASWPSFGQII2Q7OR5A7EIT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib pull request #333 was opened from kendase3:

Currently scanelf (pax-utils) detects missing LFS support in the following files/calls:
fopen,__open_2,mmap,lseek,open /usr/lib/libasound.so.2.0.0 fopen,open /usr/lib/libatopology.so.2.0.0

Note that this may cause problems on systems with a 32-bit kernel, but I've tested playing audio on a more recent 32-bit system with a 64-bit kernel.

Notably AC_SYS_LARGEFILE (currently used in alsa-utils for example) did not solve the issue for my case, whereas FILE_OFFSET_BITS did.

Let me know if you'd prefer an alternative approach!

Request URL   : https://github.com/alsa-project/alsa-lib/pull/333
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/333.patch
Repository URL: https://github.com/alsa-project/alsa-lib
