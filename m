Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BAEC43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:05:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1565620652
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sKdi8M4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1565620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 40CB01694;
	Tue, 10 Dec 2019 15:04:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 40CB01694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575986709;
	bh=iI+ch54zr3WUOWZaq1qQ7dSfKNG432/h3d1Y7MzzHmU=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sKdi8M4P9drmM+Sihqe2g4mKSju3mB3Wr9m2bk1WfLX70+SGoKsss62t1mfhhJ5Z5
	 ob9R0GKZldda7r3z2EK558SGaKw8FA9Sv133s/FjFBk+J6H8pYPiG9sDKDQ4u5JoJk
	 rBqNbKyGsqG1ST6jAD2cpUHl+T4w+8tKJG5fglpw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8FDAEF8029B;
	Tue, 10 Dec 2019 14:59:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EB9C5F8027B; Tue, 10 Dec 2019 14:59:16 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 236F7F80258
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 14:59:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 236F7F80258
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id E494DAD85;
 Tue, 10 Dec 2019 13:58:59 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: linux-media@vger.kernel.org
Date: Tue, 10 Dec 2019 14:58:35 +0100
Message-Id: <20191210135849.15607-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Cc: alsa-devel@alsa-project.org, Andy Walls <awalls@md.metrocast.net>,
 Takashi Iwai <tiwai@suse.de>, Andrey Utkin <andrey.utkin@corp.bluecherry.net>,
 Bluecherry Maintainers <maintainers@bluecherrydvr.com>,
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Ismael Luceno <ismael@iodev.co.uk>,
 Anton Sviridenko <anton@corp.bluecherry.net>
Subject: [alsa-devel] [PATCH for-5.6 00/14] media: ALSA PCM API updates
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

this is a patch set to adapt the latest ALSA PCM API to media
drivers.  Basically these are merely cleanups, as shown in diffstat,
and there should be no functional changes.

As the corresponding ALSA PCM API change is found in 5.5-rc1, please
apply these on 5.5-rc1 or later.  Or if you prefer, I can merge them
through sound tree, too.  Let me know.


thanks,

Takashi

===

Takashi Iwai (14):
  media: solo6x10: Use managed buffer allocation
  media: tw686x: Use managed buffer allocation
  media: usbtv: Use managed buffer allocation
  media: cobalt: Clean up ALSA PCM API usages
  media: cx18: Clean up ALSA PCM API usages
  media: ivtv: Clean up ALSA PCM API usages
  media: cs231xx: Clean up ALSA PCM API usages
  media: em28xx: Clean up ALSA PCM API usages
  media: go7007: Clean up ALSA PCM API usages
  media: tm6000: Clean up ALSA PCM API usages
  media: cobalt: Drop superfluous ioctl PCM ops
  media: cx18: Drop superfluous ioctl PCM ops
  media: ivtv: Drop superfluous ioctl PCM ops
  media: Drop superfluous ioctl PCM ops

 drivers/media/pci/cobalt/cobalt-alsa-pcm.c | 69 ++----------------------
 drivers/media/pci/cx18/cx18-alsa-pcm.c     | 75 +-------------------------
 drivers/media/pci/cx23885/cx23885-alsa.c   |  1 -
 drivers/media/pci/cx25821/cx25821-alsa.c   |  1 -
 drivers/media/pci/cx88/cx88-alsa.c         |  1 -
 drivers/media/pci/ivtv/ivtv-alsa-pcm.c     | 76 +-------------------------
 drivers/media/pci/saa7134/saa7134-alsa.c   |  1 -
 drivers/media/pci/solo6x10/solo6x10-g723.c | 24 ++-------
 drivers/media/pci/tw686x/tw686x-audio.c    | 16 +-----
 drivers/media/usb/cx231xx/cx231xx-audio.c  | 79 +--------------------------
 drivers/media/usb/em28xx/em28xx-audio.c    | 87 +-----------------------------
 drivers/media/usb/go7007/snd-go7007.c      | 25 ++-------
 drivers/media/usb/tm6000/tm6000-alsa.c     | 82 +---------------------------
 drivers/media/usb/usbtv/usbtv-audio.c      | 29 +---------
 14 files changed, 19 insertions(+), 547 deletions(-)

-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
