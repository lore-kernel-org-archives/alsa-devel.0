Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADC9C00140
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Aug 2022 16:54:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9D1C5165E;
	Thu, 18 Aug 2022 18:54:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9D1C5165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660841692;
	bh=HUSiPhHpw/x6xAn9KOosa0D3TTMN3zSyyRqToSiuJls=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fID9qQ3Kg9HVPCVoYW/Qgo9dVNI8BbzU6xf7SEMuEtfebYarCqO4qdTvYlJDDJV9/
	 Q3JL0RdcWIJmCVtrdVl69yZE/oIVutC/OW07wa2jSHNzbtVtdvcyWoQJE/wCfqbkRT
	 ha4vnt6TgZMeYThwpM+Z3ScZsV9ssIfunMrZUfsM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2DBC8F8013D;
	Thu, 18 Aug 2022 18:54:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E4CC2F80430; Thu, 18 Aug 2022 18:54:00 +0200 (CEST)
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4D311F800B5
 for <alsa-devel@alsa-project.org>; Thu, 18 Aug 2022 18:53:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4D311F800B5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=cutebit.org header.i=@cutebit.org
 header.b="pQ1pBQ1R"
From: =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
 t=1660841633; bh=UNExzyKi9/UuVlXmQ0/fkVUBcJ7BQOxDg9rg7qwczx8=;
 h=From:To:Cc:Subject:Date;
 b=pQ1pBQ1RoVCQQBsbxtiv2jZAzlNx/1fuy5Xzfi3uG/ZsePDUPS2bYmKHul2wvpBmr
 Y1mRlXgQglfBYg7DlbBCFzMhQfEasklu0JmM9yVDyBg0y1qdrSOw1WYQvwea7xMcqC
 J0bT/6eTC4EsMmNaTFDt4rQdX7EUMTRfBbfbfNVY=
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: Change handling of unimplemented set_bclk_ratio
Date: Thu, 18 Aug 2022 18:53:36 +0200
Message-Id: <20220818165336.76403-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

If a 'set_bclk_ratio' call is attempted on a DAI not implementing the
method, make it an -ENOSUPP error instead of -EINVAL. Assume the DAI can
still be okay with the ratio, just does not care to register a handler.

No current in-tree users of snd_soc_dai_set_bclk_ratio seem to inspect
the return value, but -ENOSUPP disables an error print from within the
common soc_dai_ret return filter. With the new behavior a machine
driver can do a blanket 'set_bclk_ratio' on all DAIs on a bus, some of
which may care about the ratio, some of which may not.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 sound/soc/soc-dai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dai.c b/sound/soc/soc-dai.c
index d530e8c2b77b..49752af0e205 100644
--- a/sound/soc/soc-dai.c
+++ b/sound/soc/soc-dai.c
@@ -124,7 +124,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_pll);
  */
 int snd_soc_dai_set_bclk_ratio(struct snd_soc_dai *dai, unsigned int ratio)
 {
-	int ret = -EINVAL;
+	int ret = -ENOTSUPP;
 
 	if (dai->driver->ops &&
 	    dai->driver->ops->set_bclk_ratio)
-- 
2.33.0

