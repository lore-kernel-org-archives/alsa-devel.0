Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E40C43334
	for <alsa-devel@archiver.kernel.org>; Sun, 19 Jun 2022 13:57:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A49EC1849;
	Sun, 19 Jun 2022 15:56:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A49EC1849
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655647064;
	bh=1r8xocXbgC/b6BwKLsmkJ6qqeL+wyzUyQje5Rf/4j9A=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KLecmeERqYNzosh7DeoNOUp5tHGOF8wE/lQ7TIylucSIH4/zM4UhI/Ah2DKg0grRG
	 m7EsPykoL4A0zD/tie0uKSMNDfoaWbkoN/wij9vlk9ui3Z+GNEJLN6OKloc/1EBE18
	 uvIX4a4W3iro/qg2EkZ4rjCdtDe2rpkaGKNjC9io=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3AFBFF80158;
	Sun, 19 Jun 2022 15:56:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 033E9F8014E; Sun, 19 Jun 2022 15:56:53 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 9E332F8014E
 for <alsa-devel@alsa-project.org>; Sun, 19 Jun 2022 15:56:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9E332F8014E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1655647010177676916-webhooks-bot@alsa-project.org>
References: <1655647010177676916-webhooks-bot@alsa-project.org>
Subject: alsa-utils 1.2.7 fails to build if rawmidi support is disabled in
 alsa-lib
Message-Id: <20220619135653.033E9F8014E@alsa1.perex.cz>
Date: Sun, 19 Jun 2022 15:56:53 +0200 (CEST)
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

alsa-project/alsa-utils issue #154 was opened from Saur2000:

If alsa-lib is configured using `--disable-rawmidi`, then alsa-utils fails to build:

```
  alsactl/info.c:83:44: error: unknown type name 'snd_rawmidi_stream_t'; did you mean 'snd_pcm_stream_t'?
     83 | static const char *snd_rawmidi_stream_name(snd_rawmidi_stream_t stream)
        |                                            ^~~~~~~~~~~~~~~~~~~~
        |                                            snd_pcm_stream_t
  alsactl/info.c:92:48: error: unknown type name 'snd_rawmidi_stream_t'; did you mean 'snd_pcm_stream_t'?
     92 | static int rawmidi_device_list(snd_ctl_t *ctl, snd_rawmidi_stream_t stream, bool *first)
        |                                                ^~~~~~~~~~~~~~~~~~~~
        |                                                snd_pcm_stream_t
```

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/154
Repository URL: https://github.com/alsa-project/alsa-utils
