Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F07FFC001DC
	for <alsa-devel@archiver.kernel.org>; Sun, 30 Jul 2023 15:29:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EE7A682A;
	Sun, 30 Jul 2023 17:28:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EE7A682A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690730948;
	bh=45sP2mVq+CucICTTL3F70IivY+uoA5kH7aa8vWGOFro=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=sqU+X0Eb4Q2GxDUym78cP6mkgeHmF5wKMnpAC1qcemYwnHr7Nr0Ty0h0WSdKSFJZX
	 DZIPHWddcLtWB4PQm7/kC4/NaI30+by6Ip45UsHOva1bX68ExbW7iwI0dF4K275n+6
	 ZSraDImBa1qVci5KokKzP5coZ5/BVovihhDJ1X3Y=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 51151F80163; Sun, 30 Jul 2023 17:27:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9E885F8016D;
	Sun, 30 Jul 2023 17:27:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1951DF8016D; Sun, 30 Jul 2023 17:27:36 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 89918F80153
	for <alsa-devel@alsa-project.org>; Sun, 30 Jul 2023 17:27:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 89918F80153
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1690730851113998890-webhooks-bot@alsa-project.org>
References: <1690730851113998890-webhooks-bot@alsa-project.org>
Subject: Problem with Rog Delta S Wireless
Message-Id: <20230730152736.1951DF8016D@alsa1.perex.cz>
Date: Sun, 30 Jul 2023 17:27:36 +0200 (CEST)
Message-ID-Hash: B6XRQI7MSVCFLMQIZOU3IFIO5W5JBCNN
X-Message-ID-Hash: B6XRQI7MSVCFLMQIZOU3IFIO5W5JBCNN
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/B6XRQI7MSVCFLMQIZOU3IFIO5W5JBCNN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils issue #227 was opened from bagou4502:

Greetings,

I am posting this issue here since I haven't found a solution in forums yet.

I am facing an problem with my Rog Delta S Wireless headset when using Linux with Gnome. The volume control doesn't function correctly. Setting the volume to < 95% keeps the sound at 0 in alsamixer. When I set it to 95%, alsamixer shows 50%, and 100% corresponds to 100% in alsamixer.

This issue occurs specifically with this headset in both 2.4GHz and Bluetooth modes. I have already tried using another Rog Delta S Wireless headset, but the same problem persists. Additionally, I tested it on multiple computers running Fedora, Ubuntu 22.04 and 23.04, Debian 11 and 12, as well as ZorinOs 16.2 and 16.3, and encountered the same problem on all of them.

Here is a video demonstrating the issue: https://www.youtube.com/watch?v=-OuKtLt5U1k

Unfortunately, I am uncertain whether this problem originates from the Gnome volume system or AlsaMixer.

I am hopeful that someone can assist me with this matter. Thank you for your help.

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/227
Repository URL: https://github.com/alsa-project/alsa-utils
