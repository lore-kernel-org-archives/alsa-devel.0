Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FEBEB64DA
	for <alsa-devel@archiver.kernel.org>; Sat,  8 Jul 2023 23:14:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E951E6C1;
	Sun,  9 Jul 2023 01:13:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E951E6C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1688858068;
	bh=cDl44rXjWzHaSzUBqHvOQJQ57ZhL1WuLq09x47txyVU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=D9qe4lZKjaztuh0EiWVcYTI8eiGkID+lokk81x+kuzMQZPYfOyz/HkL04v+96C64M
	 IjETVnjoJZEThFUju/MewLfIyyHkZq95Pd9PHs5f6cbyqyeOvZsOd7vb8H+SjXMxRE
	 C6xRdc27Ng3PhwViTDwXtEtalp54xQKPpc0g/eyU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BA8DAF80249; Sun,  9 Jul 2023 01:13:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 72A0EF80249;
	Sun,  9 Jul 2023 01:13:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 83F1DF80249; Sun,  9 Jul 2023 01:12:41 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id EBE63F80093
	for <alsa-devel@alsa-project.org>; Sun,  9 Jul 2023 01:12:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EBE63F80093
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1688857951989094257-webhooks-bot@alsa-project.org>
References: <1688857951989094257-webhooks-bot@alsa-project.org>
Subject: [Feature Request] New hdajackretask ncurses TUI
Message-Id: <20230708231241.83F1DF80249@alsa1.perex.cz>
Date: Sun,  9 Jul 2023 01:12:41 +0200 (CEST)
Message-ID-Hash: COA4GSNMWACNKWYCTLFN5GELJNK4J4KB
X-Message-ID-Hash: COA4GSNMWACNKWYCTLFN5GELJNK4J4KB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/COA4GSNMWACNKWYCTLFN5GELJNK4J4KB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-tools issue #16 was opened from HalanoSiblee:

Hi
Why i need gtk GUI when I do such a simple retaskable jack input
Please make hdajackretask with ncurses like alsamixer to work in tty and terminal's
at this point it will be so useful less bloat ,and blazingly fast

Thanks.

Issue URL     : https://github.com/alsa-project/alsa-tools/issues/16
Repository URL: https://github.com/alsa-project/alsa-tools
