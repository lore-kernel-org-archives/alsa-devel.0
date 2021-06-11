Return-Path: <SRS0=W3EJ=LF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143F8C48BD1
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Jun 2021 07:33:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7178E61364
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Jun 2021 07:33:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7178E61364
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D9A17186E;
	Fri, 11 Jun 2021 09:32:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D9A17186E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623396806;
	bh=qluACuDz7PYLit6jsSkAahyx2ue0G6DphQScMUuyxl0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NhaJrFG27hlwXT/sh08QGQoFA0mQLiiqSbB8SHimpl2nItmXDjBmUFp+fyfzxH1ks
	 CF+w9dYIlYci8F5xPGLs53pw3xqioGnQt4xtb4+mzkwsuag4hu67567AqXztktIqPy
	 K6VuDBzdTBJJr5BT8md7UXaeU/Tz9sQdI8cRZzwM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 623BEF8027C;
	Fri, 11 Jun 2021 09:31:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9A3F2F8026C; Fri, 11 Jun 2021 09:31:44 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 5118CF80149
 for <alsa-devel@alsa-project.org>; Fri, 11 Jun 2021 09:31:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5118CF80149
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1623396696780062914-webhooks-bot@alsa-project.org>
References: <1623396696780062914-webhooks-bot@alsa-project.org>
Subject: ALSA lib pcm_dmix.c:1063:(snd_pcm_dmix_open) unable to create IPC
 semaphore
Message-Id: <20210611073144.9A3F2F8026C@alsa1.perex.cz>
Date: Fri, 11 Jun 2021 09:31:44 +0200 (CEST)
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

alsa-project/alsa-lib issue #153 was edited from Cean1024:

alsa info:
  alsa-config-1.0    
  alsa-lib-1.1.5
  alsa-plugins-1.1.5
  alsa-utils-1.1.5

asound.conf:

pcm.dmixer {
    type dmix
    ipc_key 1024
    slave {
        pcm "hw:0,0"
        period_time 0
        period_size 1024
        buffer_size 4096
        rate 48000
        format "S32_LE"
        channels 2
    }

    bindings {
        0 0
        1 1
    }
}



test cmd:
arecord -f dat | aplay -f dat -D plug:dmixer

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/153
Repository URL: https://github.com/alsa-project/alsa-lib
