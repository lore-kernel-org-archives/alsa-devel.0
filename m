Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A9FD5A6D9
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Nov 2024 03:45:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CEFB4E97;
	Tue, 26 Nov 2024 04:45:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CEFB4E97
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1732592735;
	bh=gLYl4E8DJC1qiE3dCkPji98BtQ2vCHJA2fOVhEnrNuI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=osj5JEbUQaOdU+q+Pa5o6Lokhj+J0IiIVLlt7eRXe/bKF2hwpbO0cQzXD+nqefN7P
	 7/Ee4aWA7bawPGoTugyg6aT+GZxAtVd001kguqnHsoNGSTPXNTEOFgf/MT9LnaL3rU
	 iWnQWdkoDPPFXYJVGAS8b372YzSvHCNeAhoQGKNU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4F31DF805C6; Tue, 26 Nov 2024 04:45:14 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BABE4F805C3;
	Tue, 26 Nov 2024 04:45:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 53630F80496; Tue, 26 Nov 2024 04:44:58 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 9A295F80073
	for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2024 04:44:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A295F80073
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1732592695996497154-webhooks-bot@alsa-project.org>
References: <1732592695996497154-webhooks-bot@alsa-project.org>
Subject: Device selection regression in 1.2.13 for LNL
Message-Id: <20241126034458.53630F80496@alsa1.perex.cz>
Date: Tue, 26 Nov 2024 04:44:58 +0100 (CET)
Message-ID-Hash: IYSRSBYILZ3FYI6QLP4EDT2SCL2VKZOK
X-Message-ID-Hash: IYSRSBYILZ3FYI6QLP4EDT2SCL2VKZOK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IYSRSBYILZ3FYI6QLP4EDT2SCL2VKZOK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #474 was opened from CarelessCaution:

On Intel Lunar Lake, there seems to be a regression in alsa-ucm-conf that affects device selection in KDE Plasma and probably in other software. In 1.2.12, there are the options Play HiFi Quality Music and Pro Audio for both input and output. However, when upgrading to 1.2.13, there is only the option for Pro Audio.

This problem is immediately remedied by downgrading just the alsa-ucm-conf package on Arch Linux.

Before (1.2.12):

![before](https://github.com/user-attachments/assets/c7fa81e0-97f1-45ae-a14e-8549f85cdd27)

After (1.2.13):

![after](https://github.com/user-attachments/assets/5867886b-6686-4265-ad68-50c7f53e1a47)

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/474
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
