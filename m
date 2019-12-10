Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F342C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:21:12 +0000 (UTC)
Received: from alsa0.perex.cz (unknown [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 171D12073B
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 171D12073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=tempfail smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 77A6A16A0;
	Tue, 10 Dec 2019 15:20:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 77A6A16A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575987670;
	bh=c5V+i9N6DMoilQuGryexdWhNQkaB8s4aQBvL2KRIM90=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cI0i/Jk3EqXGpO6op16hBmCK0ICX/CXslWVeFEgz8GaN1C75+sIQGURTZcpkBbnGi
	 5vBNoSucgE9bgwX4X5tV7dx5JGar4aQYvai+2a7mmrf3bf0mn4RIuy6eGiTZlSlh5K
	 x/3Q2vgKphuEPsZq9uROtWIiaPFQvshe1x0DS7jk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F206FF80256;
	Tue, 10 Dec 2019 15:18:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2575FF80248; Tue, 10 Dec 2019 15:18:37 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EE308F801D8
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 15:18:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EE308F801D8
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id A9D9EB1DE;
 Tue, 10 Dec 2019 14:18:29 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Felipe Balbi <balbi@kernel.org>
Date: Tue, 10 Dec 2019 15:18:20 +0100
Message-Id: <20191210141822.18705-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 alsa-devel@alsa-project.org, linux-usb@vger.kernel.org
Subject: [alsa-devel] [PATCH for-5.6 0/2] usb:gadget: ALSA PCM API updates
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

this is a patch set to adapt the latest ALSA PCM API to staging
drivers.  Basically these are merely cleanups, as shown in diffstat,
and there should be no functional changes.

As the corresponding ALSA PCM API change is found in 5.5-rc1, please
apply these on 5.5-rc1 or later.  Or if you prefer, I can merge them
through sound tree, too.  Let me know.


thanks,

Takashi

===

Takashi Iwai (2):
  usb: gadget: u_audio: Use managed buffer allocation
  usb: gadget: u_audio: Drop superfluous ioctl PCM ops

 drivers/usb/gadget/function/u_audio.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
