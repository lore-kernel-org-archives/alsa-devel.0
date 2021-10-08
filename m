Return-Path: <SRS0=2Zex=O4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C1EC433FE
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Oct 2021 12:33:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5200560FD8
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Oct 2021 12:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5200560FD8
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 281F21684;
	Fri,  8 Oct 2021 14:32:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 281F21684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633696382;
	bh=AM5VMmIQ7NX3YuqhiEXJ230+mkXq4fnwtGBo4zB0Evs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QhQNuQWdM2p8qUX7JLfo05p+1B4zieJxdrYe5yPtHDX4L1SrYDXWNOpzZVQqUa+G4
	 kH2u4OyQTGxiXlmcVX8oHOeHoF+0cz2WNqQ0mRQWNXLmpASm5dK2i/j36VaeVrCENX
	 ubUH9k+z0e0FENYLTjvvZXv849Pa+ZMyG7Q/mexA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9BB28F80240;
	Fri,  8 Oct 2021 14:32:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A88F6F80246; Fri,  8 Oct 2021 14:32:09 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 49706F80124
 for <alsa-devel@alsa-project.org>; Fri,  8 Oct 2021 14:32:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 49706F80124
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1633696322948684931-webhooks-bot@alsa-project.org>
References: <1633696322948684931-webhooks-bot@alsa-project.org>
Subject: alsabat returns 0 when more than 1 signal is found and all are near DC
Message-Id: <20211008123209.A88F6F80246@alsa1.perex.cz>
Date: Fri,  8 Oct 2021 14:32:09 +0200 (CEST)
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/alsa-utils issue #114 was opened from hollerdawg:

alsabat should return -EDCONLY (-1002) when only dc signals can be found and there's more than 1 signal but instead returns 0.

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/114
Repository URL: https://github.com/alsa-project/alsa-utils
