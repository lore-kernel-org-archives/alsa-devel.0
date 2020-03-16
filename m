Return-Path: <SRS0=b36W=5B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662C4C18E5B
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Mar 2020 09:06:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CC7020658
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Mar 2020 09:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XU7B5hOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC7020658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E553C18B7;
	Mon, 16 Mar 2020 10:06:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E553C18B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584349617;
	bh=QMUpo3JBQkgNd+U8L9kiuLyFxsod4iVHnQAD/oP3Iq8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XU7B5hOFj8bm9niOiNA4OOY7/K/dnZ9CB/i4QeStzsxk7tVeozHd48WrxiYdSMwzM
	 Fzbbz8Xlv3s1QFE3lTHrNbo2r43k9MUprWkUnFIN/OzgQnJZOk5tGjcajAGN0zknYV
	 AmWZSyIj1Kk3K7xEsrha43jWjeFqvjeEl/wdCMvk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C20DF8015B;
	Mon, 16 Mar 2020 10:05:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6D7B7F80162; Mon, 16 Mar 2020 10:05:11 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BF6AFF80058
 for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2020 10:05:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BF6AFF80058
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0C35DAC44;
 Mon, 16 Mar 2020 09:05:08 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/2] ALSA: seq: Fix running status after receiving sysex
Date: Mon, 16 Mar 2020 10:05:04 +0100
Message-Id: <20200316090506.23966-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Cc: Andreas Steinmetz <ast@domdv.de>
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

Hi,

here are two small fixes for correcting the behavior of sequencer core
wrt the event decoding after receiving a sysex message.


Takashi

===

Takashi Iwai (2):
  ALSA: seq: virmidi: Fix running status after receiving sysex
  ALSA: seq: oss: Fix running status after receiving sysex

 sound/core/seq/oss/seq_oss_midi.c | 1 +
 sound/core/seq/seq_virmidi.c      | 1 +
 2 files changed, 2 insertions(+)

-- 
2.16.4

