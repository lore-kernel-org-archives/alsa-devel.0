Return-Path: <SRS0=sUwr=AH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E78FC433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Jun 2020 05:41:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECAEA20768
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Jun 2020 05:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TALXN2jA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="FgUvW/KY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECAEA20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 75A2B166D;
	Fri, 26 Jun 2020 07:40:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 75A2B166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593150094;
	bh=sNKJM8LN1a+tjCIAB7jXDEFOrbLCL/l/5nJasySIZtE=;
	h=Date:To:From:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=TALXN2jADuMv3RE2FE27Mqje1lOMa3N9YUdMmvN/K44WpNqjRr6WNKkPhOlZIm+2f
	 QwsjZaFwxet0MzdGRoOdSZY2HCIM3TDZvne3Ey68oTK9sO/x5kUJkndP1JM5g80AEU
	 l1XODIIB5w0+3Q0Ex7Za7J/6ptnEEqglXsD+dStI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B634FF8015A;
	Fri, 26 Jun 2020 07:40:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 838EBF8015B; Fri, 26 Jun 2020 07:40:42 +0200 (CEST)
Received: from mail2.protonmail.ch (mail2.protonmail.ch [185.70.40.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 04813F80137
 for <alsa-devel@alsa-project.org>; Fri, 26 Jun 2020 07:40:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 04813F80137
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.b="FgUvW/KY"
Date: Fri, 26 Jun 2020 05:40:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail; t=1593150033;
 bh=yV92h7TmmWBqNMzpLb0m3OstkCVrrTD7Tkg9xZDfHfE=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=FgUvW/KYEDXyLbumBaWqpImG18VVIpcuL1U40/f11jCta6cjBmcjI59clh646OYiD
 z8bTtIkJcjdiqBohj54fqWiAEU3QpyFM+49YOeh1+YCYR63BzdmCOqjBb1d5Eiclj7
 k4Ap/rFHg2+YjTlUGxcWy/Qijxkhd3xg8PwNAAwc=
To: alsa-devel@alsa-project.org
From: Colton Lewis <colton.w.lewis@protonmail.com>
Subject: [PATCH] snd/soc: correct trivial kernel-doc inconsistency
Message-ID: <20200626053953.68797-1-colton.w.lewis@protonmail.com>
In-Reply-To: <db6d3b05-33c1-91b9-d0b4-c5063ebafcae@linux.intel.com>
References: <4574918.31r3eYUQgx@laptop.coltonlewis.name>
 <db6d3b05-33c1-91b9-d0b4-c5063ebafcae@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Cc: tiwai@suse.de, Colton Lewis <colton.w.lewis@protonmail.com>,
 broonie@kernel.org, lgirwood@gmail.com, pierre-louis.bossart@linux.intel.com
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
Reply-To: Colton Lewis <colton.w.lewis@protonmail.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Silence documentation build warning by correcting kernel-doc comment
for snd_soc_runtime_action.

./sound/soc/soc-pcm.c:220: warning: Function parameter or member 'action' n=
ot described in 'snd_soc_runtime_action'

Signed-off-by: Colton Lewis <colton.w.lewis@protonmail.com>
---
 sound/soc/soc-pcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 2c114b4542ce..9ab376844ac1 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -208,6 +208,7 @@ static inline void dpcm_remove_debugfs_state(struct snd=
_soc_dpcm *dpcm)
  * PCM runtime components
  * @rtd: ASoC PCM runtime that is activated
  * @stream: Direction of the PCM stream
+ * @action: Activate stream if 1. Deactivate if -1.
  *
  * Increments/Decrements the active count for all the DAIs and components
  * attached to a PCM runtime.
--=20
2.26.2


