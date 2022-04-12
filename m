Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFDAC433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Apr 2022 09:32:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 01BCA1727;
	Tue, 12 Apr 2022 11:31:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 01BCA1727
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649755958;
	bh=RPk4PhW5pxYzhU/oA9ozj+RvUhL5HWHshphr95DMo00=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=L520ENrm1vGy8saX+unTb5jDai5QZn4Fw5u5SWtHvMqCOKqnysa79tc6seN2AEBA3
	 Pvp9Qw+G0bXjJAQ04En3Tfb5jMOA5VD3jDrBp7kRr+XqlVnOoyVrM2RAapFIofVPkm
	 Kl3bIwx6D5U45j8IwCuyxm5L/6QwMSkHc7CjycHE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8B5C2F8011C;
	Tue, 12 Apr 2022 11:31:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 40626F8011C; Tue, 12 Apr 2022 11:31:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1FAF1F8011C
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2022 11:31:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1FAF1F8011C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="JhnpkOPb"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="zb4yvhZK"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id AC60F1F858;
 Tue, 12 Apr 2022 09:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649755902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=AyOQ7nSchVvbLX6w/Nhe+v9mhA1J28Uelg0sIR/lwjw=;
 b=JhnpkOPbT2EjKA2hgZHTs8tE2DEz50mQo+v8woThrHGvTto04xlmbVZ92CZMDMbk9Is9c3
 pJxS3Jdb4vjQc6iZFf5vjDR4tGnFqJ/bJlVxAJNGV4IwEr8oHAgqLir9NRHGR4uZewE9wK
 k8KRTowKYAQLFMSFrRNIxmpP6RLiwFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649755902;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=AyOQ7nSchVvbLX6w/Nhe+v9mhA1J28Uelg0sIR/lwjw=;
 b=zb4yvhZKmIMSYPDWZd8utvM4kFl6LbsKVCkLAnwSKqwctWk2DZoJFPTtZgLc3P+3XGFgDE
 J+ab0jQugy+AVCBQ==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 9B64EA3B8A;
 Tue, 12 Apr 2022 09:31:42 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/2] ALSA: echoaudio: Fix the probe error handling
Date: Tue, 12 Apr 2022 11:31:39 +0200
Message-Id: <20220412093141.8008-1-tiwai@suse.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Zheyu Ma <zheyuma97@gmail.com>
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

this is a patch set to address the regression of the error handling
in the echoaudio driver probe phase.  Similar error patterns are seen
in other drivers, and the newly introduced helper will be used later
for those, too.


Takashi

===

Takashi Iwai (2):
  ALSA: core: Add snd_card_free_on_error() helper
  ALSA: echoaudio: Fix the missing snd_card_free() call at probe error

 include/sound/core.h            |  1 +
 sound/core/init.c               | 28 ++++++++++++++++++++++++++++
 sound/pci/echoaudio/echoaudio.c |  9 +++++++--
 3 files changed, 36 insertions(+), 2 deletions(-)

-- 
2.31.1

