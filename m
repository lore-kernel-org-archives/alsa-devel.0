Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376F5C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Mar 2022 12:06:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 83B0A1AB5;
	Wed, 30 Mar 2022 14:05:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 83B0A1AB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1648641995;
	bh=KILYHveAm1KA+QDA4KsMbD9x4kEXUusNdRBZBi+Vj3M=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vlzQYXSGk9KM5lOYGXD8Rsa1nol1vi1A0flQZi/IZ+KKGYb5xuuRU/9/V0NVLj96O
	 Xedha/91EkL1QPSOezUi0qXpOYmD+VTlWWMT/uRyzAMJgO3KmBrsnej6pdMHfsdNED
	 0WSI+QKsXnQePJH7PgwVbuoEJcjjjvF8+aDwpyjE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DE02EF805AF;
	Wed, 30 Mar 2022 13:54:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C728FF805B2; Wed, 30 Mar 2022 13:54:01 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A70DCF8057A
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2022 13:53:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A70DCF8057A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="trfeWur3"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9FC0C61709;
 Wed, 30 Mar 2022 11:53:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86AFDC36AE2;
 Wed, 30 Mar 2022 11:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1648641234;
 bh=KILYHveAm1KA+QDA4KsMbD9x4kEXUusNdRBZBi+Vj3M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=trfeWur3KHESINxAuLYW5iIN8PxgStCMYc0E1DvA4moJFAogFitSw/yiZd37CvMj6
 bI3Z2Wa5lj22BKQdlTXYCwKAxuq8FQ6+LFxkFgjvBb0F0XC/41IxkjZCmRqjhx5mQw
 5RT8W4+PD6fQimoHP6Lt2hvCDO3MtSsgccYFcA7UlQQmpIpjpohoYAKQLOZwnRuJa8
 JTgu0/Q0DoMHI4WAr17D8NRYb6mRbvKkt6YbvH2p8QHUQ9/g/vbrThlNMAzxZHr6j/
 GCC/104HtXnfekQ3zcHsa7SGiPOkIDRgXuNzuEXrIxLTtKYRjvgqswPxh7CrIJ6hdy
 EQhPyFEuPFunQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 11/20] ASoC: soc-core: skip zero num_dai
 component in searching dai name
Date: Wed, 30 Mar 2022 07:53:27 -0400
Message-Id: <20220330115336.1672930-11-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220330115336.1672930-1-sashal@kernel.org>
References: <20220330115336.1672930-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Shengjiu Wang <shengjiu.wang@nxp.com>, tiwai@suse.com, lgirdwood@gmail.com,
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

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit f7d344a2bd5ec81fbd1ce76928fd059e57ec9bea ]

In the case like dmaengine which's not a dai but as a component, the
num_dai is zero, dmaengine component has the same component_of_node
as cpu dai, when cpu dai component is not ready, but dmaengine component
is ready, try to get cpu dai name, the snd_soc_get_dai_name() return
-EINVAL, not -EPROBE_DEFER, that cause below error:

asoc-simple-card <card name>: parse error -22
asoc-simple-card: probe of <card name> failed with error -22

The sound card failed to probe.

So this patch fixes the issue above by skipping the zero num_dai
component in searching dai name.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Link: https://lore.kernel.org/r/1644491952-7457-1-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2a172de37466..febf2b649b96 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4243,7 +4243,7 @@ int snd_soc_get_dai_name(struct of_phandle_args *args,
 		if (!component_of_node && pos->dev->parent)
 			component_of_node = pos->dev->parent->of_node;
 
-		if (component_of_node != args->np)
+		if (component_of_node != args->np || !pos->num_dai)
 			continue;
 
 		if (pos->driver->of_xlate_dai_name) {
-- 
2.34.1

