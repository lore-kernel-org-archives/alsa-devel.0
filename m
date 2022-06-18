Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8400EC43334
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Jun 2022 04:08:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CA5951F29;
	Sat, 18 Jun 2022 06:07:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CA5951F29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655525286;
	bh=/XKP5ggzkZriWJ8kHYXROaV58dygK8takFDj9XTNhCY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SCv71309s3IsxXCe2gGQuWHdRNrjv8SciuG9hCUo9nbhIglKLh+ZpoC+DY7uv6msC
	 FiiA7AJau0qDwvPcdd3RA6sVEb0y1Pb/Am/3yA1f+4dkSkmsf/ZLd/XUWU7sB7NB4F
	 UnYpNgji7ki/dG3cysNcfUUdTFAKylGKE1kepQ/o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5F18BF8026A;
	Sat, 18 Jun 2022 06:07:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3BA1DF8026D; Sat, 18 Jun 2022 06:07:15 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id A860BF800C7
 for <alsa-devel@alsa-project.org>; Sat, 18 Jun 2022 06:07:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A860BF800C7
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1655525231867194891-webhooks-bot@alsa-project.org>
References: <1655525231867194891-webhooks-bot@alsa-project.org>
Subject: MPG X570S EDGE MAX WIFI compatibility
Message-Id: <20220618040715.3BA1DF8026D@alsa1.perex.cz>
Date: Sat, 18 Jun 2022 06:07:15 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #172 was opened from yhojann-cl:

Please, add `0db0:151f` to `realtek-alc4080` chip compatibility in MPG X570S EDGE MAX WIFI motherboard:

In `ucm2/USB-Audio/USB-Audio.conf` add `151f` to regex of `0db0`:

```
Regex "USB((0b05:(1996|1a2[07]))|(0db0:(1feb|419c|a073|151f)))"
```

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/172
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
