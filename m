Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69CBBC00144
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Aug 2022 17:03:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 880C8886;
	Mon,  1 Aug 2022 19:02:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 880C8886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1659373381;
	bh=Dl2NfREvJWlRn6aBTzFqIyUJYosVCkxCPX19Y8TED+U=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Q1pu1wM/oFwTE2zcBLdcs5wHy9z9vhrwuw6E89Wz/MDRyjaSqFi5bhGPUw7aHI6lk
	 xeqJUvsspREuU1CUjdbbt5btad+ANlier+UUIj9ElzYYMOJxLI+5NSsESgambcVZZj
	 4pyYaMZFpX0QdOILTuxas42tJgA2elBrrMgI8kB4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 844B0F80246;
	Mon,  1 Aug 2022 19:01:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9865DF80553; Mon,  1 Aug 2022 19:01:25 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7F10FF804FF
 for <alsa-devel@alsa-project.org>; Mon,  1 Aug 2022 19:01:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7F10FF804FF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="R+ZYrhrD"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="47dDbPzt"
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6A4B333E75;
 Mon,  1 Aug 2022 17:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1659373271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VF4ZsajHo+yoeX3g5BEgUPEzuN8oKRjKh7z6+LHdPLw=;
 b=R+ZYrhrDN3cMjbn46Ohuloi486F3N1S2Arz8NvYVM2FrVeEl2LSMf9Ej5291yTNrzjAJeY
 OjOiggT1ceaYW2n1cxCncmcJhY444GT7jn2Bduz43L3wSQ3KZE16+kWlQap+xsQ3mySdpF
 St45mWX2px9k2xflXxgyu1tgjKP+ovc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1659373271;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VF4ZsajHo+yoeX3g5BEgUPEzuN8oKRjKh7z6+LHdPLw=;
 b=47dDbPzt0waeLiP2tcBiKbhJs70NDepEuJ6KgQ0UCrRN7ENu5ydzDBMZv3v+ls4+sb3+fl
 5HvHIULiqIXIBCCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 376F213AAE;
 Mon,  1 Aug 2022 17:01:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9FKvDNcG6GKJHAAAMHmgww
 (envelope-from <tiwai@suse.de>); Mon, 01 Aug 2022 17:01:11 +0000
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/8] ASoC: Replace sprintf() with sysfs_emit()
Date: Mon,  1 Aug 2022 19:01:00 +0200
Message-Id: <20220801170108.26340-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Lucas Tanure <tanureal@opensource.cirrus.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
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

this is a patch set for rather simple conversions from the plain
sprintf() & co to the new helpers, sysfs_emit() and sysfs_emit_at().
No functional changes are expected.


Takashi

===

Takashi Iwai (8):
  ASoC: cs43130: Replace scnprintf() with sysfs_emit()
  ASoC: tlv320aic26: Replace sprintf() with sysfs_emit()
  ASoC: Intel: sst: Replace sprintf() with sysfs_emit()
  ASoC: Intel: catpt: Replace sprintf() with sysfs_emit()
  ASoC: Intel: skylake: Replace sprintf() with sysfs_emit()
  ASoC: core: Replace sprintf() with sysfs_emit()
  ASoC: DAPM: Replace sprintf() calls with sysfs_emit_at()
  ASoC: omap: Replace sprintf() with sysfs_emit()

 sound/soc/codecs/cs43130.c         | 11 +++++------
 sound/soc/codecs/tlv320aic26.c     |  2 +-
 sound/soc/intel/atom/sst/sst.c     |  8 ++++----
 sound/soc/intel/catpt/sysfs.c      |  6 +++---
 sound/soc/intel/skylake/skl-nhlt.c |  2 +-
 sound/soc/soc-core.c               |  2 +-
 sound/soc/soc-dapm.c               |  9 ++++-----
 sound/soc/ti/omap-mcbsp-st.c       |  6 +++---
 sound/soc/ti/omap-mcbsp.c          |  8 ++++----
 9 files changed, 26 insertions(+), 28 deletions(-)

-- 
2.35.3

