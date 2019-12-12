Return-Path: <SRS0=r47B=2C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F40C43603
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Dec 2019 19:12:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F9222253D
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Dec 2019 19:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Hr5g8vbq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F9222253D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F15816F0;
	Thu, 12 Dec 2019 20:11:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F15816F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576177918;
	bh=jUSuO0hdS+yDxRwMnXTucz6ckd5uhpz/r/Dr7XerqTY=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Hr5g8vbqXSpG5GPY0MXvgaCWZ1/jT6L0e866e9A0j3rbLCmHTpy7vcUNDUYPi9mmZ
	 nHWFFOzmpugvI6BOYQgDjyG6E/cW9Px6ITfa+nc6sgybKOuBtgKOf6+IDWRr9O0veS
	 Isl+5ls5Y4LA6xn8tkae7kk6yIe7QL3dOAhG0QJc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C9259F8020C;
	Thu, 12 Dec 2019 20:11:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D88C4F80232; Thu, 12 Dec 2019 20:11:06 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2E543F800EC
 for <alsa-devel@alsa-project.org>; Thu, 12 Dec 2019 20:11:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2E543F800EC
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 17522AFDF;
 Thu, 12 Dec 2019 19:11:03 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Thu, 12 Dec 2019 20:10:59 +0100
Message-Id: <20191212191101.19517-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: [alsa-devel] [PATCH 0/2] ALSA: hda: Use RIRB waitq commonly
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

this is a follow-up patch set for adapting the RIRB waitq to HD-audio
core, and a cleanup with it.


Takashi

===

Takashi Iwai (2):
  ALSA: hda: Use waitqueue for RIRB in HDA-core helper, too
  ALSA: hda: Unify get_response handling

 include/sound/hda_codec.h      |  1 -
 include/sound/hdaudio.h        |  1 +
 sound/hda/hdac_controller.c    | 25 +++++++++++++++++++--
 sound/pci/hda/hda_controller.c | 49 ++++--------------------------------------
 sound/pci/hda/hda_intel.c      |  2 +-
 sound/pci/hda/hda_tegra.c      |  2 +-
 sound/pci/hda/patch_ca0110.c   |  2 +-
 sound/pci/hda/patch_sigmatel.c |  2 +-
 8 files changed, 32 insertions(+), 52 deletions(-)

-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
