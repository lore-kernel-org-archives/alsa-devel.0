Return-Path: <SRS0=LJxm=YT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB8DCA9EB9
	for <alsa-devel@archiver.kernel.org>; Sat, 26 Oct 2019 20:08:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68BF4214DA
	for <alsa-devel@archiver.kernel.org>; Sat, 26 Oct 2019 20:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Y/bufzER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68BF4214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 24EAC18D3;
	Sat, 26 Oct 2019 22:07:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 24EAC18D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572120508;
	bh=gxDWjQusrh4qW5jpLFhyJvh3JqexuLNkTL5yq+Ih2Hg=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Y/bufzER5UCsqVz/tSLzJoiwN3QRV701QXek+6P6WlWm6y5UP23sO1qsMVSwSM/IJ
	 9FFI7vMCuLgcVsuUG3PXJnGtTIUyyHhl3QdXUg3UP/yXmNTG44lpUtqiY9TDFOif5v
	 WajuA1uSOIIGKQeCcrThMirRH/6IiTm5ea8QAIwM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C7C3F800BF;
	Sat, 26 Oct 2019 22:07:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3B32EF80228; Sat, 26 Oct 2019 22:07:14 +0200 (CEST)
Received: from smtp.smtpout.orange.fr (smtp10.smtpout.orange.fr
 [80.12.242.132])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9472EF80367
 for <alsa-devel@alsa-project.org>; Sat, 26 Oct 2019 22:06:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9472EF80367
Received: from belgarion ([90.76.41.223]) by mwinf5d19 with ME
 id JL6B210024otT8A03L6B8P; Sat, 26 Oct 2019 22:06:12 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sat, 26 Oct 2019 22:06:12 +0200
X-ME-IP: 90.76.41.223
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Mark Brown <broonie@kernel.org>,
 Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
 patches@opensource.cirrus.com
X-URL: http://belgarath.falguerolles.org/
Date: Sat, 26 Oct 2019 22:06:10 +0200
Message-ID: <87a79nqnkd.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org
Subject: [alsa-devel] wm9713 regression on pxa platforms
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi Wolfson maintainers, hi Mark,

Recently, the wm9713 support broke on my platforms. I'm pretty sure that a
previous harmless warning became an error preventing the probe of my driver
(sound/soc/pxa/mioa701_wm9713.c) : the error is shown in [1] ("Control not
supported").

The warning "ASoC: no dapm match for Mic B Source" has be there as far as I'm
aware for ages, and it never prevented the probe before.

Now, if I apply the ugly patch in [2], everything works as expected ... but
that's definitely not the right fix.

Would any of you be able to figure out a fix please ?

Cheers.

-- 
Robert

[1] Kernel log
[  129.888985] pxa2xx-ac97 pxa2xx-ac97: ASoC: dai register pxa2xx-ac97 #3
[  129.889052] pxa2xx-ac97 pxa2xx-ac97: ASoC: dynamically register DAI pxa2xx-ac97
[  129.889102] pxa2xx-ac97 pxa2xx-ac97: ASoC: Registered DAI 'pxa2xx-ac97'
[  129.889135] pxa2xx-ac97 pxa2xx-ac97: ASoC: dynamically register DAI pxa2xx-ac97
[  129.889176] pxa2xx-ac97 pxa2xx-ac97: ASoC: Registered DAI 'pxa2xx-ac97-aux'
[  129.889207] pxa2xx-ac97 pxa2xx-ac97: ASoC: dynamically register DAI pxa2xx-ac97
[  129.889249] pxa2xx-ac97 pxa2xx-ac97: ASoC: Registered DAI 'pxa2xx-ac97-mic'
[  135.341942] wm9713-codec wm9713-codec: ASoC: dai register wm9713-codec #3
[  135.342019] wm9713-codec wm9713-codec: ASoC: dynamically register DAI wm9713-codec
[  135.342077] wm9713-codec wm9713-codec: ASoC: Registered DAI 'wm9713-hifi'
[  135.342109] wm9713-codec wm9713-codec: ASoC: dynamically register DAI wm9713-codec
[  135.342162] wm9713-codec wm9713-codec: ASoC: Registered DAI 'wm9713-aux'
[  135.342193] wm9713-codec wm9713-codec: ASoC: dynamically register DAI wm9713-codec
[  135.342234] wm9713-codec wm9713-codec: ASoC: Registered DAI 'wm9713-voice'
[  139.362113] mioa701-wm9713 mioa701-wm9713: ASoC: binding AC97
[  139.362302] mioa701-wm9713 mioa701-wm9713: ASoC: binding AC97 Aux
[  139.367170] wm9713-codec wm9713-codec: Control not supported for path Mic B Source -> [MPB] -> Mic B Pre Amp
[  139.375450] wm9713-codec wm9713-codec: ASoC: no dapm match for Mic B Source --> MPB --> Mic B Pre Amp
[  139.383448] wm9713-codec wm9713-codec: ASoC: Failed to add route Mic B Source -> MPB -> Mic B Pre Amp
[  139.393422] mioa701-wm9713 mioa701-wm9713: ASoC: failed to instantiate card -22
[  139.403089] mioa701-wm9713: probe of mioa701-wm9713 failed with error -22

[2] Ugly test
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 6497c1ea6228..ec140ccbab0b 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -630,8 +630,8 @@ static const struct snd_soc_dapm_route wm9713_audio_map[] = {
        {"Mic A Source", "Mic 1", "MIC1"},
        {"Mic A Source", "Mic 2 A", "MIC2A"},
        {"Mic A Source", "Mic 2 B", "Mic B Source"},
-       {"Mic B Pre Amp", "MPB", "Mic B Source"},
-       {"Mic B Source", NULL, "MIC2B"},
+       /* {"Mic B Pre Amp", "MPB", "Mic B Source"}, */
+       /* {"Mic B Source", NULL, "MIC2B"}, */
 
        /* headphone capture */
        {"Capture Headphone Mux", "Stereo", "Capture Mixer"},
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
