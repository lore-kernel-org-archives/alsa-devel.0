Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5AB5ECAAD1
	for <alsa-devel@archiver.kernel.org>; Wed, 31 Aug 2022 17:50:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3EB4E16DD;
	Wed, 31 Aug 2022 19:50:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3EB4E16DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661968254;
	bh=r6UjoSxXx+DGHcbrgE5IOX1kXKRXnvGJxIkIyS3WLng=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FHVkV2Mm5jXyshS6OXjy9neKfgEuHOqtSb47wI3AQBpP3e0bqJdBWfWDYDImFqwxa
	 JAT1IWq4e4ZhI6Dt4uwjRUaL18L6S9z3FFBCYZJ90MBEZOnGprhlAIv1KcjnocxUHc
	 zexBdLvntGegpJ5z8CUGAeXOwQ/QRZnjRFq/Jd0Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CAAC5F80236;
	Wed, 31 Aug 2022 19:50:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 06842F800AA; Wed, 31 Aug 2022 19:50:01 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id DBF97F8012A
 for <alsa-devel@alsa-project.org>; Wed, 31 Aug 2022 19:49:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DBF97F8012A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1661968198098938942-webhooks-bot@alsa-project.org>
References: <1661968198098938942-webhooks-bot@alsa-project.org>
Subject: Support MSI MPG Z690 EDGE WIFI DDR4 (ALC4080)
Message-Id: <20220831175002.06842F800AA@alsa1.perex.cz>
Date: Wed, 31 Aug 2022 19:50:01 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #210 was opened from tekstryder:

Per @perexg request, filing a new issue after testing git master branch changes for the ALC4080 and finding any profile(s) to be missing/nonfunctional.   

USB ID: `0db0:1feb`   

In version 1.2.7.2 of .../ucm2/USB-Audio/Realtek/ALC4080-HiFi.conf I need to change:

- Define.SPDIFIndex "3" to Define.SPDIFIndex "Define.SPDIFIndex "2""

For proper playback via S/PDIF. After that change the release version is working great as far as I could test.

Please let me know if I can provide any other useful information.

Attaching the output of `alsaucm -c hw:2 dump text`   
Attaching the output of `pactl list sinks`

[ucm-dump.txt](https://github.com/alsa-project/alsa-ucm-conf/files/9463734/ucm-dump.txt)

[sinks.txt](https://github.com/alsa-project/alsa-ucm-conf/files/9463784/sinks.txt)

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/210
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
