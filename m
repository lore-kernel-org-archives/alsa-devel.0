Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291621061B17
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2026 16:53:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 69292601F4;
	Mon, 30 Mar 2026 18:53:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 69292601F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774889600;
	bh=J9VfWIzMOBTo4bsTFXDFFiIZOh3isLSbOybdaFoH1Bo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=qS1tFfyh/OeXtuUme1Z7ZJeIW/CmrlJtBIrV+GDxzxC3UJ+xvDVEFZuqRVYGsxD9G
	 +YllowFlM0sG82cBGp+h8NrdkZofkxEw9BDCvJAdFmUhKGyrhqy6MLAOcTo6BnL2u3
	 UdXUfbpwpkzl6irLWaOg3tvcqtJJAzkS7Vq3mjpA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 25909F805EC; Mon, 30 Mar 2026 18:52:48 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B906FF805ED;
	Mon, 30 Mar 2026 18:52:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1C943F8052D; Mon, 30 Mar 2026 18:52:42 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id AED48F80087
	for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2026 18:52:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AED48F80087
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18a1aca6d05b1e00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/708@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/708@alsa-project.org>
Subject: USB-Audio: Add Audient EVO4
Date: Mon, 30 Mar 2026 18:52:42 +0200 (CEST)
Message-ID-Hash: VBXZRYAIDR6GQOFYCIRIMGMKZXJQDBEP
X-Message-ID-Hash: VBXZRYAIDR6GQOFYCIRIMGMKZXJQDBEP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VBXZRYAIDR6GQOFYCIRIMGMKZXJQDBEP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #708 was edited from motolav:

This is a 4in/4out device with 1 analog stereo out and 2 analog mono in. 
The hardware mixed loopback interface takes up the remaining 4 channels. 
Without this UCM the device is configured as 4.0 surround for in and out. 

I copied the way Windows configures the device except for the stereo mic mix as I couldn't get it to work somehow(might have been a wiremix issue).

It seems like only the main output volume can be controlled with alsa, modifying anything else requires a 
driver or software to manually change hardware config

Closes: #303

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/708
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/708.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
