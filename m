Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3DED3B7CE
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Nov 2024 10:10:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C48121945;
	Tue, 26 Nov 2024 11:09:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C48121945
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1732615798;
	bh=WgDKmD5flbPT9HS1Ap8apO5uPzHW9CUGCRvplzJAn+A=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=NPRR4GCzygEPRWEw556allcqCSa4aOfc+1e7o7OKU6o398pqYzD72RKqe405bccds
	 S51Q3a6YjewWH323YZOZrxxVC0z3T/+LCNGhiidPdkGhCQw4p14y2DoypA+qcKMPQ3
	 jvJZjP3vwH6sLj3PSlqKS9QWBTqcXMeWq39JlhiU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 79B7BF8019B; Tue, 26 Nov 2024 11:09:26 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B5FE4F805AE;
	Tue, 26 Nov 2024 11:09:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0A387F8019B; Tue, 26 Nov 2024 11:09:16 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 2540EF8019B
	for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2024 11:09:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2540EF8019B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1732615753402373075-webhooks-bot@alsa-project.org>
References: <1732615753402373075-webhooks-bot@alsa-project.org>
Subject: how do I create configure a ucm2 conf file for my card just like an
 acp file
Message-Id: <20241126100916.0A387F8019B@alsa1.perex.cz>
Date: Tue, 26 Nov 2024 11:09:16 +0100 (CET)
Message-ID-Hash: KZD6AQMLRI2O3FCA74F355XZ3JOFSGPT
X-Message-ID-Hash: KZD6AQMLRI2O3FCA74F355XZ3JOFSGPT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KZD6AQMLRI2O3FCA74F355XZ3JOFSGPT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #475 was opened from beh-10257:

1_ how do I know if my card is using acp or ucm profile
2_ can ucm config file be availble in user directories
3_ how do i test a ucm profile
4_ if my card is using ucm is there a way to cooverride that file
5_ for more context https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/4421
6_ as a tldr I want to take advanatage of indep_hp=yes (IDK why this is not enabled by default its a great feature compared to other platforms after all) either way I want to make hw:0,0 as speaker and hw:0,2 as headphones
can a ucm profile replace the indep_hp hint and udev rule and just porceed to seperate them directly
also indep_hp seperates speaker and headphones output is there a way to seperate internal mic and headphone speaker
also is there a way to put priority for headphones when the jack port is actually put or even disable it entirely and just default back to speaker automatically
thats all thanks

thats all and thanks
further editing will be filled once I have more questions and thanks

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/475
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
