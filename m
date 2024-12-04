Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BCDE7716B
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Dec 2024 08:41:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0418614E7;
	Wed,  4 Dec 2024 09:41:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0418614E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1733301675;
	bh=tPgmDUGZd824s62CcUp6iNxbHzxpmH7UrQEgUS28TEg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=kef4fYE7xs5iANO5uPYYxKzVmQDper995NmrEBSDHpJnxnKQLAywv2qt2iU5aT5d9
	 p+QlYuA64DmkcNiNFJ1ouhr1UMqlNpi9XwKy0YGEhNXXELXpKjQq3D5yTxVz+vXuCe
	 sTQbIo3RPZC2mz8BnN8FX7eqHSCM95L5B8hskb/U=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5A6CBF805BD; Wed,  4 Dec 2024 09:40:42 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D8A93F805B4;
	Wed,  4 Dec 2024 09:40:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DA1DDF80272; Wed,  4 Dec 2024 09:40:36 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 38E3BF800E9
	for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2024 09:40:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 38E3BF800E9
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1733301634610425949-webhooks-bot@alsa-project.org>
References: <1733301634610425949-webhooks-bot@alsa-project.org>
Subject: Should SOF ucm2/blobs/sof user_configs and product_configs be without
 .conf suffix?
Message-Id: <20241204084036.DA1DDF80272@alsa1.perex.cz>
Date: Wed,  4 Dec 2024 09:40:36 +0100 (CET)
Message-ID-Hash: 4N6DZ77VMDCDGNTDUJKSX2IJDEWNORCT
X-Message-ID-Hash: 4N6DZ77VMDCDGNTDUJKSX2IJDEWNORCT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4N6DZ77VMDCDGNTDUJKSX2IJDEWNORCT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #482 was opened from singalsu:

It seems updates have dropped .conf from looked up SOF blobs customization files. Is the change intentional? Then the example in ucm2/blobs/sof/product_configs/AAEON/UPX-TGL01.conf should be renamed to be without .conf to work and be applied correctly.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/482
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
