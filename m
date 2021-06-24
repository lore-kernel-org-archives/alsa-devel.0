Return-Path: <SRS0=UF41=LS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DD2C49EA5
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Jun 2021 21:22:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E84A6008E
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Jun 2021 21:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E84A6008E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0563E828;
	Thu, 24 Jun 2021 23:22:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0563E828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624569774;
	bh=MwO9BW7F8u85dyg2TGOKlZ7UI2TnjRUjqM503pSN/24=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pnQsE9ec2ywyqz4BzR5EGxe3trqWy+kE606FokldWeyCRX1EDMvsuUqw/L7+KYc0A
	 ONukxc7946QDw/wDDLTYb2cTEr/QLmIdGoxdLcOtHllr1Wy+nprcZcetdyIorLGRe6
	 OR+7NoKN1qcbSaaLBHMlDQ/Rr/cqXSARF5RkpDaE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 83070F801F7;
	Thu, 24 Jun 2021 23:22:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6196DF8025F; Thu, 24 Jun 2021 23:22:01 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 03256F80137
 for <alsa-devel@alsa-project.org>; Thu, 24 Jun 2021 23:21:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 03256F80137
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="iLKW7DKE"
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9BE26124C;
 Thu, 24 Jun 2021 21:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624569715;
 bh=MwO9BW7F8u85dyg2TGOKlZ7UI2TnjRUjqM503pSN/24=;
 h=From:To:Cc:Subject:Date:From;
 b=iLKW7DKEl64x9Qf5HTpK0uOhrMreIq66X1U0KB1JW5RidFei/4dBZDlUgPODgLyCv
 yuAu85JVo+Lj8EvJFKYegTScQaTVnNwDGYjP4V4k8Wj1lgRmQYyliDlU34iucl9TEw
 4LhLZi0/lDh4JpKSX6k71QTt+s58rsNj623KCUfhuyvmDGc2auEMfk8DaiDAalEVav
 Hj3EjnhsmGiFkhhOmnVjgDH2NHtAJxLzaegeZNHuuxXEn1GF4itnXQAksVgnfePILf
 UiP4LmGXYALrcd6akuhhQWxbd9Fey9WX9f2w5TDC2c88z/1bJo4eDJ0rtGO1+Uas9M
 ac7xjlOKQ2oxg==
From: Nathan Chancellor <nathan@kernel.org>
To: "Geoffrey D. Bennett" <g@b4.vu>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] ALSA: usb-audio: scarlett2: Fix for loop increment in
 scarlett2_usb_get_config
Date: Thu, 24 Jun 2021 14:20:48 -0700
Message-Id: <20210624212048.1356136-1-nathan@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Cc: Nathan Chancellor <nathan@kernel.org>, clang-built-linux@googlegroups.com,
 alsa-devel@alsa-project.org, Nick Desaulniers <ndesaulniers@google.com>,
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

Clang warns:

sound/usb/mixer_scarlett_gen2.c:1189:32: warning: expression result
unused [-Wunused-value]
                        for (i = 0; i < count; i++, (u16 *)buf++)
                                                    ^      ~~~~~
1 warning generated.

It appears the intention was to cast the void pointer to a u16 pointer
so that the data could be iterated through like an array of u16 values.
However, the cast happens after the increment because a cast is an
rvalue, whereas the post-increment operator only works on lvalues, so
the loop does not iterate as expected.

Replace the post-increment shorthand with the full expression so the
cast can be added in the right place and the look works as expected.

Fixes: ac34df733d2d ("ALSA: usb-audio: scarlett2: Update get_config to do endian conversion")
Link: https://github.com/ClangBuiltLinux/linux/issues/1408
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 sound/usb/mixer_scarlett_gen2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index fcba682cd422..c20c7f1ddc50 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -1186,7 +1186,7 @@ static int scarlett2_usb_get_config(
 		if (err < 0)
 			return err;
 		if (size == 2)
-			for (i = 0; i < count; i++, (u16 *)buf++)
+			for (i = 0; i < count; i++, buf = (u16 *)buf + 1)
 				*(u16 *)buf = le16_to_cpu(*(__le16 *)buf);
 		return 0;
 	}

base-commit: 5c89c2c7fbfa9124dd521c375b9c82b9ed75bc28
-- 
2.32.0.93.g670b81a890

