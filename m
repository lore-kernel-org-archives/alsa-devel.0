Return-Path: <SRS0=sa53=PM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08D6C433F5
	for <alsa-devel@archiver.kernel.org>; Sun, 24 Oct 2021 09:01:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AD8760F6F
	for <alsa-devel@archiver.kernel.org>; Sun, 24 Oct 2021 09:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2AD8760F6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mailoo.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8994F1674;
	Sun, 24 Oct 2021 11:00:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8994F1674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635066103;
	bh=E2tcnfIOs4VQxTRgaEgAcHrVxoiBA+I6A+FeEJVzwcQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=j5QgqHtGMik/4T//UArjvTvIQrFcJK/jW5aUmkNvoSyxgd+Pt/mvBBose5forDjfq
	 wJS6oqzbHFTftL3Zr8rLHMH0J9qL1YEg87+jaUzi3W2+BXkedV52jhT+YT6bc48/HE
	 nONA5p0rhiaz88xg4QhvBHWe8jIsi0u7yTkDvkH8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D6F7DF804F3;
	Sun, 24 Oct 2021 11:00:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A2405F804F3; Sun, 24 Oct 2021 11:00:10 +0200 (CEST)
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C6551F804F3
 for <alsa-devel@alsa-project.org>; Sun, 24 Oct 2021 11:00:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C6551F804F3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mailoo.org header.i=@mailoo.org
 header.b="AVtE24uP"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
 t=1635065950; bh=E2tcnfIOs4VQxTRgaEgAcHrVxoiBA+I6A+FeEJVzwcQ=;
 h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
 MIME-Version:Content-Transfer-Encoding;
 b=AVtE24uPtzlIwFUp3B7qFlpQvPIIzTlrknFWENxEYHNN/JCcaKLIoM/nxxB1FlwLo
 saKevNPC4z32AIyIzNgAAakXDUhjSCq8lW9MDVRVH7fbaTvfKHsEPl1vYsCiUFhtjj
 LEhBe+9WcVnQFpXGFVkXcU8ZbdojDD1FJ5Yc6ODQ=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
 via proxy.mailoo.org [213.182.55.207]
 Sun, 24 Oct 2021 10:59:10 +0200 (CEST)
X-EA-Auth: 8dMeRQZuRzWHMWnIWSQMrkQQCwFfk1khZN6P/8qvFfeIh/IogdqMwni4BAHv1wHPLmvkWcH5Lhavg8uBp9xvKKBy30UmMVV6llDJjpQmqnQ=
From: Vincent Knecht <vincent.knecht@mailoo.org>
To: stephan@gerhold.net, lgirdwood@gmail.com, broonie@kernel.org,
 robh+dt@kernel.org, perex@perex.cz, tiwai@suse.com
Subject: [PATCH v1 0/4] Add tfa9897 speaker/receiver modes switching
Date: Sun, 24 Oct 2021 10:58:36 +0200
Message-Id: <20211024085840.1536438-1-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Vincent Knecht <vincent.knecht@mailoo.org>, linux-kernel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht
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

Two tfa9897 are used in tandem on some devices (eg. alcatel-idol347)
to drive two speakers, for both receiver (earpiece) and speaker modes.

This series:
1. adds a control to allow enabling only one tfa9897/speaker
   (for the typical phone-call usecase)
2. adds a control to switch between speaker and receiver modes
3. adds support for an optional gpio also used to switch modes

Stephan Gerhold (1):
  ASoC: codecs: tfa989x: Add switch to allow disabling amplifier

Vincent Knecht (3):
  ASoC: codecs: tfa989x: Add support for tfa9897 RCV bit
  ASoC: dt-bindings: nxp, tfa989x: Add rcv-gpios property for tfa9897
  ASoC: codecs: tfa989x: Add support for tfa9897 optional rcv-gpios

 .../bindings/sound/nxp,tfa989x.yaml           | 10 ++++
 sound/soc/codecs/tfa989x.c                    | 47 ++++++++++++++++++-
 2 files changed, 55 insertions(+), 2 deletions(-)

-- 
2.31.1



