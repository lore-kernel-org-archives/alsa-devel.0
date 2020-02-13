Return-Path: <SRS0=t/pq=4B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347CEC2BA83
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Feb 2020 11:23:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB9772073C
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Feb 2020 11:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PQLGI5dO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9772073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3FEF9166D;
	Thu, 13 Feb 2020 12:22:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3FEF9166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581593018;
	bh=cnQVkiAGzc7tT6Aj2MJNDfHfCaC/tzrrfXq8RDDSNuI=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PQLGI5dOWfoVBFeih+Hx5E5kCOYE0tqQbDduPXkRBm+yqd41oU75dEh6eWM1ZQxm4
	 kPwLsazd8BxC7k0tL27G3a2enKcL/62KT/JZQRWpO0br/KygkObe06UxLmPNZD9q0u
	 BUpaKJEyT86c+Yd+f19dxeqTWYpy7MfzIpEGREcc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 400FFF80260;
	Thu, 13 Feb 2020 12:21:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A97BDF8013E; Thu, 13 Feb 2020 12:21:06 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A61AEF80145
 for <alsa-devel@alsa-project.org>; Thu, 13 Feb 2020 12:21:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A61AEF80145
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 70159B18D;
 Thu, 13 Feb 2020 11:21:01 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Thu, 13 Feb 2020 12:20:57 +0100
Message-Id: <20200213112059.18745-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [alsa-devel] [PATCH 0/2] ALSA: usb-audio: UAC2 effect unit parsing
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi,

UAC2 Effect Unit needs different parsing from Processing Unit and co,
and this patch set implements the partial support for that.

As it's the fix on top of the latest USB-audio fix, I'd like to apply
through sound git tree.  So please review and ack if USB header change
is OK.


thanks,

Takashi

===

Takashi Iwai (2):
  usb: audio-v2: Add uac2_effect_unit_descriptor definition
  ALSA: usb-audio: Parse source ID of UAC2 effect unit

 include/linux/usb/audio-v2.h | 12 ++++++++++++
 sound/usb/mixer.c            |  6 ++++++
 2 files changed, 18 insertions(+)

-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
