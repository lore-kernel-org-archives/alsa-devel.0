Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A881C6FD18
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Mar 2023 16:21:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 713581ED;
	Tue, 28 Mar 2023 18:21:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 713581ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1680020517;
	bh=QXIxC+HFAzPCFa2dbcu1x4Rgy2UHcDAAW0LmarVegc0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=nQgdC2woKWMeF2ElcrX/tDadHGpN1/BzbLb88dAu1gAbjZZ56IUJ+IcId3YGfYpGi
	 WNuHvu8KOfrT0g/0We92Es0X4ageaS4y0yGywJzthWVZKP0OgfgW3NCC5BDhvgsh4w
	 CTjNEt+2rnCAYRdw+oEYTMZXsZaZcX2oE33t5Dg4=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D704BF80272;
	Tue, 28 Mar 2023 18:20:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 48BF4F80272; Tue, 28 Mar 2023 18:20:40 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id AB1ECF80114
	for <alsa-devel@alsa-project.org>; Tue, 28 Mar 2023 18:20:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB1ECF80114
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1680020437317707777-webhooks-bot@alsa-project.org>
References: <1680020437317707777-webhooks-bot@alsa-project.org>
Subject: Headphone jack volume on ALC287 (Thinkpad X1 extreme gen 5) is too
 low unless the speaker volume channel is past a certain threshold.
Message-Id: <20230328162040.48BF4F80272@alsa1.perex.cz>
Date: Tue, 28 Mar 2023 18:20:40 +0200 (CEST)
Message-ID-Hash: MP62LKCI6KUKCSPKU5IWWLQI4UMI35V4
X-Message-ID-Hash: MP62LKCI6KUKCSPKU5IWWLQI4UMI35V4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MP62LKCI6KUKCSPKU5IWWLQI4UMI35V4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #298 was opened from Noted-Jrelvas:

First of all, apologies for the verbose title.

I've ran into a very interesting issue with my Thinkpad X1 extreme gen 5's audio. For whatever reason, the headphone jack's sound output is very quiet unless I raise the speaker channel's volume past a certain threshold.

The headphone jack sounds very quiet...
![image](https://user-images.githubusercontent.com/55360900/228303084-57945125-59ba-4daf-befb-bb9e18b6f491.png)

...but raising the speaker channel's volume fixes the issue:
![image](https://user-images.githubusercontent.com/55360900/228303657-30efa3c3-2965-4b3b-a870-b4ae6e803aba.png)

I suggest automatically setting the speaker channel's volume to 100% when the headphones are plugged in and restoring it to its original volume once they're plugged out.

Here's the output given by `alsa-info.sh`:
http://alsa-project.org/db/?f=21904435b29e0eb23d2d0b30bbabe15734df7ad7

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/298
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
