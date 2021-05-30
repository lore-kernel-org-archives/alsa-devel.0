Return-Path: <SRS0=jKKe=K3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD317C4708F
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jun 2021 07:03:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A57D661370
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jun 2021 07:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57D661370
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nosuchhost.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CB484169F;
	Tue,  1 Jun 2021 09:02:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CB484169F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622530994;
	bh=B21agY1d+P+oqE1VfUzc2n6gu/4ArASpb8CVrOPJcak=;
	h=Subject:From:To:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iefdxj2d8tHPSHoSS5ZVxENgVg/9AlVLmGMw1qTNiOy9vR+GBuGoQTN9Ys+03hTqm
	 O8BHxZYyE1e4lTFBngFJAgPlZZclirggAHU2D7qheY10F/UYUUMhuHI8rbLTSd2XhO
	 Q1NxBc+uHnAYfQMTDxC9xnDfFwbv+24vfLTew3/s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 53C27F802E7;
	Tue,  1 Jun 2021 09:01:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C6E78F80254; Sun, 30 May 2021 21:24:39 +0200 (CEST)
Received: from mail.nosuchhost.net (mail.nosuchhost.net [78.46.40.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2F37CF80161
 for <alsa-devel@alsa-project.org>; Sun, 30 May 2021 21:24:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2F37CF80161
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=nosuchhost.net header.i=@nosuchhost.net
 header.b="IBIqcQGQ"; 
 dkim=pass (1024-bit key) header.d=nosuchhost.net header.i=@nosuchhost.net
 header.b="pAmCuKIh"
Received: from localhost (localhost [127.0.0.1])
 by mail.nosuchhost.net (Postfix) with ESMTP id D629B4011A;
 Sun, 30 May 2021 21:24:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.nosuchhost.net D629B4011A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nosuchhost.net;
 s=default; t=1622402668;
 bh=LdLM+vZyc843rt/vBE+syBmJRiEuxuhu9+qJovgTVlY=;
 h=Subject:From:To:Cc:Date:From;
 b=IBIqcQGQvaKCkoLFxGG0X8dGAiuK3JO5rgNYySosxWfa+95MZ/TQunnc5b9pLxAeb
 pw6QemMMmvtzkRHivVlvtIEORf1rlMIvlqojkiok60GFp/NDklGdLIuGAnPLV4bSXR
 jWIj8lyD8lqbpZ71YNMCc5cnsuKykqvd4unpG7AQ=
X-Virus-Scanned: amavisd-new at nosuchhost.net
Received: from mail.nosuchhost.net ([78.46.40.125])
 by localhost (ns3.nosuchhost.net [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B6Zk6O3Mm823; Sun, 30 May 2021 21:24:27 +0200 (CEST)
Received: from [192.168.88.42] (91-119-16-248.dsl.dynamic.surfer.at
 [91.119.16.248])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.nosuchhost.net (Postfix) with ESMTPSA id A5219400E9;
 Sun, 30 May 2021 21:24:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.nosuchhost.net A5219400E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nosuchhost.net;
 s=default; t=1622402667;
 bh=LdLM+vZyc843rt/vBE+syBmJRiEuxuhu9+qJovgTVlY=;
 h=Subject:From:To:Cc:Date:From;
 b=pAmCuKIh7rUb1Bxn2CP8k9iOtaaUFWa/uh4n3MFNvn4yZyzbYstLbcVpkUz/v3fXW
 Kti+FqDM5wlj4jaRo7liUHXLJWRG1SvaLWUIZZXF+ABI9jAm10u/dEhhJqiELYMamB
 gIU1ek9OIX8EV6RKqi1akyf4k3HQasdereoSE0CI=
Message-ID: <05170bbaeea7eb6d5a4439e4884665a29bb2a144.camel@nosuchhost.net>
Subject: trivial patch
From: josef radinger <cheese@nosuchhost.net>
To: perex@perex.cz, tiwai@suse.com
Date: Sun, 30 May 2021 21:24:24 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 01 Jun 2021 09:01:32 +0200
Cc: alsa-devel@alsa-project.org, trivial@kernel.org
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

just fix some trivial typo in comments, sorry for the second try. 
i should have read more carefully the rule about NOT sending attachments.

diff --git a/sound/soc/qcom/qdsp6/q6adm.c
b/sound/soc/qcom/qdsp6/q6adm.c
index 3c68df82c95c..1855b805eba2 100644
--- a/sound/soc/qcom/qdsp6/q6adm.c
+++ b/sound/soc/qcom/qdsp6/q6adm.c
@@ -373,7 +373,7 @@ static int q6adm_device_open(struct q6adm *adm,
struct q6copp *copp,
  * @rate: rate at which copp is required.
  * @channel_mode: channel mode
  * @topology: adm topology id
- * @perf_mode: performance mode.
+ * @perf_mode: performace mode.
  * @bit_width: audio sample bit width
  * @app_type: Application type.
  * @acdb_id: ACDB id
@@ -452,7 +452,7 @@ EXPORT_SYMBOL_GPL(q6adm_get_copp_id);
  * @dev: Pointer to adm child device.
  * @path: playback or capture path.
  * @payload_map: map between session id and afe ports.
- * @perf_mode: Performance mode.
+ * @perf_mode: Performace mode.
  *
  * Return: Will be an negative on error or a zero on success.
  */



yours
josef


