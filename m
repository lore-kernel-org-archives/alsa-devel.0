Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2680CD4F26
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Jun 2026 20:09:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9E394601F8;
	Fri, 19 Jun 2026 22:09:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9E394601F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781899771;
	bh=Kc1lwsnwo46bAxBL4DJbgtHLou6iS0ZmC1l5PmF2sPE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=T1PlJHY8yAjCtA9xJKUo4bJhJG0fWtT8IdXSLt1nzBDYsyzyQz+59XjPasI2dO0Lq
	 s11mNgKsdyeCzN1FOVZt5PDwII5VT6GB9hNN4/DPtx6l21MyqaogmoZfDNmb6EfDJc
	 kvOyTr/dRnm2+OjF488Q8JMXY34R3jToP0oge//I=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3506FF805F4; Fri, 19 Jun 2026 22:08:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 90E2FF805F2;
	Fri, 19 Jun 2026 22:08:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 56064F80448; Fri, 19 Jun 2026 22:08:53 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781899732;
	b=e+M1eaW+j4jOsI28nEGTVy2oe/TsTw3DZeLEnfgZihEMKaayxeom4FKuh5tvMOK9NbdO
	 A71ab4l3HXmIaU+lWT7LFNUXaQgUC5akHABxNeiQI/z8JYjPFW6lOvX6lwCk+cIMvfyjB
	 QtlG5yEqaAmgp+mRc6VyvGLF85zchTx0fHLrNauxQ8nEyq54pBVT25dHdMie474Iv6VQq
	 XkojTi6LWHR/zhKwQmEPZ6PO4ry+trpbLuPtnlNv2TOolVEXG4fYDAUKbu5BCSp+X/zuD
	 pnPVGRxIGK1CfX48aEf/BciKAUgQRHLipWDao+RoTUNTRK1UsQ+OxQSbpYocEjHnk5g==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781899732;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=Kc1lwsnwo46bAxBL4DJbgtHLou6iS0ZmC1l5PmF2sPE=;
	b=j3XuyTjNr2dTy9k2mJO9g9gHBWOXpRLYLorJ55s8Sf1yBY2G0C7qgEc9FGn4IyC6Trrq
	 RNE+iF5z0BGIkiwoZUrHaxyKMgmg75IT/V6vxfnL+srNs4MfOuK0KrP2wXooc3un7Sz0U
	 hTbJGBMHUb9VNjXIBkEjxu83fimGsDei+CKMOu5XBJG4lZK180YRHmmDlBfZdLqvHsCJ5
	 hIyye2EKYpFIwA9jpdi67TGxgojMg4t5QRvqJonlAsbYzjCC4OK+B6qylRiDltzL9OLsP
	 icCNlUpI1oavwDJSeSwfUJ8cczdYOUnRdNfUdc7c4mr7yackHtC8+TqY2xB1xORTzmg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 42578F80124
	for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2026 22:08:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 42578F80124
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18ba945d37070000-webhooks-bot@alsa-project.org>
In-Reply-To: <18ba945d36de2f00-webhooks-bot@alsa-project.org>
References: <18ba945d36de2f00-webhooks-bot@alsa-project.org>
Subject: Hollow Internal Speaker Sound on HP ZBook 15 G6 (Realtek ALC285)
Date: Fri, 19 Jun 2026 22:08:53 +0200 (CEST)
Message-ID-Hash: LJNNS7TARU4CBLUAZA5NNXJIIZUJOC7N
X-Message-ID-Hash: LJNNS7TARU4CBLUAZA5NNXJIIZUJOC7N
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LJNNS7TARU4CBLUAZA5NNXJIIZUJOC7N/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #513 was opened from Purgenta889:

I've tested this throughout several different Linux kernels (ranging from version 6.x to 7.x), and no matter which distribution is used, the internal speakers sound considerably emptier and without bass than they should, compared to how they sound on Windows 11.

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
