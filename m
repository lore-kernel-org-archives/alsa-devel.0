Return-Path: <SRS0=sDoq=M5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5123C4338F
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Aug 2021 22:43:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB81261184
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Aug 2021 22:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BB81261184
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4656B16CB;
	Sat,  7 Aug 2021 00:42:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4656B16CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628289782;
	bh=Zx1Yj4ucnS33KRgDk+UjZH0DAgNrHWdjqumj+kIKIbE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yr54+2Wqbhj91+T+2AoIzgh48KqRqB7+0xyZEIG5mOBQKtzYxc3OMSzPvYopX1quu
	 tGIZ+hifnqkJc8Bbdwym0TZvnJIK+t3UlItww5ij0E7UP1LSfimLpjae8YVJUqCwZe
	 /gdMxo2B1+XLEY9vlSfZ2cV/cJGxcOHEDU9sukZ0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D3E3EF80108;
	Sat,  7 Aug 2021 00:42:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 66D74F8025F; Sat,  7 Aug 2021 00:42:10 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id DC336F80108
 for <alsa-devel@alsa-project.org>; Sat,  7 Aug 2021 00:42:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC336F80108
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1628289724952759027-webhooks-bot@alsa-project.org>
References: <1628289724952759027-webhooks-bot@alsa-project.org>
Subject: UCM SectionModifier doesn't like 'Comment'
Message-Id: <20210806224210.66D74F8025F@alsa1.perex.cz>
Date: Sat,  7 Aug 2021 00:42:10 +0200 (CEST)
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

alsa-project/alsa-lib issue #167 was opened from plbossart:

Adding the following patch generates a crash with alsaucm

````
alsaucm -c sof-soundwire set _verb HiFi set _enadev Headphones
alsaucm: conf.c:4355: snd_config_iterator_first: Assertion `config->type == SND_CONFIG_TYPE_COMPOUND' failed.
Aborted (core dumped)
````

````diff
diff --git a/ucm2/sof-soundwire/HiFi.conf b/ucm2/sof-soundwire/HiFi.conf
index e780ea4..fbadb65 100644
--- a/ucm2/sof-soundwire/HiFi.conf
+++ b/ucm2/sof-soundwire/HiFi.conf
@@ -29,3 +29,12 @@ If.hsdev {
 }
 
 <sof-soundwire/Hdmi.conf>
+
+SectionModifier."PlayMusic" {
+       # this works fine
+}
+
+SectionModifier."PlayRadio" {
+       # this doesn't
+       Comment "Play Radio"
+}

I am not sure if anyone ever used the SectionModifier, if it's a bug in alsa-lib or alsaucm.

SectionModifiers are part of the current proposal in PipeWire according to the documentation for "stream endpoints". https://docs.pipewire.org/page_objects_design.html 

"The available UCM modifiers for each UCM device will be added as streams, plus one "default" stream for accessing the device with no modifiers."

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/167
Repository URL: https://github.com/alsa-project/alsa-lib
