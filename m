Return-Path: <SRS0=04K1=DQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AD5C43457
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:03:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BA97222C3
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PP+xp8yH";
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="Vq999xak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA97222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8324A886;
	Fri,  9 Oct 2020 16:03:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8324A886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602252232;
	bh=MKNjwyg4VijUjfMxsBKWz5gILDji9I5+brStR5dm0ZQ=;
	h=To:From:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PP+xp8yH5Z6GnhvGZL2hGuwVxrp/kKPYehEF0yK1yKeZzfp8XwXC8w5RolUZSw/or
	 va9DQUnA3/3cuNWgymQErLXl5MYZ2C2EsmGp3y7ZrLBemucAwo3Ckg2udUV7BINdzc
	 LsRilUyXrMMwYlFrqK6d55JY6thjueeib8S5JUlc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E640DF80148;
	Fri,  9 Oct 2020 16:03:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 29372F8015B; Fri,  9 Oct 2020 16:03:00 +0200 (CEST)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 465BEF800BF
 for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2020 16:02:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 465BEF800BF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com
 header.b="Vq999xak"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; l=681; q=dns/txt; s=axis-central1;
 t=1602252178; x=1633788178;
 h=to:from:subject:message-id:date:mime-version:
 content-transfer-encoding;
 bh=rVpehVCJCq0KhsueiYzx8wRREMBA7JBHue4tMe0FViQ=;
 b=Vq999xakOZQc8ekqHSZUpIIcNI3oodfXx7sRgEiWMh+wSufLI9nsLR2T
 ymcClQVxZRYBbHpJk6uYmrlVQownk4jPldW7JMPoDCgmLPR8cRxkXGhBY
 EBXgGCxp2tF4y/ryg5toN6JED7wBmryvKRHjdSvSSdZLXjE28xdXw3up6
 oPZmFEWk7Pl1tKT/VOR1tAH97AWj8I5pMlkNX7/UcNhXqWdwWcg346K0E
 dnVZgybON0mZSgDnvKKqxnPN4379JOB3Hyvqp0VIKK+PKlCbH2XUcRV6H
 9AVyi4oVxyP0EQ63fW4MXORtKR3P10mEiGHM0oAiTpP3dMuarSkSrWw9N w==;
IronPort-SDR: WVwBsHw52dmvQgbGO3/FA6m+gUo861yAYYIHYVZIZhQKogRk1IBqI5KTTtumEwUlot6D9tKaCU
 01dONKg+++Swu398MR9DsaiOHAFeVVkIs5alw9gzbHQlK7ytI94grimSWQyBMIf8Ds7bezhjkC
 sRCJuRAMlz9aobk0lHOn3W9F3yse+sHJWFvU2r+vZe0XImRxYSv/h21yl/uQel7SALe7z1FcZ3
 e7lLGIZCATAUbihcLoM/7kr7zMK/mX74gzTGKetmcCnMhdb5R+zuKQguPdYr16KXLh5SGGkn2w
 Y98=
X-IronPort-AV: E=Sophos;i="5.77,355,1596492000"; d="scan'208";a="13345780"
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 <tiwai@suse.de>
From: Jonas Holmberg <jonashg@axis.com>
Subject: snd_pcm_status() does not update status->avail
Message-ID: <d9c1f37e-5c8d-f289-270e-c6cda7a56ce3@axis.com>
Date: Fri, 9 Oct 2020 16:02:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

Hi,
I have a problem with status->avail not being updated when using 
multiple extplug plugins and softvol. I managed to get it to work with 
the following patch:

diff --git a/src/pcm/pcm_plugin.c b/src/pcm/pcm_plugin.c
index ea60eb98..89e819d6 100644
--- a/src/pcm/pcm_plugin.c
+++ b/src/pcm/pcm_plugin.c
@@ -551,6 +551,8 @@ static int snd_pcm_plugin_status(snd_pcm_t *pcm, 
snd_pcm_status_t * status)
                 return err;
         status->appl_ptr = *pcm->appl.ptr;
         status->hw_ptr = *pcm->hw.ptr;
+       status->avail = snd_pcm_mmap_capture_avail(pcm);
+       status->delay = snd_pcm_mmap_capture_delay(pcm);
         return 0;
  }

My question is if this is the correct solution?

BR
/Jonas
