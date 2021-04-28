Return-Path: <SRS0=9FQT=JZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D763C433B4
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Apr 2021 11:30:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D01761424
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Apr 2021 11:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D01761424
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2037916B6;
	Wed, 28 Apr 2021 13:29:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2037916B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619609439;
	bh=RqkgiCf8P2hH5lW41ZO6wcqaKLiScWb7MtJn0/aW+BE=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PaQp1BOSE1Ji9AxFUjTjAu2WTYpFiUuv7cdM8LMka5imF64IiwL9v0SSy79DhZVIQ
	 vP5/9vPp8IEHJjPken0tigUUjWxQ6zYtua3TaGlsQcZH/8n0pW2TO7DbCUt79Xa5Uj
	 hGE9pK1T10VkvGId/bRMPlsjR1DnQtgVYcEkD0Zk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F0133F804B4;
	Wed, 28 Apr 2021 13:27:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B3455F80218; Wed, 28 Apr 2021 13:27:29 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6BFFCF80218
 for <alsa-devel@alsa-project.org>; Wed, 28 Apr 2021 13:27:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6BFFCF80218
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 8827DB155
 for <alsa-devel@alsa-project.org>; Wed, 28 Apr 2021 11:27:05 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 00/13] ALSA: hda: Re-order quirk table entries
Date: Wed, 28 Apr 2021 13:26:51 +0200
Message-Id: <20210428112704.23967-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

this is a series of trivial changes just to re-order the quirk table
entries for HD-audio codec drivers.  We've tried to keep the entries
in the PCI SSID order, but occasionally somd disorder came in.  It's
not only bad for the readability but also leading to the oversight of
duplicated entries or the unreachable entries unexpectedly.

Basically this could be done in a shot by a script, but I split to
parts, so that each piece can be better applied (or fixed) for stable
kernels.

There is one fix patch in the series that addresses the duplicated
entries.  Other than that, all about shuffling and no functional
changes must be introduced by this series.


Takashi

===

Takashi Iwai (13):
  ALSA: hda/realtek: Re-order ALC882 Acer quirk table entries
  ALSA: hda/realtek: Re-order ALC882 Sony quirk table entries
  ALSA: hda/realtek: Re-order ALC882 Clevo quirk table entries
  ALSA: hda/realtek: Re-order ALC269 HP quirk table entries
  ALSA: hda/realtek: Re-order ALC269 Acer quirk table entries
  ALSA: hda/realtek: Re-order ALC269 Dell quirk table entries
  ALSA: hda/realtek: Re-order ALC269 ASUS quirk table entries
  ALSA: hda/realtek: Re-order ALC269 Sony quirk table entries
  ALSA: hda/realtek: Re-order ALC269 Lenovo quirk table entries
  ALSA: hda/realtek: Re-order remaining ALC269 quirk table entries
  ALSA: hda/realtek: Re-order ALC662 quirk table entries
  ALSA: hda/realtek: Remove redundant entry for ALC861 Haier/Uniwill
    devices
  ALSA: hda/conexant: Re-order CX5066 quirk table entries

 sound/pci/hda/patch_conexant.c |  14 ++--
 sound/pci/hda/patch_realtek.c  | 113 ++++++++++++++++-----------------
 2 files changed, 62 insertions(+), 65 deletions(-)

-- 
2.26.2

