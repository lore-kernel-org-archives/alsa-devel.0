Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C569CD98F2
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Jun 2026 20:09:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D54E16021C;
	Fri, 19 Jun 2026 22:09:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D54E16021C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781899786;
	bh=W2r8lSqV+jsGssY2Cbfx4c5YOxDQ7Tk89SVW8xETmZc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=vSBCDMvDeVKXAUrGPisdZAyzD6NAL3eHNHS9xpd7UdQXyXh1B6X2lDMM294xfhEIz
	 6zNgxQsLVojl3kZeE8sHaOX7Yx+mcVrIJprNw+QSnU9+XY5ELPeYVXi4dO+cwF6EVE
	 si6Xo+i7FSKvrgziHfDamrBpfVkDAnv0zfMxLi14=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3AA7AF80622; Fri, 19 Jun 2026 22:09:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EE3E2F8061D;
	Fri, 19 Jun 2026 22:09:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8376EF8060C; Fri, 19 Jun 2026 22:09:07 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781899747;
	b=hzgGWrTJRVggkysFaQ60VwhajjT1GZ8onV3nMJNlKm97Ymx+c9UFM2WfEkIfCg106MuB
	 LCm2JnQhpPb90NYP4gYbCzqxKpkBaiPajowG0A4uPrddgRwIL76K/xRDVz9HuYBMOhO7m
	 bjVotPx7PC6zcb/xD1HWG+FWaBJHk3fvQWDGcOo3d12t2R8gDZczuOf6vPUfSiTLLRlkD
	 ZfMrddCS+lLe/H44zof1GQNsgUJPfrMPO7ttRPsIwpucG+blTgyjUFyUx8/dVhWgtebvO
	 GxzvjdLmwI8foLyAxm/b3LWrCxSMhZRsD5HlnlhMO88imAXTaWY5i7f2J69la5bc1zg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781899747;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=W2r8lSqV+jsGssY2Cbfx4c5YOxDQ7Tk89SVW8xETmZc=;
	b=eqc9GUxhWq+S8wgNmPxu+f7h6fK6qM0ggcHyj1ce6lAI0DLOOzHE6uiXNBTCtO0/ayI2
	 oZfd0MmL7r8t+kuByxXdKUlz+bdJIPFk/oiYpiBZHwYDFtL0bi48sNev16e4ZyzkX9xZL
	 yi4lkENrabMim5V7XnCn9qQLX5kJtD7VXyQj+yCy6Y5zo0/6Z1G5awOvslOOeLwpcTGtW
	 XPrlgywiAHwt+hAgZRoqnoj9+YZ8XnzoyUNGlZKZsAA2w3laYb6XlLXyN/9LpFos94+X0
	 JLNfwu0lqQqyG5NyDddHGqV+C2Ouwg4yL5tpMWrKWLXWFxSCq55rS/TH0TvX0to60uA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 15776F8060A
	for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2026 22:09:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 15776F8060A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18ba9460c5288500-webhooks-bot@alsa-project.org>
In-Reply-To: <18ba9460c5231700-webhooks-bot@alsa-project.org>
References: <18ba9460c5231700-webhooks-bot@alsa-project.org>
Subject: Hollow Internal Speaker Sound on HP ZBook 15 G6 (Realtek ALC285)
Date: Fri, 19 Jun 2026 22:09:07 +0200 (CEST)
Message-ID-Hash: 72WWUIPBCIKROVNIA4TYHA6NIT3NPCOV
X-Message-ID-Hash: 72WWUIPBCIKROVNIA4TYHA6NIT3NPCOV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/72WWUIPBCIKROVNIA4TYHA6NIT3NPCOV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #513 was edited from Purgenta889:

I've tested this throughout several different Linux kernels (ranging from version 6.x to the latest 7.x), and no matter which distribution is used, the internal speakers sound considerably emptier and without bass than they should, compared to how they sound on Windows 11.

Hardware Details:

- Laptop Model: HP ZBook 15 G6
- CPU: Intel Xeon E-2286M
- GPU: NVIDIA Quadro T2000
- Audio Codec: Realtek ALC285
- Speaker Brand: Bang & Olufsen (B&O)
- Speaker Type: Dual Stereo

Additional Information:
All audio with bluetooth and wired headphones work perfectly fine, with no noticeable change in bass or quality. According to [this source](https://www.storagereview.com/review/hp-zbook-15-g6-workstation-review), the laptop comes with something called "HP Clear Sound Amp", which could be a contributor to the lack of bass, if it does not work properly on Linux.

ALSA Report: 

[alsa-report.txt](https://github.com/user-attachments/files/29149672/alsa-report.txt)

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/513
Repository URL: https://github.com/alsa-project/alsa-lib
