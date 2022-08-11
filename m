Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A167C19F2A
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Aug 2022 21:34:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7110C826;
	Thu, 11 Aug 2022 23:33:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7110C826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660253659;
	bh=0B+1AXtn2dj9fdBKJL9cwtZ/tdBVjuHiTxofj0aVSb4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fNO3EIXg6Fpb9PV9mrcOFBzdXWe9XeojE3IWjHMELWA/a5v9vAhz60sNm8wGE3cgL
	 GxB/SHSQ8tFb2Z6+5ekNbhTk0aSRLZ4UGuricDAa+2VELj/bmsdAErm7Xxnwi30blw
	 7m4SHMVkiJ9HJ0hPvzgvZ60s0pmRV9auyeMwh24U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 08571F8023B;
	Thu, 11 Aug 2022 23:33:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4D6E3F80246; Thu, 11 Aug 2022 23:33:27 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 5FD35F800AA
 for <alsa-devel@alsa-project.org>; Thu, 11 Aug 2022 23:33:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5FD35F800AA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1660253603027122974-webhooks-bot@alsa-project.org>
References: <1660253603027122974-webhooks-bot@alsa-project.org>
Subject: snd_pcm_sw_params_set_xfer_align() is deprecated
Message-Id: <20220811213327.4D6E3F80246@alsa1.perex.cz>
Date: Thu, 11 Aug 2022 23:33:27 +0200 (CEST)
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

alsa-project/alsa-oss issue #2 was opened from davidebeatrici:

```c
pcm.c: In function 'oss_dsp_sw_params':
pcm.c:376:17: warning: 'snd_pcm_sw_params_set_xfer_align' is deprecated [-Wdeprecated-declarations]
  376 |                 snd_pcm_sw_params_set_xfer_align(pcm, sw, 1);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from /usr/include/alsa/asoundlib.h:54,
                 from pcm.c:40:
/usr/include/alsa/pcm.h:1368:5: note: declared here
 1368 | int snd_pcm_sw_params_set_xfer_align(snd_pcm_t *pcm, snd_pcm_sw_params_t *params, snd_pcm_uframes_t val) __attribute__((deprecated));
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
```

Issue URL     : https://github.com/alsa-project/alsa-oss/issues/2
Repository URL: https://github.com/alsa-project/alsa-oss
