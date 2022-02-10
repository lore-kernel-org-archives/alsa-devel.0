Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBF5C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Feb 2022 12:34:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9EDC318C0;
	Thu, 10 Feb 2022 13:33:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9EDC318C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1644496486;
	bh=ooDiEjX3Cknd6+enlufW4F72hQhRmnaf19IgSvze6to=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uSjixo9Gb7INF2c6p2d1Qi2EGdgm7yNDqKscKEFmz0wfLy4WC84xACLeV8l5UG58I
	 4Xj7vdMGZJTASaihARLEBQMHwSP68ysjua3sVF1RnQrACEyracpcQrzVO/tWzLEx9S
	 ksjWJ5vClUi+PJddpHYriqeVVTEZTSqjrbhmcIYg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1C364F8013D;
	Thu, 10 Feb 2022 13:33:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C9483F80302; Thu, 10 Feb 2022 13:33:52 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DE4A7F800A7
 for <alsa-devel@alsa-project.org>; Thu, 10 Feb 2022 13:33:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DE4A7F800A7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="wDjtSyVA"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="Gm4+1/LH"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id E8A931F391
 for <alsa-devel@alsa-project.org>; Thu, 10 Feb 2022 12:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644496426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4c2zX+5YQMX/JW2ZprE07CtHd8un3pRscrmg3dc4CNU=;
 b=wDjtSyVAziKjkQQy5Y+5YeV/NTXjVPR3y6+uqucnjTcwx5XjadJHMjhPkRX+HwUVEEzUjH
 D0hzT369hGTa/kkDH2VtJehLgsxuiFZ/xfV1YS62HdAlitjcjXm0kHzx9VATZUDg61fFKf
 1a4UgAE4mtJmUOFBPdGmdudvOvOF7g0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644496426;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4c2zX+5YQMX/JW2ZprE07CtHd8un3pRscrmg3dc4CNU=;
 b=Gm4+1/LHG8zZvZ5Ptn038AQOJNK8OqC6x3/FbRAzg6icFtbqhSW6ufBUkFLC4se200/Qc3
 ZKiZZavCOd4qb6Bg==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id D746EA3B85;
 Thu, 10 Feb 2022 12:33:46 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/2] ALSA: memalloc: Fixes for sync check and SG helper
Date: Thu, 10 Feb 2022 13:33:42 +0100
Message-Id: <20220210123344.8756-1-tiwai@suse.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The recent changes and additions in ALSA core memalloc helpers had
incorrect usages of dma_need_sync() and the order of SG page
invalidation.  This patch corrects those.


Takashi

===

Takashi Iwai (2):
  ALSA: memalloc: Fix dma_need_sync() checks
  ALSA: memalloc: invalidate SG pages before sync

 sound/core/memalloc.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

-- 
2.31.1

