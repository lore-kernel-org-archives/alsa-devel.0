Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC8DC2D0CD
	for <alsa-devel@archiver.kernel.org>; Thu, 15 May 2025 08:04:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C38FF62577;
	Thu, 15 May 2025 09:54:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C38FF62577
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1747295688;
	bh=osPAjVys299Gce0rzP4p8u4WnaMlSffybMaFVRVZtOU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=QfMEMcQ5YebPDxAz7MhH9MfWkMHXP57vvbSvcsZPKzk9JRBmkxLD0B2UQQxwuUoba
	 gza4ah+GmHstgormzNB8MB79ZV2jozGdVXG+f/a5mHf3MeEt+7T+/ImqHeoiCGyOV6
	 +q4sb7KgeIE2jgc3AF4fV72H4to+d7xYthxc1UYs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CD59EF89960; Sun, 11 May 2025 18:07:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A8537F89959;
	Sun, 11 May 2025 18:07:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D0D60F89949; Sun, 11 May 2025 18:07:11 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 1F43AF89947
	for <alsa-devel@alsa-project.org>; Sun, 11 May 2025 18:07:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1F43AF89947
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <183e84b78f4edb00-webhooks-bot@alsa-project.org>
In-Reply-To: <183e84b78f46f400-webhooks-bot@alsa-project.org>
References: <183e84b78f46f400-webhooks-bot@alsa-project.org>
Subject: ASUS Zenbook UM5606 mic-mute LED on when non-functioning DMIC is
 muted, and not analog microphones
Date: Sun, 11 May 2025 18:07:11 +0200 (CEST)
Message-ID-Hash: WYKS5OEM2BVV3ZT5CZBDXW4LSRIG23MC
X-Message-ID-Hash: WYKS5OEM2BVV3ZT5CZBDXW4LSRIG23MC
X-MailFrom: github@alsa-project.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WYKS5OEM2BVV3ZT5CZBDXW4LSRIG23MC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #561 was opened from baybal:

Mic1 below doesn't work, and always stays high if toggled on. Only analog Mic2 is working.

```
{
  "Verbs": {
    "HiFi": {
      "Comment": "Play HiFi quality Music",
      "Devices": {
        "Mic1": {
          "Comment": "Digital Microphone",
          "Values": {
            "CaptureCTL": "_ucm0001.hw:Generic_1",
            "CaptureMixerElem": "Mic ACP LED",
            "CapturePCM": "_ucm0001.hw:acppdmmach",
            "CapturePriority": "100",
            "CaptureSwitch": "Mic ACP LED Capture Switch",
            "PlaybackCTL": "_ucm0001.hw:Generic_1",
            "TQ": "HiFi"
          }
        },
        "Headphones": {
          "Comment": "Headphones",
          "Values": {
            "CaptureCTL": "_ucm0001.hw:Generic_1",
            "JackControl": "Headphone Jack",
            "PlaybackCTL": "_ucm0001.hw:Generic_1",
            "PlaybackMasterElem": "Master",
            "PlaybackMixerElem": "Headphone",
            "PlaybackPCM": "_ucm0001.hw:Generic_1",
            "PlaybackPriority": "200",
            "PlaybackSwitch": "Headphone Playback Switch",
            "PlaybackVolume": "Headphone Playback Volume",
            "TQ": "HiFi"
          }
        },
        "Mic2": {
          "Comment": "Internal Stereo Microphone",
          "Values": {
            "CaptureCTL": "_ucm0001.hw:Generic_1",
            "CaptureMasterElem": "Internal Mic Boost",
            "CaptureMixerElem": "Capture",
            "CapturePCM": "_ucm0001.hw:Generic_1",
            "CapturePriority": "200",
            "CaptureSwitch": "Capture Switch",
            "CaptureVolume": "Capture Volume",
            "PlaybackCTL": "_ucm0001.hw:Generic_1",
            "TQ": "HiFi"
          }
        },
        "Speaker": {
          "Comment": "Speaker",
          "Values": {
            "CaptureCTL": "_ucm0001.hw:Generic_1",
            "PlaybackCTL": "_ucm0001.hw:Generic_1",
            "PlaybackMasterElem": "Master",
            "PlaybackMixerElem": "Speaker",
            "PlaybackPCM": "_ucm0001.hw:Generic_1",
            "PlaybackPriority": "100",
            "PlaybackSwitch": "Speaker Playback Switch",
            "PlaybackVolume": "Speaker Playback Volume",
            "TQ": "HiFi"
          }
        }
      }
    }
  }
}
```

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/561
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
