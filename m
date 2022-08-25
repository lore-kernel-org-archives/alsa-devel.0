Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07030C64990
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Aug 2022 14:03:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2A47F85D;
	Thu, 25 Aug 2022 16:02:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2A47F85D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661436228;
	bh=UscZaJzKf+qVivbrOaEKdrXn0pmhMqjUr2zc+LVTUM8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XWlbET0sYV0hBlwA0w2Z63wwg7LM7f/DDmFbpKlAWOgSs3exdC6Qh9p6BRLX3KuCB
	 An2WWVE8ScV3pOIYkVQgqkLwrXmE3JBSORxBoZEx0KueQVYaejiwIOkNn9MaNDV+61
	 tmsvF0PWTgN1UJ8uQUFZ+v/MwDTuejdXPiusPgz0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AC830F80271;
	Thu, 25 Aug 2022 16:02:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 94493F80506; Thu, 25 Aug 2022 16:02:55 +0200 (CEST)
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 969BCF800C8
 for <alsa-devel@alsa-project.org>; Thu, 25 Aug 2022 16:02:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 969BCF800C8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=cutebit.org header.i=@cutebit.org
 header.b="hv7CXhgL"
From: =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
 t=1661436170; bh=ELGy1lUsHhPdvqtxh1bn64AYOFQqdlpEPx8nzBVvc/Q=;
 h=From:To:Cc:Subject:Date;
 b=hv7CXhgLy6WgpqX3UhKZwyPXlNgVtxyprcluDZBE80PKmGq3Rfv2ewtadZaKh86mY
 oVcHp3SuYeBvnqN0AD/KIjSLmw5qVbjsEiAy3vLYXCxscRoHVZM9td56eRj1b3l8BY
 TblbGZnNpko+m1A0bNOmMflMqB+d9jWpmkQKynDg=
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/5] TAS2764 fixes/extensions
Date: Thu, 25 Aug 2022 16:02:36 +0200
Message-Id: <20220825140241.53963-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>,
 navada@ti.com, asahi@lists.linux.dev, linux-kernel@vger.kernel.org,
 asyrus@ti.com, shenghao-ding@ti.com, raphael-xu@ti.com,
 =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
 Stephen Kitt <steve@sk2.org>, Dan Murphy <dmurphy@ti.com>
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

First three patches are fixes analogical to those recently done to
the TAS2770 driver.
Link: https://lore.kernel.org/asahi/20220808141246.5749-1-povik+lin@cutebit.org/T/#t

The latter two add IRQ handler to log faults and expose a new control.

Martin Povišer (5):
  ASoC: tas2764: Allow mono streams
  ASoC: tas2764: Drop conflicting set_bias_level power setting
  ASoC: tas2764: Fix mute/unmute
  ASoC: tas2764: Add IRQ handling
  ASoC: tas2764: Export highpass filter setting

 sound/soc/codecs/tas2764.c | 181 ++++++++++++++++++++++++++-----------
 sound/soc/codecs/tas2764.h |  23 +++++
 2 files changed, 152 insertions(+), 52 deletions(-)

-- 
2.33.0

