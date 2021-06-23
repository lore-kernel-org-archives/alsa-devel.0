Return-Path: <SRS0=sqcX=LR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C42C4743C
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Jun 2021 18:16:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BD616115A
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Jun 2021 18:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD616115A
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BF824847;
	Wed, 23 Jun 2021 20:15:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BF824847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624472153;
	bh=pKNq6YFw89wchrPp7mx6cGyG36yfgb00ET3ctuRFtiQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=En7MjUre2rt8WxBEb8gTXdnqanB5I+im9ifvHK9QS1bK3VaBqLtE7tmYM+0T3jXe6
	 gyGuz9L4vBYuv9aajqGvrHda50S5rtf2PU0rfZkCQg3n4bjVq1Nc/bS8N9YBNjXube
	 zpJeyaDc1+M5SHQTIcPvHwbYvLD1aKcXqP+x23DY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 43407F8016B;
	Wed, 23 Jun 2021 20:15:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 628C8F8016D; Wed, 23 Jun 2021 20:15:02 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 0CDEEF800B5
 for <alsa-devel@alsa-project.org>; Wed, 23 Jun 2021 20:14:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0CDEEF800B5
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1624472088770561934-webhooks-bot@alsa-project.org>
References: <1624472088770561934-webhooks-bot@alsa-project.org>
Subject: 1.2.5 now prefixing devices with "_ucm0001."
Message-Id: <20210623181502.628C8F8016D@alsa1.perex.cz>
Date: Wed, 23 Jun 2021 20:15:02 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #104 was opened from craftyguy:

I'm using a ucm2 config that is not yet upstream (see [1]), and 1e6297b650114cb2e043be4c677118f971e31eb7 has caused devices to get renamed; they are now prefixed with `_ucm0001.`:

alsaucm json output from 1.2.4:

```
...
  "Verbs": {
    "HiFi": {
      "Comment": "Default",
      "Devices": {
        "Handset": {
          "Comment": "Handset",
          "ConflictingDevices": [
            "Speaker",
            "Headphones"
          ],
          "Values": {
            "CaptureCTL": "hw:L5",
            "PlaybackCTL": "hw:L5",
            "PlaybackChannels": "2",
            "PlaybackPCM": "hw:L5,0",
            "PlaybackPriority": "100",
            "PlaybackSwitch": "name='Speaker Switch'",
            "PlaybackVolume": "name='Speaker Volume'"
          }
        },
...
```


alsaucm json output from 1.2.5:

```
...
  "Verbs": {
    "HiFi": {
      "Comment": "Default",
      "Devices": {
        "Handset": {
          "Comment": "Handset",
          "ConflictingDevices": [
            "Speaker",
            "Headphones"
          ],
          "Values": {
            "CaptureCTL": "_ucm0001.hw:L5",
            "PlaybackCTL": "_ucm0001.hw:L5",
            "PlaybackChannels": "2",
            "PlaybackPCM": "_ucm0001.hw:L5,0",
            "PlaybackPriority": "100",
            "PlaybackSwitch": "name='Speaker Switch'",
            "PlaybackVolume": "name='Speaker Volume'"
          }
        },
...
```

This breaks things [like pulseaudio config](https://source.puri.sm/Librem5/librem5-base/-/blob/pureos/byzantium/default/audio/pulse/librem5.pa) that expects specific device names. Was this renaming intentional?

cc @agx

1. https://source.puri.sm/Librem5/librem5-base/-/tree/pureos/byzantium/default/audio/ucm2/Librem_5

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/104
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
