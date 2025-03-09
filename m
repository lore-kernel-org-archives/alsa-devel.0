Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55631C282DE
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Mar 2025 09:42:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 967C5604AF;
	Mon, 10 Mar 2025 10:42:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 967C5604AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1741599777;
	bh=Sn6/wyfGjETZGBSZv233o5pkRGRCKcITAGESw0znzDE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=aB8M2pFigy+J9IbpUl+EyH5SESjTmoJ55sB932GywT7HkPn8/tq2FwCriMhb6XF2p
	 kofVeU72RBZACLVmX5N0GqeTc/49E1uHxJpp24x3rLDwogllm1oBwum8Szsl4Sc/CD
	 Dnkibqt7jDgzr5UfWkYBRjGjkigtqaGbwezSo4vM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0E543F89808; Sun,  9 Mar 2025 12:25:40 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DA66AF89802;
	Sun,  9 Mar 2025 12:25:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 22CE7F897F1; Sun,  9 Mar 2025 12:25:34 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 465D3F8973F
	for <alsa-devel@alsa-project.org>; Sun,  9 Mar 2025 12:25:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 465D3F8973F
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1741519531852391958-webhooks-bot@alsa-project.org>
References: <1741519531852391958-webhooks-bot@alsa-project.org>
Subject: Channel count in Focusrite Scarlett Gen 4 (1235:8218) SplitPCM
 configuration
Message-Id: <20250309112534.22CE7F897F1@alsa1.perex.cz>
Date: Sun,  9 Mar 2025 12:25:34 +0100 (CET)
Message-ID-Hash: TMJPARRBVJVH2EW5C4D67ESAFDE4KPZK
X-Message-ID-Hash: TMJPARRBVJVH2EW5C4D67ESAFDE4KPZK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TMJPARRBVJVH2EW5C4D67ESAFDE4KPZK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #515 was opened from pv:

The configuration https://github.com/alsa-project/alsa-ucm-conf/blob/master/ucm2/USB-Audio/Focusrite/Scarlett-2i-HiFi.conf specifies `HWChannels 2` for the Mic1 and Mic2 devices. This gets translated to `CaptureChannels 2` for `alsaucm open '<<<SplitPCM=1>>>hw:2'`.

However, we've got a report https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/4597#note_2815906 that looks like snd_pcm_hw_params_set_channels(pcm_handle, hwparams, 2) for the CapturePCM "_ucm0001.hw:Gen,0" fails with error. The PCM can be opened with 4 channels, though. Without `SplitPCM=1`, it also probably works but I'm not sure what channel count the `dshare` plugin is using.

Is the `HWChannels 2` for Mic1/2 input direction right?

Shall `CaptureChannels 2` in UCM device be interpreted as that the device can be opened with exactly 2 channels, or that it can be opened with some number of channels >= 2?

<details>

```
$ alsaucm open '<<<SplitPCM=1>>>hw:2' dump text
Verb.HiFi {
	Comment Default
	Device.Line1 {
		Comment "Headphones / Line 1-2"
		Values {
			CaptureCTL "_ucm0001.hw:Gen"
			PlaybackCTL "_ucm0001.hw:Gen"
			PlaybackPCM "_ucm0001.hw:Gen"
			PlaybackPriority 200
		}
	}
	Device.Mic1 {
		Comment "Input 1 Mic/Inst/Line"
		Values {
			CaptureCTL "_ucm0001.hw:Gen"
			CaptureChannel0 0
			CaptureChannelPos0 MONO
			CaptureChannels 2
			CapturePCM "_ucm0001.hw:Gen,0"
			CapturePriority 200
			PlaybackCTL "_ucm0001.hw:Gen"
		}
	}
	Device.Mic2 {
		Comment "Input 2 Mic/Inst/Line"
		Values {
			CaptureCTL "_ucm0001.hw:Gen"
			CaptureChannel0 1
			CaptureChannelPos0 MONO
			CaptureChannels 2
			CapturePCM "_ucm0001.hw:Gen,0"
			CapturePriority 100
			PlaybackCTL "_ucm0001.hw:Gen"
		}
	}
}
Verb.Direct {
	Comment "Direct Scarlett Solo 4th Gen"
	Device.Direct {
		Comment "Direct Scarlett Solo 4th Gen"
		Values {
			CaptureCTL "_ucm0001.hw:Gen"
			CaptureChannels 2
			CapturePCM "_ucm0001.hw:Gen"
			CapturePriority 1000
			PlaybackCTL "_ucm0001.hw:Gen"
			PlaybackChannels 2
			PlaybackPCM "_ucm0001.hw:Gen"
			PlaybackPriority 1000
		}
	}
}
```

</details>

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/515
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
