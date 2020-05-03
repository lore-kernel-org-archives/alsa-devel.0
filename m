Return-Path: <SRS0=UCdw=6R=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E7FC28CBC
	for <alsa-devel@archiver.kernel.org>; Sun,  3 May 2020 04:59:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94CBA2075B
	for <alsa-devel@archiver.kernel.org>; Sun,  3 May 2020 04:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Xd4L1vR5";
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="QrnEy/66";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qNVuaFb1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94CBA2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C512B16AB;
	Sun,  3 May 2020 06:59:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C512B16AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588481994;
	bh=hYOn4JMtQZFdfDioB+v7c1eO8G3yZqo9/yya2bYQK5I=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Xd4L1vR5thI/SprQBn3Zb42I8K3qisFz1DwohKJUa7kjIqzSCSjJvWgCfQdouOzQ7
	 gRGoTEKJBNQsZeaHjuEZSXpGCVW1U627tmmOd6IrjNZMXIW2A3qCT7+Hft59XqzTSz
	 mnZnBkbFt5GV5sdz1AwTnRKA1oyOL9wEl74zfjGg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 362C9F8015B;
	Sun,  3 May 2020 06:59:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DD47DF8015F; Sun,  3 May 2020 06:57:35 +0200 (CEST)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ECE96F800E5
 for <alsa-devel@alsa-project.org>; Sun,  3 May 2020 06:57:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ECE96F800E5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="QrnEy/66"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="qNVuaFb1"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.nyi.internal (Postfix) with ESMTP id 629D95C02C9;
 Sun,  3 May 2020 00:57:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Sun, 03 May 2020 00:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=a01vPk5jSMbZLWQ4MSCaHLAiq4
 QZ7Nwd4TNYnIPTX0U=; b=QrnEy/66w78ae+lUHdhrZrcycr/bTmQjF0Mlgr7Vs5
 hBPHsy0+YNFV+4d076IiUE6ZtkMyBltxjkd3jCAbdUm6w65wCjk3s/edSkMPM0OS
 7e9oNUIi5FT1+GQet79G/gScJBlvWYWqqngLYB/VczZU1ETdmGDLuLyqJqP5Ov5u
 swYbSDUbMXyzLCgs9Ksh2/KXdzdxfUtKRbSkR+EQPoWAYu0r9CW4ljvQkZD2FWaT
 ng1D8+QlVLrvJdY3u2Uv9s758j7NcutPZkYIzmdjKN3GR8MBtXsRSB7a7WgFbjB6
 /0ko1mvar1C91KyU5O/AR4he9opXtLAoOC9Z29/QEwdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=a01vPk5jSMbZLWQ4M
 SCaHLAiq4QZ7Nwd4TNYnIPTX0U=; b=qNVuaFb1F8mMW0mEiN4V+S9lnK00VKBa2
 iunyumhUFLtZRVwZeX0Xe9T1KwWUv7LOErhoae1BX0nGPNmPGHBwukxXoICHdVgA
 ouJqpiRlHLBru3oUSY5ptI4kBR7sDBsiEMgMUFt0IwHBWNH4y8dKjQ2OWplFjBcT
 oiLa+w2Sw6XzYy0t6/UCUqEXCuqkw2JKD/WviGIAiwvbbfO7jE/42gH4rAPbSes8
 2fDneVqOW1DYvzXbCkutqkCy1Sk4CF5El6w5FEXxXyAa04jRJ36n8NbH1tIrs0v0
 z85rMsAToq3RFjetQ/AkWAfgSP70IlC+VSJ4dAHiW76OSeOISI4pQ==
X-ME-Sender: <xms:M0-uXsCZgqBeHnXQFQx_IX4kuGKEyYkc_jN_PUvMVLRgsBGbopjf0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrjedtgdekfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
 dtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhi
 sehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedujeetlefhtddtke
 fgtdeuieelhffgteejjeehkeegveduvdevgeeiheeuueekjeenucfkphepudektddrvdef
 hedrfedrheegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:M0-uXvMCBtDmPAsjHkeu1iyuD9AcZwmQ5PQMGrao-t2_zPY9NUZEUA>
 <xmx:M0-uXqr6MJqINEWB1SJTC3T3LrU29-FYL1Gr-sKUOijHWX-U2I6PLg>
 <xmx:M0-uXixImIvHtjYqMAEQW60hUmo-6CHylmWLLkydik9yZ5dkrXGsyQ>
 <xmx:NE-uXshJEiTUSGYEjmtq11TpHNEBV1olBQBuUEDqqGtm1iAm1HQtGw>
Received: from workstation.flets-east.jp (ad003054.dynamic.ppp.asahi-net.or.jp
 [180.235.3.54])
 by mail.messagingengine.com (Postfix) with ESMTPA id D7FFF3280067;
 Sun,  3 May 2020 00:57:21 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: clemens@ladisch.de,
	tiwai@suse.de
Subject: [PATCH] ALSA: firewire-lib: fix 'function sizeof not defined' error
 of tracepoints format
Date: Sun,  3 May 2020 13:57:18 +0900
Message-Id: <20200503045718.86337-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org
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

The snd-firewire-lib.ko has 'amdtp-packet' event of tracepoints. Current
printk format for the event includes 'sizeof(u8)' macro expected to be
extended in compilation time. However, this is not done. As a result,
perf tools cannot parse the event for printing:

$ mount -l -t debugfs
debugfs on /sys/kernel/debug type debugfs (rw,nosuid,nodev,noexec,relatime)
$ cat /sys/kernel/debug/tracing/events/snd_firewire_lib/amdtp_packet/format
...
print fmt: "%02u %04u %04x %04x %02d %03u %02u %03u %02u %01u %02u %s",
  REC->second, REC->cycle, REC->src, REC->dest, REC->channel,
  REC->payload_quadlets, REC->data_blocks, REC->data_block_counter,
  REC->packet_index, REC->irq, REC->index,
  __print_array(__get_dynamic_array(cip_header),
                __get_dynamic_array_len(cip_header),
                sizeof(u8))

$ sudo perf record -e snd_firewire_lib:amdtp_packet
  [snd_firewire_lib:amdtp_packet] function sizeof not defined
  Error: expected type 5 but read 0

This commit fixes it by obsoleting the macro with actual size.

Cc: <stable@vger.kernel.org>
Fixes: bde2bbdb307a: ("ALSA: firewire-lib: use dynamic array for CIP header of tracing events")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream-trace.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/firewire/amdtp-stream-trace.h b/sound/firewire/amdtp-stream-trace.h
index 16c7f6605511..26e7cb555d3c 100644
--- a/sound/firewire/amdtp-stream-trace.h
+++ b/sound/firewire/amdtp-stream-trace.h
@@ -66,8 +66,7 @@ TRACE_EVENT(amdtp_packet,
 		__entry->irq,
 		__entry->index,
 		__print_array(__get_dynamic_array(cip_header),
-			      __get_dynamic_array_len(cip_header),
-			      sizeof(u8)))
+			      __get_dynamic_array_len(cip_header), 1))
 );
 
 #endif
-- 
2.25.1

