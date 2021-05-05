Return-Path: <SRS0=SRJ/=KA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE61C433ED
	for <alsa-devel@archiver.kernel.org>; Wed,  5 May 2021 16:45:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9883613C3
	for <alsa-devel@archiver.kernel.org>; Wed,  5 May 2021 16:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9883613C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6BFCB174A;
	Wed,  5 May 2021 18:44:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6BFCB174A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620233142;
	bh=F+pne/Hjxiv7x9JXuhGkN38R9E5g7VxohpNgBfzPr/A=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UdElGfTNXs7aCT7TQrysCHbuyJmD2BZayGv6zsevvbgyw+S8vWFjSp3Ue4VOJWZnq
	 6BXwHLpPmMFxbHkC3KyGH5c9WjG6jIZDbitXYwxYtfHm7Lsox5HfRTsPf0Dg10H9gO
	 fhMb7dvfxV6w4MOkNZmty91fWKYqRXzfVM9vkFoE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F1322F804F2;
	Wed,  5 May 2021 18:37:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F31EAF804FA; Wed,  5 May 2021 18:37:18 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A856AF804F2
 for <alsa-devel@alsa-project.org>; Wed,  5 May 2021 18:37:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A856AF804F2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="cVBpXRPO"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 676EE61956;
 Wed,  5 May 2021 16:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620232633;
 bh=F+pne/Hjxiv7x9JXuhGkN38R9E5g7VxohpNgBfzPr/A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cVBpXRPOcOfFzdkZYIt3SwN5mcc70nIbU2/NSlvya7Pv7KrIesgMMk0TPb2FcnFOO
 /bC9+hzrFQFmy0UPE4F4bOzeqRXMPV8bR1Rv/1l/6b/ivBJ8oluPMZZryjc/UYMPsx
 d9mO6/tMfr+4s/bgCZVkY1p9wYIWoYyJd4uwY41mz4jTwjlrgmXy2aXsHo6k18H8X6
 LtcTPIuAbvS5Msib2R5+1ZI3KRRrCf9NlsTAilsbxOv5wdFh18W28grMhzMwY/061e
 y17hQQ7ddyqjG1hGE9mQ7uNZ00AdrejHDps4mledGkIZr+6JNZgm2GVBb+gEBkScN4
 +TAKjiudN9xVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 17/85] ALSA: bebob: enable to deliver MIDI
 messages for multiple ports
Date: Wed,  5 May 2021 12:35:40 -0400
Message-Id: <20210505163648.3462507-17-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210505163648.3462507-1-sashal@kernel.org>
References: <20210505163648.3462507-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org
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

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

[ Upstream commit d2b6f15bc18ac8fbce25398290774c21f5b2cd44 ]

Current implementation of bebob driver doesn't correctly handle the case
that the device has multiple MIDI ports. The cause is the number of MIDI
conformant data channels is passed to AM824 data block processing layer.

This commit fixes the bug.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Link: https://lore.kernel.org/r/20210321032831.340278-4-o-takashi@sakamocchi.jp
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/firewire/bebob/bebob_stream.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index bbae04793c50..c18017e0a3d9 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -517,20 +517,22 @@ int snd_bebob_stream_init_duplex(struct snd_bebob *bebob)
 static int keep_resources(struct snd_bebob *bebob, struct amdtp_stream *stream,
 			  unsigned int rate, unsigned int index)
 {
-	struct snd_bebob_stream_formation *formation;
+	unsigned int pcm_channels;
+	unsigned int midi_ports;
 	struct cmp_connection *conn;
 	int err;
 
 	if (stream == &bebob->tx_stream) {
-		formation = bebob->tx_stream_formations + index;
+		pcm_channels = bebob->tx_stream_formations[index].pcm;
+		midi_ports = bebob->midi_input_ports;
 		conn = &bebob->out_conn;
 	} else {
-		formation = bebob->rx_stream_formations + index;
+		pcm_channels = bebob->rx_stream_formations[index].pcm;
+		midi_ports = bebob->midi_output_ports;
 		conn = &bebob->in_conn;
 	}
 
-	err = amdtp_am824_set_parameters(stream, rate, formation->pcm,
-					 formation->midi, false);
+	err = amdtp_am824_set_parameters(stream, rate, pcm_channels, midi_ports, false);
 	if (err < 0)
 		return err;
 
-- 
2.30.2

