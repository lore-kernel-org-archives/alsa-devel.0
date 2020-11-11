Return-Path: <SRS0=kIe0=ER=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FD7C388F9
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Nov 2020 12:28:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 130DA20795
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Nov 2020 12:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ahNAybWj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Le5VGkiz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 130DA20795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1800B1692;
	Wed, 11 Nov 2020 13:27:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1800B1692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605097692;
	bh=Al+OAfogp1YOEJ1DZixVNHSYLd+aesZLZ/t9GzZRKmE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ahNAybWjNOtgsGrIs54GY1+Tqvv2uhpQBJHa38bHcL9oPlFbesrDIMVFX4BQXZH5G
	 z5dn9c5NhMozZG3YGmAze7W8HTxgoNdPIxVJJkubEPDXqWWzD5t6g5GIUvwKFcE32P
	 gvEUXQEmEDHl0gJKEo7yt28QKALp28zCpvKsm9Q8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 82396F80059;
	Wed, 11 Nov 2020 13:27:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2155BF8022B; Wed, 11 Nov 2020 13:27:19 +0100 (CET)
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BCCC6F800AE
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2020 13:27:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BCCC6F800AE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="Le5VGkiz"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5fabd8a30000>; Wed, 11 Nov 2020 04:27:16 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 11 Nov
 2020 12:27:08 +0000
Received: from audio.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 11 Nov 2020 12:27:06 +0000
From: Sameer Pujar <spujar@nvidia.com>
To: <robh+dt@kernel.org>, <broonie@kernel.org>
Subject: [PATCH 0/2] Refactor Audio Graph schema
Date: Wed, 11 Nov 2020 17:56:51 +0530
Message-ID: <1605097613-25301-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1605097636; bh=B0Q1Meo9jLUCguFbXlLsBXwARLv5RaCTCbIMYbe/Rck=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Type;
 b=Le5VGkiz6kTxcA2kUyD8A79tXupLCjZrs5PWHxS1z7j+GgMTCnFcKQX1uPiDrcYUi
 N2U+57w971r26ENs6s7A2gR+NA8zLdkY3rZGTqaDDStdN4QNfFunkYhYNuT94Cd264
 IiyALLGwj3uSKfw2g37x7XoibBLoL9mugHXb1QP6qwGmka+/r80GoQzLbSSEMjmAlG
 3cI9EaFKsu3AhR13Pt8i3PYlnZaNPS20i+4EmSqV/3UkHLYir+9KHjLF5fMYPEn420
 kFSUQRz2ABnXqD6OH9AvTrA8KwarRXjli26sD6vx4id+UxcvcL4X7WlkuaEgGKhMIc
 3hwDXvqR9LBNQ==
Cc: Sameer Pujar <spujar@nvidia.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 kuninori.morimoto.gx@renesas.com
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

There can be custom sound cards reusing most of the audio-graph
implementation. To allow this refactor the audio-graph-card schema into
following files.
 * audio-graph.yaml       : defines all common bindings
 * audio-graph-card.yaml  : define compatible property

Custom sound cards can just reference 'audio-graph.yaml' and define its
own compatible and specific properties.

This depends on following series:
http://patchwork.ozlabs.org/project/devicetree-bindings/patch/20201102203656.220187-2-robh@kernel.org/

Sameer Pujar (2):
  ASoC: audio-graph-card: Refactor schema
  ASoC: renesas,rsnd: Update audio graph references

 .../bindings/sound/audio-graph-card.yaml           | 102 +-------------------
 .../devicetree/bindings/sound/audio-graph.yaml     | 107 +++++++++++++++++++++
 .../devicetree/bindings/sound/renesas,rsnd.yaml    |   6 +-
 3 files changed, 112 insertions(+), 103 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/audio-graph.yaml

-- 
2.7.4

