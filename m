Return-Path: <SRS0=maC8=GO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75423C433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Jan 2021 13:04:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BAF622515
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Jan 2021 13:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BAF622515
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B5E3916DC;
	Mon, 11 Jan 2021 14:04:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B5E3916DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610370293;
	bh=pR3A2y0E+VqX0Uj5ghmcn6nmX7NXSWdT44Q9v7c5CoQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GWdRhG3YaBjdVELIoNtbzb7O4FNJWql+2S0CNXHdtrzgRzI9YKAMjYCtftN8qY2ca
	 OSPu60QL60xRWyfZvCOPD2X1EOsObmxZ1jQTQ4zANIYniuxVtW8yT51IhdYLlb6Y9U
	 dKbTaTxlYvG1Anpq0KrTf0FCV8ZgnHDLm2FMXVB4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6A2F1F8026B;
	Mon, 11 Jan 2021 14:03:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BC07FF8016C; Mon, 11 Jan 2021 14:03:04 +0100 (CET)
Received: from michel.telenet-ops.be (michel.telenet-ops.be
 [IPv6:2a02:1800:110:4::f00:18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 914A8F8013D
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2021 14:02:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 914A8F8013D
Received: from ramsan.of.borg ([84.195.186.194])
 by michel.telenet-ops.be with bizsmtp
 id FR2u2400W4C55Sk06R2uHm; Mon, 11 Jan 2021 14:02:55 +0100
Received: from rox.of.borg ([192.168.97.57])
 by ramsan.of.borg with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1kywqU-002pvQ-6D; Mon, 11 Jan 2021 14:02:54 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1kywqT-001W0n-PZ; Mon, 11 Jan 2021 14:02:53 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Clemens Ladisch <clemens@ladisch.de>,
 Takashi Sakamoto <o-takashi@sakamocchi.jp>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH/RFC 0/2] ALSA: firewire: Fix integer overflows on 32-bit
Date: Mon, 11 Jan 2021 14:02:49 +0100
Message-Id: <20210111130251.361335-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
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

	Hi all,

This patch series fixes two integer overflows on 32-bit platforms when
in multiplications with the NSEC_PER_SEC constant, found by code
inspection.  They are marked "RFC", as I don't know the maximum transfer
length of MIDI.  Depending on this maximum length, a small tweak may be
necessary.

Thanks for your comments!

Geert Uytterhoeven (2):
  ALSA: fireface: Fix integer overflow in transmit_midi_msg()
  ALSA: firewire-tascam: Fix integer overflow in midi_port_work()

 sound/firewire/fireface/ff-transaction.c   | 2 +-
 sound/firewire/tascam/tascam-transaction.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
