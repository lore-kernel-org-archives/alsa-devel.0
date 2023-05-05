Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926A9C77B7C
	for <alsa-devel@archiver.kernel.org>; Fri,  5 May 2023 16:56:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7B2302D55;
	Fri,  5 May 2023 18:56:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7B2302D55
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683305811;
	bh=58UbliZMFAdIAv4ur/aEs1B/lfMbw2b6p148XibTlUw=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Bgxi18WI1rEjSscMtLZR7g3TbYww2eF9Oo8K33ArS8nURB8h+/ewdnMeC2Da2vQeW
	 HePFD4wDHTaYXHVWHEj+hR8d28XxKYUS9Vq4Y1Af2Z2o/pvWQfqIa6LIOM5PbSZcXZ
	 lBx57WYlznU84lM98LEsQqFeCKM/wGI7+maj2vQQ=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EEE29F804B1;
	Fri,  5 May 2023 18:55:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 040CDF80534; Fri,  5 May 2023 18:55:32 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5AB9AF804B1
	for <alsa-devel@alsa-project.org>; Fri,  5 May 2023 18:55:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5AB9AF804B1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=X4cFhQpe
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-2fddb442d47so1861086f8f.2
        for <alsa-devel@alsa-project.org>;
 Fri, 05 May 2023 09:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683305725; x=1685897725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L3GpvKdXnUbv3/06jF20p2wjzRq6DzJPnthy2LMuYWA=;
        b=X4cFhQpexPgpiVzeKDoIVe1f5KH9FnPWl+bvlAJbfLZrhyLSpwgP/sU1IJ1i25x/YD
         C1vySuirB2jOIt0kNuzjHYK20WAhit8JcVgzBt4ZIjjjMDM++PnXb+5BClRWY608yImG
         hgCiP2UgDHpaN89G0zTTmnymOMZOuA9jap6sfndvqXHI5t7wwy0Fo9wXX3mpK7pvYeVk
         s5JwSSsK8R4APt/fcKnlnee51w5MRyQ4P6P7e5s9KD95q2VmV5GTvuUtlYAjK2jmc0Y1
         jWaYn0HfhjOsxKFfE35gP9i2OZfGjW8stUxYp03FJc7EyS7Qfbz9/KU7LIAaeuBomF+/
         QtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683305725; x=1685897725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L3GpvKdXnUbv3/06jF20p2wjzRq6DzJPnthy2LMuYWA=;
        b=ZcHSW2gWAD5dZ7rGi71t5/RcYzCV/PVGvtTsTg6j3XyYXSr3wLBL32frWO+NG+8vSL
         fjZYBDLb4ljycG/cPlKigybz43qZUZuB4M78DCZ2ezcOkyMplVVpbkAVqEXOUazA0zsu
         hITQyWJwzAeNiNYWn9m1O4j5oxF4Ms3aSc9//xm0cRopdaKa2bXRgeZV9u2X61sWkZbQ
         cHAdAsF7Q9ZK9hFbnLVHDxk0flRKkoci+ENeU30kem1nWd1oPhq2jQfSV/jATgeG/lC/
         3wKBPkrPWUt/YCaVTtJCKhF/Vx4Sdl7OGYlvtwRNVpAIOdbOONvJdlSInKK7oQtBybY4
         wXKA==
X-Gm-Message-State: AC+VfDxqRZt2etsdoWbUc3z7T15RSRaIGa19obDVjBk0APdNqnYytq4Z
	Fw5PwCLpphwa51q1SfCcIdy5Vg==
X-Google-Smtp-Source: 
 ACHHUZ7N80D7cGL6BaynTO6FiJRBZXlGZ68zRgHBLAxYl02IPxyDf8TRFR88tz+iZNTUnCjuMiziyQ==
X-Received: by 2002:adf:e9cc:0:b0:306:45c0:f070 with SMTP id
 l12-20020adfe9cc000000b0030645c0f070mr1675588wrn.39.1683305725414;
        Fri, 05 May 2023 09:55:25 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id
 x7-20020adfffc7000000b002c7066a6f77sm2923551wrs.31.2023.05.05.09.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 09:55:24 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org,
	tiwai@suse.com
Subject: [PATCH 0/3] ASoC: hdmi-codec: add component name prefix to controls
Date: Fri,  5 May 2023 17:55:11 +0100
Message-Id: <20230505165514.4666-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: GSXRMG5HBBTUPSWGGIJ72O2A5IF75AZR
X-Message-ID-Hash: GSXRMG5HBBTUPSWGGIJ72O2A5IF75AZR
X-MailFrom: srinivas.kandagatla@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: lgirdwood@gmail.com, ckeepax@opensource.cirrus.com,
 kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
 pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GSXRMG5HBBTUPSWGGIJ72O2A5IF75AZR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

While adding audio support to two instances of Display port on x13s,
hdmi-codec failed to add controls as two codec instances were trying
to add controls with same name.
    
snd-sc8280xp sound: control 3:16:0:IEC958 Playback Mask:0 is already present
snd-sc8280xp sound: control 3:16:0:Playback Channel Map:0 is already present
hdmi-audio-codec hdmi-audio-codec.4.auto: ASoC: error at snd_soc_pcm_dai_new on i2s-hifi: -16

To fix this issue, I have added a new api snd_pcm_add_chmap_ctls_with_prefix()
to allow to pass asoc component name prefix, which should provide a unique control
names. We can also make snd_pcm_add_chmap_ctls() take prefix argument to do the same
this.

Srinivas Kandagatla (3):
  ALSA: pcm: add snd_pcm_add_chmap_ctls_with_prefix
  ASoC: hdmi-codec: use snd_pcm_add_chmap_ctls_with_prefix to add
    controls
  ASoC: hdmi-codec: use snd_soc_cnew to add controls

 include/sound/pcm.h           |  7 +++++++
 sound/core/pcm_lib.c          | 30 ++++++++++++++++++++++++++++--
 sound/soc/codecs/hdmi-codec.c | 10 ++++++----
 3 files changed, 41 insertions(+), 6 deletions(-)

-- 
2.21.0

