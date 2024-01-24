Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3824C46CD2
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jan 2024 07:47:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 141BB210;
	Wed, 24 Jan 2024 08:46:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 141BB210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1706082428;
	bh=sVXlhCINy91jWhZ6PsZ+NZ5hY4jMsVzvytP/1xoTcWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=psgMy9J0YBXCq4MX6nmTmiOfybLzdP/Hm21yYHQhF9xnaiA+5P8kpMHSyCZyxqMiP
	 usPkkf55+S/3gRFsR6U7t/TdlerybOPR7LDXzPZIIjTlRtT3XbRnFzHCHIU+wp+bd0
	 NWwobHNNDe658fna/CojLGKvVMlXK/4wq28rDzbg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A3A77F805D7; Wed, 24 Jan 2024 08:46:07 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 026F9F805F6;
	Wed, 24 Jan 2024 08:46:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 83F61F80494; Wed, 24 Jan 2024 08:45:53 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 20656F8025F
	for <alsa-devel@alsa-project.org>; Wed, 24 Jan 2024 08:45:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 20656F8025F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=WmJBqhoa
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-559f92bf7b6so9333008a12.0
        for <alsa-devel@alsa-project.org>;
 Tue, 23 Jan 2024 23:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706082336; x=1706687136;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Twb14CHQV4rxLJEwyOADsP4YgaAe6VIG5jHjsjkoYM=;
        b=WmJBqhoaw99QEmqt8cy+rHvCYIPQQaSgD+mm95ld/F2Xi3VZe6CQk+YUk1IRM9hTb4
         ueaJcXzEh3ahxylWZBeCqSVpQBTMZSGaNvERHUZTyhJM1YPpV1Zy13At9GeMQy7y+gKn
         KWbZLDuRp8wKM2X0/ZBtA8QTVn8MK6vZ7IAMAJTGzYSqEuhmFDkcM0hj8OQ4lJeCURAZ
         ZRIPnhn2MJJV4b22uwQs/6slCWWlYmgbTCxfNXNeUF0wVsyO7k/mSVaN760YePawcL7C
         m1juoKqAcT9MIxNBqbf+PK+GiXPenZA3gSubfORvHYEA4dGL5seNki8ftNF5oCMJkBhu
         7tYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706082336; x=1706687136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Twb14CHQV4rxLJEwyOADsP4YgaAe6VIG5jHjsjkoYM=;
        b=ICb+T/z9YUQBmCZ0o36+yhYw35+MFsBZONSXiDDoi3nLSPB/xcvuscqIP/bFaPlPzL
         3vKSvCWvrkNup42TSf4gjAuQQmuCPXqbJz2aLGAEb/7raOB4Ek6EP5Bje89ymgi6A6fS
         iY/6ZdXfNusWaeK9TpU0bQyCAw5RcR/Eno7I7JCgwu6jCtGtQaKlxp5iFLnJqyd4wKQo
         nTtkvoECqS7lOGEm73Bwr3G2ThsSLXUt6GYFl13eTqYV686xYkPUzJXMIBJ+BUOJuBBS
         IoycbfH3KKclqUa7T+jbEjwUWtY1nD/GbJXJL/X2/XnguT1nH9qZe7BM35eo9wFJp20q
         8B/A==
X-Gm-Message-State: AOJu0YycFTtpH13n6JUS2xSq86aSoFD2nAtwKk7pA5Rjw8YIoeTavR8Y
	6fwqPiQ7Q1Eh/9wjT1DbpkTMgFXbZ4FmjXK8sHuoABIWgDYViJ5rYN4Zqu5Cmh4=
X-Google-Smtp-Source: 
 AGHT+IEd7wCKPo8WkTbk0u737H/8Ow4jEXZBmtDW8b4VUySFuKLyGUxPBx1MuSzXlKRiapm7MvRwSg==
X-Received: by 2002:a05:6402:34c5:b0:55c:972e:3e97 with SMTP id
 w5-20020a05640234c500b0055c972e3e97mr1149526edc.3.1706082336269;
        Tue, 23 Jan 2024 23:45:36 -0800 (PST)
Received: from krzk-bin.. ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id
 c4-20020a056402100400b0055c8a30152bsm1306951edu.83.2024.01.23.23.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 23:45:35 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 2/6] cpufreq: do not open-code of_phandle_args_equal()
Date: Wed, 24 Jan 2024 08:45:23 +0100
Message-Id: <20240124074527.48869-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124074527.48869-1-krzysztof.kozlowski@linaro.org>
References: <20240124074527.48869-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 7BQH3ENWTYVMFA45WGU2TSECYQDNYDJX
X-Message-ID-Hash: 7BQH3ENWTYVMFA45WGU2TSECYQDNYDJX
X-MailFrom: krzysztof.kozlowski@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7BQH3ENWTYVMFA45WGU2TSECYQDNYDJX/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Use newly added of_phandle_args_equal() helper to compare two
of_phandle_args.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Depends on previous of change.
---
 include/linux/cpufreq.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index afda5f24d3dd..3cd06dafb04b 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1149,8 +1149,7 @@ static inline int of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_
 		if (ret < 0)
 			continue;
 
-		if (pargs->np == args.np && pargs->args_count == args.args_count &&
-		    !memcmp(pargs->args, args.args, sizeof(args.args[0]) * args.args_count))
+		if (of_phandle_args_equal(pargs, &args))
 			cpumask_set_cpu(cpu, cpumask);
 
 		of_node_put(args.np);
-- 
2.34.1

