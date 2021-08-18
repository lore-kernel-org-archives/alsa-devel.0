Return-Path: <SRS0=kMQ4=NJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32FDC4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 01:28:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 440D661029
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 01:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 440D661029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 538291679;
	Wed, 18 Aug 2021 03:27:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 538291679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629250129;
	bh=J339FJDjO6ozWy303tefLXzSQOWCQo4VyW6f5odI+Ik=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rai+W500zt+hhQKoSznmcfb2aZdNgKkYhVGVDXFXv0xJRUpZnmRMpQ3VlR9hJN8jz
	 4UZtxBAbCCqoXQpYRFigiA4yZsBOC8UIF6jXg6JCy0O9Jj7aPFGkUPgKEjKeGsehsH
	 pjjXosQ81zlD51ggH8rk4Wr52PfGQLYkW4CEqb94=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 245E8F802BE;
	Wed, 18 Aug 2021 03:27:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 36C61F8028D; Wed, 18 Aug 2021 03:27:25 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9FE5DF80246
 for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2021 03:27:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9FE5DF80246
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="dZNMRW0d"
Received: by mail.kernel.org (Postfix) with ESMTPSA id B155E601FD;
 Wed, 18 Aug 2021 01:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629250038;
 bh=J339FJDjO6ozWy303tefLXzSQOWCQo4VyW6f5odI+Ik=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dZNMRW0dU7sN3icQ8C0o6MSpwtUgAOiZUHD9yTvjhtrUrJ59qfigEOOc9ZqQDHhzq
 rFJTbRnGuItEla7QiKC7DvNAxukO0VQVfVHwcyaGyJ3Lq+Bc1As4duT48APsb1JR5d
 dpPt1IewyVGMh+NQWOtrdy/VfKBIBT5iv1/zTA7/3ZqNmpOKmSf4Ov3Gq2q3z7/+qB
 vkAFh43nwFu4dni9g3Q532PEzct6HzAYCmBdoKp+GP1QGuYFkjRLA3zt+Y/Vr1Tt/X
 yPT6uDCzLs55x7QCAm5S2n2XubMvHbuQr1OElIRpI4xxtWNMoWl3wzePmwJOGHY8aJ
 KFoblrnK9Q0Mw==
From: Nathan Chancellor <nathan@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 2/2] ALSA: hda/analog - Sink ad198x_shutup() and shuffle
 CONFIG_PM guards
Date: Tue, 17 Aug 2021 18:27:05 -0700
Message-Id: <20210818012705.311963-2-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210818012705.311963-1-nathan@kernel.org>
References: <20210818012705.311963-1-nathan@kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Cc: Nathan Chancellor <nathan@kernel.org>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

When CONFIG_PM is not set, there is an unused function warning:

sound/pci/hda/patch_analog.c:115:13: warning: unused function
'ad198x_shutup' [-Wunused-function]
static void ad198x_shutup(struct hda_codec *codec)
            ^
1 warning generated.

Sink ad198x_shutup() into ad198x_suspend(), as it is only called in that
one space. Move the CONFIG_PM guards above ad198x_power_eapd_write() as
it is only called in ad198x_power_eapd(), which is in turn only called
in ad198x_power_eapd(). Those two functions are large enough that they
are left alone.

Fixes: 327b34f2a97d ("ALSA: hda: Nuke unused reboot_notify callback")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 sound/pci/hda/patch_analog.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index a356e1662929..8afe6000f7da 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -72,7 +72,7 @@ static int create_beep_ctls(struct hda_codec *codec)
 #define create_beep_ctls(codec)		0
 #endif
 
-
+#ifdef CONFIG_PM
 static void ad198x_power_eapd_write(struct hda_codec *codec, hda_nid_t front,
 				hda_nid_t hp)
 {
@@ -112,16 +112,10 @@ static void ad198x_power_eapd(struct hda_codec *codec)
 	}
 }
 
-static void ad198x_shutup(struct hda_codec *codec)
+static int ad198x_suspend(struct hda_codec *codec)
 {
 	snd_hda_shutup_pins(codec);
 	ad198x_power_eapd(codec);
-}
-
-#ifdef CONFIG_PM
-static int ad198x_suspend(struct hda_codec *codec)
-{
-	ad198x_shutup(codec);
 	return 0;
 }
 #endif
-- 
2.33.0

