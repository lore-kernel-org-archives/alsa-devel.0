Return-Path: <SRS0=maC8=GO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E79C433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Jan 2021 13:05:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ACAD22A84
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Jan 2021 13:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ACAD22A84
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DA71216BE;
	Mon, 11 Jan 2021 14:04:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DA71216BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610370299;
	bh=WzSoRwGnOMha3US3ZiT8rvVBaimWv3XT6vtTWLPd8qg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lumVeLXdJc/4wXJod0rLaLMaEn4doczpdZMIkx76eNkViMoCJ0dUi0hC6tK+x5+ZC
	 pD9NUbyhW6i+Wy4H0h06vJy+eQoqFvvsktRr0MGeeMAlZu3NKnKhvjcYzRD+kvhm5v
	 M3DIEEpt+5UwDDBYHXA0z8+a6azeeICpY7JTe5k0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 48544F8026D;
	Mon, 11 Jan 2021 14:03:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2D97BF804C3; Mon, 11 Jan 2021 14:03:10 +0100 (CET)
Received: from michel.telenet-ops.be (michel.telenet-ops.be
 [IPv6:2a02:1800:110:4::f00:18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A2CFDF800BE
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2021 14:02:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A2CFDF800BE
Received: from ramsan.of.borg ([84.195.186.194])
 by michel.telenet-ops.be with bizsmtp
 id FR2u2400d4C55Sk06R2uHo; Mon, 11 Jan 2021 14:02:55 +0100
Received: from rox.of.borg ([192.168.97.57])
 by ramsan.of.borg with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1kywqU-002pvR-8d; Mon, 11 Jan 2021 14:02:54 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1kywqT-001W0q-Qb; Mon, 11 Jan 2021 14:02:53 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Clemens Ladisch <clemens@ladisch.de>,
 Takashi Sakamoto <o-takashi@sakamocchi.jp>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH/RFC 1/2] ALSA: fireface: Fix integer overflow in
 transmit_midi_msg()
Date: Mon, 11 Jan 2021 14:02:50 +0100
Message-Id: <20210111130251.361335-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210111130251.361335-1-geert+renesas@glider.be>
References: <20210111130251.361335-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
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

As snd_ff.rx_bytes[] is unsigned int, and NSEC_PER_SEC is 1000000000L,
the second multiplication in

    ff->rx_bytes[port] * 8 * NSEC_PER_SEC / 31250

always overflows on 32-bit platforms, truncating the result.  Fix this
by precalculating "NSEC_PER_SEC / 31250", which is an integer constant.

Note that this assumes ff->rx_bytes[port] <= 16777.

Fixes: 19174295788de77d ("ALSA: fireface: add transaction support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.

I don't know the maximum transfer length of MIDI, but given it's an old
standard, I guess it's rather small.  If it is larger than 16777, the
constant "8" should be replaced by "8ULL", to force 64-bit arithmetic.
---
 sound/firewire/fireface/ff-transaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/fireface/ff-transaction.c b/sound/firewire/fireface/ff-transaction.c
index 7f82762ccc8c80ba..ee7122c461d46f44 100644
--- a/sound/firewire/fireface/ff-transaction.c
+++ b/sound/firewire/fireface/ff-transaction.c
@@ -88,7 +88,7 @@ static void transmit_midi_msg(struct snd_ff *ff, unsigned int port)
 
 	/* Set interval to next transaction. */
 	ff->next_ktime[port] = ktime_add_ns(ktime_get(),
-				ff->rx_bytes[port] * 8 * NSEC_PER_SEC / 31250);
+			ff->rx_bytes[port] * 8 * (NSEC_PER_SEC / 31250));
 
 	if (quad_count == 1)
 		tcode = TCODE_WRITE_QUADLET_REQUEST;
-- 
2.25.1

