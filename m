Return-Path: <SRS0=GC6S=PO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3942C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Oct 2021 15:13:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA6256023D
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Oct 2021 15:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CA6256023D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C27391725;
	Tue, 26 Oct 2021 17:12:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C27391725
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635261189;
	bh=kRBVexgMRrWWxxP/Z1FO0QSiRfH8a9QefiEDoC0fvCk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jHzhhXXZtQH7nkwxfcGa3C28QtmvJSzgXmanipoZGVGf+c3BUCtaKT2o6dfIboT3W
	 di/CPBqtq23OjcRmhPII9vDh9Eb5Wft9uNP/Ob+YL4+klDDrK5+sDuoACMC39wec6n
	 p/LyD1TrrtLHd04eoMIddtcqTZY3oVkgkvTRRinw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 02D36F8010A;
	Tue, 26 Oct 2021 17:11:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 40A25F80300; Tue, 26 Oct 2021 17:11:35 +0200 (CEST)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0EFD5F80269
 for <alsa-devel@alsa-project.org>; Tue, 26 Oct 2021 17:11:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0EFD5F80269
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:441:6c1a:bc30:46e])
 by xavier.telenet-ops.be with bizsmtp
 id AfBR260132hfXWm01fBRfN; Tue, 26 Oct 2021 17:11:25 +0200
Received: from rox.of.borg ([192.168.97.57])
 by ramsan.of.borg with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1mfO6n-0084pC-BV; Tue, 26 Oct 2021 17:11:25 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1mfO6m-00DLmj-Ck; Tue, 26 Oct 2021 17:11:24 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 0/3] ASoC: amd: acp: Dependency cleanup
Date: Tue, 26 Oct 2021 17:11:20 +0200
Message-Id: <cover.1635260849.git.geert+renesas@glider.be>
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

This patch series cleans up the dependencies of the various
configuration symbols related to AMD Audio-Coprocessor support.

Feel free to squash into a single patch if you prefer that.

Thanks!

Geert Uytterhoeven (3):
  ASoC: amd: acp: Wrap AMD Audio ACP components in
    SND_SOC_AMD_ACP_COMMON
  ASoC: amd: acp: SND_SOC_AMD_{LEGACY_MACH,SOF_MACH} should depend on
    X86 && PCI && I2C
  ASoC: amd: acp: SND_SOC_AMD_ACP_COMMON should depend on X86 && PCI

 sound/soc/amd/acp/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
