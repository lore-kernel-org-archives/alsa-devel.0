Return-Path: <SRS0=adxF=2N=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43ACC2D0C0
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Dec 2019 15:49:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 445FC205C9
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Dec 2019 15:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IjJPK2Ko";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="nBiqSjNT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="nBiqSjNT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445FC205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 687961687;
	Mon, 23 Dec 2019 16:48:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 687961687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1577116187;
	bh=EFKnuZPfjSyXM0jniDsWak7Jt7mWkcT2Var2/IXgCXs=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IjJPK2Ko+hUZ+OiEkWMLDhobXuAo7En/eD2Z8O5ucYcqV/HOA3lRxSWqELJJajH+h
	 UxWUSD05IscDJBtwfck4Zaidhcyybct6TI0A/xNXbRmFYnEMdsIFnSKlCYp3TQuidX
	 aEG+XJS3LDRraVzBIFHUYJzsgYggDDwXJj3/g6tI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 983C5F80146;
	Mon, 23 Dec 2019 16:48:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 29945F80131; Mon, 23 Dec 2019 16:48:00 +0100 (CET)
Received: from node.akkea.ca (node.akkea.ca [192.155.83.177])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 33261F80087
 for <alsa-devel@alsa-project.org>; Mon, 23 Dec 2019 16:47:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 33261F80087
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca
 header.b="nBiqSjNT"; 
 dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca
 header.b="nBiqSjNT"
Received: from localhost (localhost [127.0.0.1])
 by node.akkea.ca (Postfix) with ESMTP id 4A72A4E200E;
 Mon, 23 Dec 2019 15:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1577116074; bh=32jFHoBT/8A9zaicn0KxEkscstF6mPjMAkS1keiBsqQ=;
 h=From:To:Cc:Subject:Date;
 b=nBiqSjNTbIcp5dsnZbr3uHOZoeYGPAKrJ/iC6ih9CV1HDcd29I7IzBPAL0i9E4nvr
 NhJRl0w53uRqBhmtKZ4YmBTwI5g5UgYrcIq0DV6lAIE7vV+OThTxcrqvm6vBIF7Ryf
 3MX9io12qtwjzyo+oJJBbeKom0SCNj5bC6HZVuZU=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
 by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CGd51sVCK05Q; Mon, 23 Dec 2019 15:47:54 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net
 [70.66.86.75])
 by node.akkea.ca (Postfix) with ESMTPSA id 9C6004E2003;
 Mon, 23 Dec 2019 15:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1577116074; bh=32jFHoBT/8A9zaicn0KxEkscstF6mPjMAkS1keiBsqQ=;
 h=From:To:Cc:Subject:Date;
 b=nBiqSjNTbIcp5dsnZbr3uHOZoeYGPAKrJ/iC6ih9CV1HDcd29I7IzBPAL0i9E4nvr
 NhJRl0w53uRqBhmtKZ4YmBTwI5g5UgYrcIq0DV6lAIE7vV+OThTxcrqvm6vBIF7Ryf
 3MX9io12qtwjzyo+oJJBbeKom0SCNj5bC6HZVuZU=
From: "Angus Ainslie (Purism)" <angus@akkea.ca>
To: broonie@kernel.org
Date: Mon, 23 Dec 2019 07:47:10 -0800
Message-Id: <20191223154712.18581-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
Cc: robh@kernel.org, alsa-devel@alsa-project.org, kernel@puri.sm,
 "Angus Ainslie \(Purism\)" <angus@akkea.ca>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: [alsa-devel] [PATCH v4 0/2] Add the broadmobi BM818
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

The broadmobi uses slightly different parameters from the option modems
so add the paramters and document them.

Changes since v3:

Dropped unrelated indentation fix.
Fixed const warning.

Changes since v2:

Use of_device_get_match_data to get the dai data.
Updated subject styles.

Changes since v1:

Cut back the CC list.
Use data from compatible match instead of explicit compatible match.

Angus Ainslie (Purism) (2):
  ASoC: gtm601: add Broadmobi bm818 sound profile
  dt-bindings: sound: gtm601: add the broadmobi interface

 .../devicetree/bindings/sound/gtm601.txt      | 10 +++++--
 sound/soc/codecs/gtm601.c                     | 30 +++++++++++++++++--
 2 files changed, 35 insertions(+), 5 deletions(-)

-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
