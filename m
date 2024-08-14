Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D01C52D7B
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Aug 2024 11:08:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 369A42353;
	Wed, 14 Aug 2024 13:08:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 369A42353
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1723633698;
	bh=RmYaTZjNo5GzKemWvrxydypsyeaqYzHVLSA8jPiLUYQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=hE7XI1CamvjsVGCwnBUPDt/HGLpfeywIFJxCozGta0PveP65PAj7JJZ7hI6AMvLuh
	 ZnmdAGAKnsEehaMylMwTygmiYvaWmAIuj/1rnH1kGBR7U8iC8Np+dL711pQXYiQzqQ
	 9s6busVbQRgRnpiWv43AZdZ6wuolxcpTGdB3//uU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6FCADF805A1; Wed, 14 Aug 2024 13:07:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 17C1DF805B3;
	Wed, 14 Aug 2024 13:07:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9E8F8F80301; Wed, 14 Aug 2024 13:07:37 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 8CC0DF80107
	for <alsa-devel@alsa-project.org>; Wed, 14 Aug 2024 13:07:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8CC0DF80107
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1723633650735610008-webhooks-bot@alsa-project.org>
References: <1723633650735610008-webhooks-bot@alsa-project.org>
Subject: Behringer UCM204HD shows only both lines (4 speakers)
Message-Id: <20240814110737.9E8F8F80301@alsa1.perex.cz>
Date: Wed, 14 Aug 2024 13:07:37 +0200 (CEST)
Message-ID-Hash: 5O6NP5HPWN6UPFQBD5GYSD4XCS6CMIY2
X-Message-ID-Hash: 5O6NP5HPWN6UPFQBD5GYSD4XCS6CMIY2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5O6NP5HPWN6UPFQBD5GYSD4XCS6CMIY2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #436 was edited from Udrys:

Hi,
I'm noob on linux so please don't beat me very hard :) I have Linux Mint 22 (Kernel 6.8.0-40-generic and Mint 21.3 had the same problem). So my UCM204HD shows only one 4 speaker channel. Not  separate like on Windows or Debian. I tried to update configuration from this page but there are no difference. Maybe I'm missing something? Could you please help me? Thank you very much. 

P.s. Apparently it's absolutely doesn't matter what I do with /usr/share/alsa files, they don't change anything.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/436
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
