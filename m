Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC031C001B0
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Aug 2023 10:36:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 984C9823;
	Tue,  8 Aug 2023 12:35:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 984C9823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691490980;
	bh=CX+rtagkaNR1wpSy2ir9QUMp/tNXpjbn1KCz7N2LRDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=YG5tOrdHCEVGEKuLvo8u0b/1C61gbOX+Myy4AXWTpPpps3M0R2mUEfrBWbdSvJtf8
	 eSuWcbesdBON8iyMA/SlIk9CX+TZxMryhkzucq6phGr/Gk+Hg2uTfY+PZKxTEyzyG8
	 ObCo/IMlW2x2n0XYXDd0MJwY8aoSM+pD2fwKzneM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A7052F8053B; Tue,  8 Aug 2023 12:35:29 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 27DAFF80534;
	Tue,  8 Aug 2023 12:35:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 68309F8025A; Fri,  4 Aug 2023 15:34:02 +0200 (CEST)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by alsa1.perex.cz (Postfix) with SMTP id A2D92F8016D
	for <alsa-devel@alsa-project.org>; Fri,  4 Aug 2023 15:33:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A2D92F8016D
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 69164602506E6;
	Fri,  4 Aug 2023 21:33:45 +0800 (CST)
X-MD-Sfrom: dengxiang@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: dengxiang <dengxiang@nfschina.com>
To: tiwai@suse.com,
	perex@perex.cz,
	alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org,
	dengxiang@nfschina.com
Subject: Re: [PATCH] ALSA: usb-audio: Add support for Mythware XA001AU capture
 and playback interfaces.
Date: Fri,  4 Aug 2023 21:31:36 +0800
Message-Id: <20230804133136.559701-1-dengxiang@nfschina.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87leer9j73.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: dengxiang@nfschina.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: LGTM2E5663BOPWHCOZPIP7OOZ5GYYUEZ
X-Message-ID-Hash: LGTM2E5663BOPWHCOZPIP7OOZ5GYYUEZ
X-Mailman-Approved-At: Tue, 08 Aug 2023 10:35:24 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LGTM2E5663BOPWHCOZPIP7OOZ5GYYUEZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

>> This patch adds a USB quirk for Mythware XA001AU USB interface.
>> 
>> Signed-off-by: dengxiang 

>Thanks, applied now.

Ok, Thank you very much.
