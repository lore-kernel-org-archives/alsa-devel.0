Return-Path: <SRS0=jvLf=3G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A7AC33CB3
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jan 2020 07:39:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E026A20728
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jan 2020 07:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="a27XKmyn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="VlrJydAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E026A20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3391417CE;
	Fri, 17 Jan 2020 08:38:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3391417CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579246762;
	bh=ixkJ6lomPQuEkFuu6C57EvUDcgvZfB8r04GHQXJyX7c=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=a27XKmynfzaRcJrkRnGfFDxz+UYFOxoXLc9ZnTSXUvvSWfitcg+vlxSPYiCLgjpKP
	 W/KRZNR734bu126mktloqAMm/klEGQKm6MFHi1l5u0DWvWBkONFMveyZE8uxOxLpWy
	 yBmMT/OxXZ8K8MstBeTYXjrQyNzqpRH/0wsxFilA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 88194F8014B;
	Fri, 17 Jan 2020 08:38:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 83BC2F801EB; Fri, 17 Jan 2020 08:38:29 +0100 (CET)
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com
 [IPv6:2607:f8b0:4864:20::74a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D8DC2F800AA
 for <alsa-devel@alsa-project.org>; Fri, 17 Jan 2020 08:38:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D8DC2F800AA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="VlrJydAY"
Received: by mail-qk1-x74a.google.com with SMTP id 12so14732068qkf.20
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2020 23:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=QLdmFWl7ourRbD0I0O6UaqLsRSQfyD9tTHwZc1HAMIo=;
 b=VlrJydAYJnHVc9XLM9LCD647+xzM2Sqnb/81bdCdtkC79VcjyC8hFRkr03uTlyLgc9
 HYE8d7NA4HjFVyT2HRSX8F3L2CTQwNpUyKc6nfJbQ6V3mExpM2C6+sgnhW/1c5ixy9oi
 oMVNvGnitINURWdYIkSIomxyVM9e6zXeSTrZgMXECyznfBsOh6yQxotIthP2qT1gRq3T
 M1AwA9b/VL2ECfcMG9MQfHod5myKTqr55kFg2foW7H3fK8noHhiTPQXOaOJD+Y06SGM6
 Gp13xp49c2q3Wd/5q/Q7rSaxCvUrZu+LTR1riH8WuHFZRhHzxUHkc0AN3Xt3iuwvTPKX
 Fs9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=QLdmFWl7ourRbD0I0O6UaqLsRSQfyD9tTHwZc1HAMIo=;
 b=row5N2KdATxZ9jQx4nj34Z8268iAL9pkfMlV8R5eBwzs5miy08xNfgD1Aya5k9X/cv
 15yCF5pddvFKkpoJoLSdo/k92POGa1P03pZkQdnlWv7/umZY9Yhd4UtvSV57f47OKjc+
 xidvfQsgk01wKCL9TJnejAkpF6AmQP8mlBD4pzGF33W3agbdxBqtC4BiYzvaTG5R77FC
 6Nq4iXWbu/zL/TQUyTdNHHm1idSf2j/U8Iyt8PWOa2Nq1pD8aCehen/TcsDyI0gBmOzd
 Otc9g2rAh8p9PqIGqbNFTalIABJYyZWF5kPUsWCqBv6aySO4jtemudZCDmDjDBhsc0en
 ao9g==
X-Gm-Message-State: APjAAAU/pY+vraUhvcOsMHCrRASbHNEwWH2GnGu71pmq1h0gt1IlFMsD
 z1RQ670HiM7lRaUG9fftYdbxpJMV0zvd
X-Google-Smtp-Source: APXvYqwPpZOX4wJHfVpO/LX+xQ6qKN1N9zPtxLI+m2MqDbr/M9WGuNsfgZrZyrm7OuW7JXejU4a7wmDi5nPZ
X-Received: by 2002:a05:6214:118d:: with SMTP id
 t13mr6297684qvv.5.1579246700559; 
 Thu, 16 Jan 2020 23:38:20 -0800 (PST)
Date: Fri, 17 Jan 2020 15:38:11 +0800
Message-Id: <20200117073814.82441-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org
Cc: tzungbi@google.com, alsa-devel@alsa-project.org, dgreid@google.com,
 cychiang@google.com
Subject: [alsa-devel] [PATCH 0/3] ASoC: max98090: fix lock issues
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

The 1st patch reverts an already merged patch which makes less sense.
(https://mailman.alsa-project.org/pipermail/alsa-devel/2020-January/161172.html)

The 3rd patch uses the function introduced from the 2nd patch to fix
a deadlock issue.  I wasn't aware of the deadlock issue because my
test environment doesn't change the MUX.  Could be manually tested by
something like: `amixer -c1 cset name='LTENL Mux' 0`.

Tzung-Bi Shih (3):
  ASoC: max98090: revert "ASoC: max98090: fix lockdep warning"
  ASoC: dapm: add snd_soc_dapm_put_enum_double_locked
  ASoC: max98090: fix deadlock in max98090_dapm_put_enum_double()

 include/sound/soc-dapm.h    |  2 ++
 sound/soc/codecs/max98090.c | 12 ++++-----
 sound/soc/codecs/max98090.h |  1 -
 sound/soc/soc-dapm.c        | 54 ++++++++++++++++++++++++++++---------
 4 files changed, 48 insertions(+), 21 deletions(-)

-- 
2.25.0.341.g760bfbb309-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
