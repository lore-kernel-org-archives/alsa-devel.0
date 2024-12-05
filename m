Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F664E7716C
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Dec 2024 15:57:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1B8141928;
	Thu,  5 Dec 2024 16:57:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1B8141928
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1733414240;
	bh=QKINI4gXvq5tu4To73hJDJYh+d1b1ccN5gLRHw6HUns=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=aUHlIB67dNw80XA9OERAAFeTl8RZIHHDXdTj56T6NX5FmTxrUuiMI7CmirCMIq2hf
	 QLpYJU7oJ67VGBS8cqhxGHy8V4GVXKMqdnSSlcTnBdotkbdbfSWLbOPX9iiIbvEtKS
	 1I19qDS2oXyGAw196/nVmrmLyQ7DhbsO3clfIwYw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8C7D7F805BA; Thu,  5 Dec 2024 16:56:48 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E69AFF805C3;
	Thu,  5 Dec 2024 16:56:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A61EFF8047C; Thu,  5 Dec 2024 16:56:44 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id E79F2F8032D
	for <alsa-devel@alsa-project.org>; Thu,  5 Dec 2024 16:56:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E79F2F8032D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1733414202483495474-webhooks-bot@alsa-project.org>
References: <1733414202483495474-webhooks-bot@alsa-project.org>
Subject: With SOF enabled in sof-hda-generic.tplg device (no DMIC) the control
 'Capture Source' is not controlled by UCM
Message-Id: <20241205155644.A61EFF8047C@alsa1.perex.cz>
Date: Thu,  5 Dec 2024 16:56:44 +0100 (CET)
Message-ID-Hash: G3HCI25CRB7XU2MK6Q42WC7ICFZV376A
X-Message-ID-Hash: G3HCI25CRB7XU2MK6Q42WC7ICFZV376A
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/G3HCI25CRB7XU2MK6Q42WC7ICFZV376A/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #484 was edited from singalsu:

The configuration is not usual. If there is no DMIC in the system usually the legacy mode is selected (as with `options snd_intel_dspcfg dsp_driver=1`). In such PCs SOF can be enabled with `options snd_intel_dspcfg dsp_driver=3`.

When a headset is plugged/unplugged the playback correctly switches between speaker and headphone/headset earbuds.

But the microphone capture remains muted. I noticed with legacy mode where internal microphones work that control name='Capture Source' changes to 1 when headset is removed:

```
singalsu@asteri:~$ amixer -c0 cget name='Capture Source' 
numid=6,iface=MIXER,name='Capture Source'
  ; type=ENUMERATED,access=rw------,values=1,items=2
  ; Item #0 'Headset Mic'
  ; Item #1 'Internal Mic'
  : values=1
singalsu@asteri:~$ amixer -c0 cget name='Capture Source' 
numid=6,iface=MIXER,name='Capture Source'
  ; type=ENUMERATED,access=rw------,values=1,items=2
  ; Item #0 'Headset Mic'
  ; Item #1 'Internal Mic'
  : values=0
```

This is not happening when SOF is enabled. But I could make internal microphones capture work with `amixer -c0 cset name='Capture Source' 1`.  Is there a way to fix this in ucm2? I'm not absolutely sure about this issue in Fedora 41 but this happens with my ucm2 development code with plain git master branch (commit 0782bf435b8332833e7b3fc91501d78473dd6edf).

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/484
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
