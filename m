Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C40FC433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 20 May 2022 21:21:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CDB221755;
	Fri, 20 May 2022 23:20:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CDB221755
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1653081669;
	bh=IHXK8HCcE4ccAbpYpMLvPyShkHEN10ikSmLgvnuWPpY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KBs2N4QJgk89SA6Hd4S7zxAb1hl6A3e4+wC2UvY4Fup6GHYEjlYP3dfy5VDCsrE5d
	 uxzH5MGUt9jEeb4ucmvUX3XpcUAQf+ZIhhMm6ELCAI9K1G5qfWOHkUOKU9avm4vgcv
	 PS7mP/tjTXGpIuIlyKrTx5QnH3/lDtfbHHo8Sbk0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A9550F80526;
	Fri, 20 May 2022 23:17:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 535AEF80542; Fri, 20 May 2022 23:17:52 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 42414F8051F
 for <alsa-devel@alsa-project.org>; Fri, 20 May 2022 23:17:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 42414F8051F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="SVP93w2b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653081464; x=1684617464;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IHXK8HCcE4ccAbpYpMLvPyShkHEN10ikSmLgvnuWPpY=;
 b=SVP93w2bRCiB0WeC58tEpUiGIND5pNDMxFheQwo5DkEBlag6PE7zS2HI
 aw7soSfGQ+O1ek2SwBn6XHwHohGlkYJ/Gn52OzC2tSeZzPQxjH/M9YQjG
 flWu63GJbmuFKnW8yLQsHtClEZPorZA/NOMLPtYJy6iULMuWFfNs8jZtp
 Ia8YN4axtHjVYw6MYEn2ZMIblaogzwAp4GqsgPjMhoOWCCBlzXfYkKrAT
 /7R6ryXgs75hqx32EmLnuPff55yxclGENsuEoA6uz6CwuPpQRYDlrQ/H9
 CYap5sGDoR4nrgUn9Skni79zJiqQeRc/832IqeY7GthLYewte/W/3Bmjf g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="270324245"
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; d="scan'208";a="270324245"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2022 14:17:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; d="scan'208";a="674796033"
Received: from achsu-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.212.181.190])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2022 14:17:37 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 10/16] ASoC: Intel: sof_pcm512x: remove unnecessary init
Date: Fri, 20 May 2022 16:17:13 -0500
Message-Id: <20220520211719.607543-11-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220520211719.607543-1-pierre-louis.bossart@linux.intel.com>
References: <20220520211719.607543-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 broonie@kernel.org, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

cppcheck complains about an invalid NULL dereference but indeed there
is no need to initialize a loop variable.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/intel/boards/sof_pcm512x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_pcm512x.c b/sound/soc/intel/boards/sof_pcm512x.c
index 6815204e58d58..d4c67d5340a92 100644
--- a/sound/soc/intel/boards/sof_pcm512x.c
+++ b/sound/soc/intel/boards/sof_pcm512x.c
@@ -419,7 +419,7 @@ static int sof_audio_probe(struct platform_device *pdev)
 static int sof_pcm512x_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
-	struct snd_soc_component *component = NULL;
+	struct snd_soc_component *component;
 
 	for_each_card_components(card, component) {
 		if (!strcmp(component->name, pcm512x_component[0].name)) {
-- 
2.30.2

