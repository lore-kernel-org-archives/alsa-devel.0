Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF62C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Feb 2022 18:33:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F1A3717FD;
	Tue, 22 Feb 2022 19:33:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F1A3717FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645554834;
	bh=RpWlKNOwPHlxpsYAxBpNzO9IFCHBn5+Nyua268QRLEY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=A0CMZFlGqL5doPL3IG/l8sfCGz8ZxrfLGvjszNQVP1qNlngG5N9KNjYnJqGGlay82
	 y7WxIFYK7Ftw8Ppwz0MiaRZmiXwLbAVHiLCGwlls7clbi/YDooumgzY1FsL1bVI1C+
	 8KSguA+4kM7Ek+1skSNseiZzjq+6sODcNXhF+ONI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A5FDBF80508;
	Tue, 22 Feb 2022 19:32:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DC87BF801F5; Tue, 22 Feb 2022 19:32:32 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 69A38F800D1
 for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2022 19:32:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 69A38F800D1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="YbYnrovB"
Received: by mail-wr1-x42d.google.com with SMTP id j22so9004979wrb.13
 for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2022 10:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KIDuRiJHhzu2vEL6lRXNUGBwsDBGA5IDZz729oGpCe4=;
 b=YbYnrovBwpePB9FhMDqBVWz7PyzYr8s6ua9/B8Yw/lpYx+pwvC7oEuL5eyuE08oDrO
 KeJfM+UhAV9xZBYWdyBOWU1BKWn3y/V0caEF784MTsrSHXrSj5GKtN+EwsbYrPYNgF2k
 BunN9JfH8JRswjyeCfZzwJrWlehi5zccMJEvmcpZUJh+KJrDjiaPEyU89f1Y1vX26mpm
 MRDTENWVtY/LeW8/KtXDYmIyeIgCmvFC8FpeoM9yIbLo7ugLTvExJ2Vi+5ub25C9KXdd
 PXuG2Ulnex/B2BIKMN0q7nZ72x7pLdCxX1EkDdb+idiwvN/kiWJI/k1Cbva9h6gbaiNA
 ardg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KIDuRiJHhzu2vEL6lRXNUGBwsDBGA5IDZz729oGpCe4=;
 b=79E/hPAp6z4G77W85D32Sp8tqAfNiMaCUHsWX2xPqjrlHNqK2p/rq2n5NCy4UN1jqZ
 NrTPVRHB5A/JiiNO5FNkBpgI3Rfda99pWAE55mhETrHJR325pqHpWZGVZhNlIF7AWxI/
 mipfor6+RcjxeIvIC2I3fOI6W9haZiIYT13NeV1sqbb4kRLqGnwjb1RtsI8hHvxh6eqP
 RJpF/Zfni1s5GoDkzXagMiz4BaqcmOyWcStxbOubkecYb+N5N+7NvHyCjdl+nXzNtbDO
 k9UjRh4AO+bzELPbufn8L9EoX5UA+I9c8gPZaq4X0KGHmX2o+qWn8t2UrEe2sivqx1Cj
 q+2Q==
X-Gm-Message-State: AOAM533wGmlo+fQjotWzTT51izHI+H8vwzwzkhZricH6unYqcxUx0tr2
 ORY+FPokE2VnPOPMmOEMJGfzzg==
X-Google-Smtp-Source: ABdhPJxCRvDS9UvQCjHG+xri8F/RlHkBPqMcAYkGokPlRbr1aqZABFwt7RTpdvgkEN2wmKizE8Np7g==
X-Received: by 2002:a05:6000:1684:b0:1ea:8afa:af73 with SMTP id
 y4-20020a056000168400b001ea8afaaf73mr3506799wrd.489.1645554746209; 
 Tue, 22 Feb 2022 10:32:26 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
 by smtp.gmail.com with ESMTPSA id l28sm57642165wrz.90.2022.02.22.10.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Feb 2022 10:32:25 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH v2 0/9] ASoC: codecs: qcom fix validation failures
Date: Tue, 22 Feb 2022 18:32:03 +0000
Message-Id: <20220222183212.11580-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 tiwai@suse.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 quic_srivasam@quicinc.com
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

Thanks for pointing out to mixer kselftest and VALIDATION Kconfig.

This patchset addresses some of the issues in Qualcomm codecs that are
discovered with recent mixer kselftest and validations added to ASoC.

Mostly these are under
1. accessing integer value type for enum controls, which is clearly an array out of bounds access.
2. Fix incorrect ranges.
3. Fix return values for put functions.

Changes since v1:
- removed tlv min max patches as "9bdd10d57a ("ASoC: ops:
Shift tested values in snd_soc_put_volsw() by +min")" fixed the issue in core.
- added checks in wcd934x_rx_hph_mode_put before returning

thanks,
srini

Srinivas Kandagatla (9):
  ASoC: codecs: rx-macro: fix accessing compander for aux
  ASoC: codecs: rx-macro: fix accessing array out of bounds for enum
    type
  ASoC: codecs: tx-macro: fix accessing array out of bounds for enum
    type
  ASoC: codecs: va-macro: fix accessing array out of bounds for enum
    type
  ASoC: codecs: wsa-macro: fix accessing array out of bounds for enum
    type
  ASoC: codecs: wc938x: fix accessing array out of bounds for enum type
  ASoC: codecs: wcd938x: fix kcontrol max values
  ASoC: codecs: wcd934x: fix kcontrol max values
  ASoC: codecs: wcd934x: fix return value of wcd934x_rx_hph_mode_put

 sound/soc/codecs/lpass-rx-macro.c  | 12 ++++++++----
 sound/soc/codecs/lpass-tx-macro.c  |  8 ++++----
 sound/soc/codecs/lpass-va-macro.c  |  4 ++--
 sound/soc/codecs/lpass-wsa-macro.c | 10 +++++-----
 sound/soc/codecs/wcd934x.c         | 11 +++++++----
 sound/soc/codecs/wcd938x.c         | 10 +++++-----
 6 files changed, 31 insertions(+), 24 deletions(-)

-- 
2.21.0

