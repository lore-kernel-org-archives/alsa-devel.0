Return-Path: <SRS0=Fseo=P4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F37C433F5
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Nov 2021 22:23:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F265561B2D
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Nov 2021 22:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F265561B2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 63902168A;
	Tue,  9 Nov 2021 23:22:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 63902168A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636496619;
	bh=3JAE28fSKA6qnrcEMQx9bPFgXNxbVen5lGwA92srAMo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kh9jjeCZfPXNgBqt8K5FerYL5se7WU9HzkRVK3EKQEQ6JyL2Fnk1dqeRIFEKig8IE
	 /GbmI/hjiK9rP3VytW2ce9FECla7hThEfn0No1lOb+Zj0z0B1D1s4gWsO3W3iPjz7n
	 WyEFRSU3CU3HpQT1RIT9rl8A11woHZtXNAtCqZM8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C926DF804E0;
	Tue,  9 Nov 2021 23:20:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6B83FF80506; Tue,  9 Nov 2021 23:20:11 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6BD87F804E0
 for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2021 23:20:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6BD87F804E0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="JWylCG5h"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CED06124C;
 Tue,  9 Nov 2021 22:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636496403;
 bh=3JAE28fSKA6qnrcEMQx9bPFgXNxbVen5lGwA92srAMo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JWylCG5hUpSBKNbTlSQ2F+a8hqC4QGgoq+SR1aWu/zqJW92s/X1ml0O/63l7QqJSd
 +gWlFUruWoQixUEF0Q7syvlvmjIv8Ar67dGqA5wTJcAKrixCStKGHQ/h2oveP7kh6g
 AqwaxT1Djftla7gQhcgDoZBEuq0m209XfoINfTL3onwjlKtPYlcB/svBiVfHxOcUd3
 f3fyFoE0HPoSQYj642mhL8DWfACBcOvCEwg1VJAABHg4Sppox/7+64dgLCAHnS2uIp
 kQUD5mRXlrQVqb3VXa7SJmn7HChv+4BK7/R51jhZatUnuNrSbejlTc6m3B9I/tUhbp
 Jn/QbfYKzhjWA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.14 33/75] ASoC: SOF: Intel: hda-dai: fix potential
 locking issue
Date: Tue,  9 Nov 2021 17:18:23 -0500
Message-Id: <20211109221905.1234094-33-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211109221905.1234094-1-sashal@kernel.org>
References: <20211109221905.1234094-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, Takashi Iwai <tiwai@suse.de>, tiwai@suse.com,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit a20f3b10de61add5e14b6ce4df982f4df2a4cbbc ]

The initial hdac_stream code was adapted a third time with the same
locking issues. Move the spin_lock outside the loops and make sure the
fields are protected on read/write.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20210924192417.169243-5-pierre-louis.bossart@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/hda-dai.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index c1f9f0f584647..6704dbcd101cd 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -68,6 +68,7 @@ static struct hdac_ext_stream *
 		return NULL;
 	}
 
+	spin_lock_irq(&bus->reg_lock);
 	list_for_each_entry(stream, &bus->stream_list, list) {
 		struct hdac_ext_stream *hstream =
 			stream_to_hdac_ext_stream(stream);
@@ -107,12 +108,12 @@ static struct hdac_ext_stream *
 		 * is updated in snd_hdac_ext_stream_decouple().
 		 */
 		if (!res->decoupled)
-			snd_hdac_ext_stream_decouple(bus, res, true);
-		spin_lock_irq(&bus->reg_lock);
+			snd_hdac_ext_stream_decouple_locked(bus, res, true);
+
 		res->link_locked = 1;
 		res->link_substream = substream;
-		spin_unlock_irq(&bus->reg_lock);
 	}
+	spin_unlock_irq(&bus->reg_lock);
 
 	return res;
 }
-- 
2.33.0

