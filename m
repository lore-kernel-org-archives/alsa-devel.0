Return-Path: <SRS0=4dkw=PN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9F5C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 12:13:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E04C60FDA
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 12:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4E04C60FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C72A116CD;
	Mon, 25 Oct 2021 14:12:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C72A116CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635163993;
	bh=/7AhjSeqSanvWP2tDzbI1wBAh38yZx6pj7kvM8uB4Ws=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Rofhs9TC74dJlIon/58RgGdnCui6gwfdMJcuxQjSaJ5fD3T8qr6bvNoHGs5yHplpw
	 rKLGpcuR7Y6DVSD5L5MjACtSkkOXzFoxwnuPjuU1a8ANh/mIhJsWFZcrIMuKBKxDQx
	 HDQWvqPMJKPVobwt2Q5lHPP9kM+yN1I0gHm7ILxI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2EAFCF8027B;
	Mon, 25 Oct 2021 14:12:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 838DFF80153; Mon, 25 Oct 2021 14:12:21 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BDCCFF80153
 for <alsa-devel@alsa-project.org>; Mon, 25 Oct 2021 14:12:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BDCCFF80153
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Bocb6vQc"
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5F4060FE8;
 Mon, 25 Oct 2021 12:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635163935;
 bh=/7AhjSeqSanvWP2tDzbI1wBAh38yZx6pj7kvM8uB4Ws=;
 h=From:To:Cc:Subject:Date:From;
 b=Bocb6vQcv1rJ/p1ekv21CSPRT/wmro22cUdAvF04+WClbe/1F+/NapNgrk/xWej1K
 3Q1QJYr2ajuuX7LycpTaYR/7CZcOWCivc3RlmDq9R8yxdI5TawAEwouwRpz6P6/9Uk
 GhxReO0lHJb4pwW7PWmyvn9J4N71g82+doz0BTlEx9r52VoI+y0NtHn5tAaiF9gevS
 f2vWFeKb6jNhsUYdi6Jc4qc1dCMHcs7LEcnjjetZ33AH/G3RFkOVs8fhUVqnkfKUQk
 o0EkECpYnxKcaGeFgE0DTiqV6hnEPeQIQrFiYnMqsdcwYYWIDZJvOEpFiOi3I3DRyz
 RJ79gOQDTdnDg==
Received: from johan by xi.lan with local (Exim 4.94.2)
 (envelope-from <johan@kernel.org>)
 id 1meypa-0001iF-8u; Mon, 25 Oct 2021 14:11:58 +0200
From: Johan Hovold <johan@kernel.org>
To: Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 0/2] sound: fix USB message timeouts
Date: Mon, 25 Oct 2021 14:11:40 +0200
Message-Id: <20211025121142.6531-1-johan@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
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

A number of drivers throughout the tree were incorrectly specifying USB
message timeout values in jiffies instead of milliseconds.

This series fixes the two sound drivers that got it wrong.

Johan


Johan Hovold (2):
  sound: 6fire: fix control and bulk message timeouts
  sound: line6: fix control and interrupt message timeouts

 sound/usb/6fire/comm.c     |  2 +-
 sound/usb/6fire/firmware.c |  6 +++---
 sound/usb/line6/driver.c   | 14 +++++++-------
 sound/usb/line6/driver.h   |  2 +-
 sound/usb/line6/podhd.c    |  6 +++---
 sound/usb/line6/toneport.c |  2 +-
 6 files changed, 16 insertions(+), 16 deletions(-)

-- 
2.32.0

