Return-Path: <SRS0=bNm3=2P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8ECBC2D0C3
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Dec 2019 00:13:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F21020679
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Dec 2019 00:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="obexmxNe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="LYeQvcIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F21020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9962C16B0;
	Wed, 25 Dec 2019 01:12:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9962C16B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1577232789;
	bh=3j/12Mzd78zvtLRfcC/irpWq3NH9vepPnDY+gwZ9I18=;
	h=From:To:In-Reply-To:Date:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=obexmxNex5u6K1uCjKnA51YLp5uBSNUTdWWkglDCA/EpLxLrEXkMoe5Iwo2c6comH
	 itgnqx6+9fvGwVvTNCwgRuSncZXMK+6nplLrktazBh+EfgQ/QyN/GElTJAnhxIZThJ
	 HsYzu4nE2f3Y13neXpg2HBiMCPr5o8FeLjl+plis=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 620F4F8028D;
	Wed, 25 Dec 2019 01:09:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 537DBF80272; Wed, 25 Dec 2019 01:09:11 +0100 (CET)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 04590F8014C
 for <alsa-devel@alsa-project.org>; Wed, 25 Dec 2019 01:09:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 04590F8014C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="LYeQvcIk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=wai+g/RnEe1d915v48AlK1TWO39W3/fiSnRZzVq9MGc=; b=LYeQvcIkogG5
 g2c0l8jFVAH97jbq21iDBo3sbC25jYVoL3KPJqgoGNqNZEHDRYbLY+zaMQ3MXK4R7M1D9BVFXPSVp
 p+955vdTgtA7DOGyUcgbnVX5LaJTRHRXkytz5OqdfkNH+71qZz6THj6cOuTYyKDRhlwOlBY6uVCK1
 lTyTU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=fitzroy.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.org.uk>)
 id 1ijuEW-0007Ky-9S; Wed, 25 Dec 2019 00:09:00 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id B48C6D01957; Wed, 25 Dec 2019 00:08:59 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Dragos Tarcatu <dragos_tarcatu@mentor.com>
In-Reply-To: <20191204210447.11701-4-pierre-louis.bossart@linux.intel.com>
Message-Id: <applied-20191204210447.11701-4-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Date: Wed, 25 Dec 2019 00:08:59 +0000 (GMT)
Cc: alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] Applied "ASoC: topology: Prevent use-after-free in
	snd_soc_get_pcm_runtime()" to the asoc tree
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

The patch

   ASoC: topology: Prevent use-after-free in snd_soc_get_pcm_runtime()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From dd836ddf4e4e1c7f1eb2ae44783ccd70872ef24e Mon Sep 17 00:00:00 2001
From: Dragos Tarcatu <dragos_tarcatu@mentor.com>
Date: Wed, 4 Dec 2019 15:04:47 -0600
Subject: [PATCH] ASoC: topology: Prevent use-after-free in
 snd_soc_get_pcm_runtime()

remove_link() is currently calling snd_soc_remove_dai_link() after
it has already freed the memory for the link name. But this is later
read from snd_soc_get_pcm_runtime() causing a KASAN use-after-free
warning. Reorder the cleanups to fix this issue.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Dragos Tarcatu <dragos_tarcatu@mentor.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/20191204210447.11701-4-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index b28613149b0c..92e4f4d08bfa 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -548,12 +548,12 @@ static void remove_link(struct snd_soc_component *comp,
 	if (dobj->ops && dobj->ops->link_unload)
 		dobj->ops->link_unload(comp, dobj);
 
+	list_del(&dobj->list);
+	snd_soc_remove_dai_link(comp->card, link);
+
 	kfree(link->name);
 	kfree(link->stream_name);
 	kfree(link->cpus->dai_name);
-
-	list_del(&dobj->list);
-	snd_soc_remove_dai_link(comp->card, link);
 	kfree(link);
 }
 
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
