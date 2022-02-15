Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDA2C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Feb 2022 13:29:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3387B188B;
	Tue, 15 Feb 2022 14:29:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3387B188B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1644931793;
	bh=hm5LMmhN6QkdqrAIMqSbUJK0D4PvQZ930ZnY+AJwYiE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mGlw5tSliT9Pr5Rw81xPUve0JyaWvayL+dG44Mlc8BpDNZ/3uV0n7+iiScJiiayws
	 5Ho3yVknZBVita75CUR7JZKI9St28RYSgeMTtI1Hbgv7ybCD38bDUhV3nBbl2SEXgy
	 a6bFuxhnDNFuat2EaEMKunHpl/K07HWxmJqScyds=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7CF90F80508;
	Tue, 15 Feb 2022 14:28:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A6B84F8020D; Tue, 15 Feb 2022 14:28:08 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 90D5AF80132
 for <alsa-devel@alsa-project.org>; Tue, 15 Feb 2022 14:28:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 90D5AF80132
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="w1z8tepS"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="iBSzS8Tb"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 953561F391;
 Tue, 15 Feb 2022 13:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644931679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=SyUccQZxZ9BU22iennaGfM54hk+63SSdk9vc1BSwwbk=;
 b=w1z8tepSoKUkLZTGpMKwzLBOIewahQalnSL4lw8IqNLKt7j/olCt/C8pbTfsKM8APTUksX
 Z6toMOZp/Lm/le3g6g2ksT05mJ3DojbdL3uDjol3vurXwJvcENTwZsYzQvuvS+x6keCUF2
 w5Zz1Jtn2QAylxLZIPiQKWNCuhz9/sY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644931679;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=SyUccQZxZ9BU22iennaGfM54hk+63SSdk9vc1BSwwbk=;
 b=iBSzS8TbewjfU5E/E/URq1NBbnRioayL3Nu+B1Y+u+6Ndvk90drQQoqoZ1Vj8GR65ysi4b
 SHHEoj9DnK7uufCA==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 79014A3B84;
 Tue, 15 Feb 2022 13:27:59 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/3] ALSA: Set max DMA segment size
Date: Tue, 15 Feb 2022 14:27:53 +0100
Message-Id: <20220215132756.31236-1-tiwai@suse.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>,
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

Hi,

this is a oneliner patches to address the spurious kernel WARNING from
DMA debug code for the missing setup of DMA segment size for SG pages.


Takashi

===

Takashi Iwai (3):
  ALSA: hda: Set max DMA segment size
  ASoC: SOF: hda: Set max DMA segment size
  ASoC: intel: skylake: Set max DMA segment size

 sound/pci/hda/hda_intel.c     | 1 +
 sound/soc/intel/skylake/skl.c | 1 +
 sound/soc/sof/intel/hda.c     | 1 +
 3 files changed, 3 insertions(+)

-- 
2.31.1

