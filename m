Return-Path: <SRS0=FXXq=MY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64215C4338F
	for <alsa-devel@archiver.kernel.org>; Sun,  1 Aug 2021 06:41:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D945761058
	for <alsa-devel@archiver.kernel.org>; Sun,  1 Aug 2021 06:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D945761058
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4E8B217DA;
	Sun,  1 Aug 2021 08:40:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4E8B217DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627800092;
	bh=v0Bj99EamD/mc9O22hG/EOac70ewywOmAGAK5QKyKbU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=J2H1YiuqP71wFRGPRd+DgFzpnV7Be/vdaZE96qUqQLfILuSYBZX/2a8iSPwKAD/Yh
	 ngsjlPNoaVGYIZ0TKEoawa6CuxW4XOfo6SqmEYf20BSBf0fzN11gPp/eBAyDPCljFj
	 Tk7pl4C9IVuAybyA4uygQQ7B2gejnGJSammi/TAw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DDA76F8016D;
	Sun,  1 Aug 2021 08:40:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 34044F802E8; Sun,  1 Aug 2021 08:40:40 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C00E2F8012E
 for <alsa-devel@alsa-project.org>; Sun,  1 Aug 2021 08:40:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C00E2F8012E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com
 header.b="XDtnfw8g"
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id F308F3F09E; 
 Sun,  1 Aug 2021 06:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1627800024;
 bh=Pj0slGC1ljlR96lXk8aWILLc/beGdmbsTdYuPg9E7Ro=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
 b=XDtnfw8guEmwENieLo8WJB7SXykC4QoMYCW5cwOZmQoQFwhGQdWyabDjRNqi46o3E
 1orrWS7KTaJxL3eOjDSHiFakKrwznHrS0GBNKWJkSRr5kjM29Y/SEskcqpoUqVpA7n
 qKKtjEcO08kgWUbC5a95wXflv7WXjYByNANiSzcN+6EQM/gCzSzAQgOWhpxjJz0BtI
 zcWpkAvO9LvaXJOT+LF057+wbxnWVn7g0qxZd/PX9p3EIl1h8khaNZzbzZ6hUQoILc
 AttIooFo8K5Cx3IDkk/uBYTBe2SuiKEkP8tIBIeMJeTFQw08VrdXitF42p24yaztzM
 1dAHqjUkXyPVA==
From: Colin King <colin.king@canonical.com>
To: Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: rt5514: make array div static const,
 makes object smaller
Date: Sun,  1 Aug 2021 07:40:23 +0100
Message-Id: <20210801064023.138359-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

From: Colin Ian King <colin.king@canonical.com>

Don't populate the array div on the stack but instead it
static const. Makes the object code smaller by 48 bytes.

Before:
   text    data     bss     dec     hex filename
  53894   16368     128   70390   112f6 ./sound/soc/codecs/rt5514.o

After:
   text    data     bss     dec     hex filename
  53750   16464     128   70342   112c6 ./sound/soc/codecs/rt5514.o

(gcc version 10.2.0)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/rt5514.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index 7081142a355e..4b1ad5054e8d 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -494,7 +494,7 @@ static const struct snd_kcontrol_new rt5514_sto2_dmic_mux =
  */
 static int rt5514_calc_dmic_clk(struct snd_soc_component *component, int rate)
 {
-	int div[] = {2, 3, 4, 8, 12, 16, 24, 32};
+	static const int div[] = {2, 3, 4, 8, 12, 16, 24, 32};
 	int i;
 
 	if (rate < 1000000 * div[0]) {
-- 
2.31.1

