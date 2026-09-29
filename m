Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6C3C9832A
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Sep 2026 14:33:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 09841601E6;
	Tue, 29 Sep 2026 16:33:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 09841601E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790692424;
	bh=xvO1J4cK2aaLWxv/00P+sCfBaNONOeUWwycEk7uxRCg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=SoAdFpKxhueUf8c+QEnZBfS1UKEBp/JmJo9ZmjnhequWTJrq9eF7B7JP2RhsISDTe
	 C9BIvjFOZuWuE+siKq4jDIludFrKporqHsRUaa6igkUEK/pVl8WfmANkL2pp8UKBop
	 FO4Q8Hn6Wyn+RGft9zzsjRSEEf++aLirRESbRjUc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EF340F80600; Tue, 29 Sep 2026 16:33:09 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6E18AF80020;
	Tue, 29 Sep 2026 16:33:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3A971F8055C; Tue, 29 Sep 2026 16:33:03 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790692382;
	b=WgTlr5V6lFj0e+RdY8Jukf2cmFXLgionpVviRhSxsVuLDxgInTBTwoLySP6SZonI5aKw
	 PGv0ASBhCMfMbrkAqxvPCcKOx4AMSBw6dZpjCkSgW6qoKv02acCylDlt6fDBOlgb52Cw8
	 ro6zhFPQTZwVNmlRFcTOwE3hD0IVpq6E981/gN3QUz+a7bpK0a+Jx1oPac3805cwPW0s3
	 72yqzRAzasRGm8tYxVoZzgtHNFRdBFCuDj7Lcre7GNg8UK9P7myALWvRL6YKr2LttJaX2
	 WQ/1TENi5oWIcJJcINYLEY0FR0Q2CDRHCvbXVHd7rX+lZLd4yDtpynHohTIDHv0a4jQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790692382;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=xvO1J4cK2aaLWxv/00P+sCfBaNONOeUWwycEk7uxRCg=;
	b=VhmBiO90rh2YngQHat5bZbvBkhke7PhCcwkJArqyTB5q3TM4CglQcBq5Njje1kpIwvLd
	 Ezwdnd1WG6QR6EqB+R2bilE86w4dE5UqZvf4vd7BMaP7cwv+7F91Tu5+DKbDyXrjPI+Dj
	 H7L6pRwPOAIKYFNYaGfxOkDTQDVvsFIrg0wMLfZNepihywK10BJf9SdlOv9z2IbTuoM9f
	 TFzs0tsWndIkzZ8ysfJQjVvgnKKEUlJzzQpMlkHKFbEiZtEfCjCjtJ0lrefelZZvC6a1J
	 Zplv/80aZKEf5DTAbIoQxQxWUkIW4GDoA1X7L0huqZEbXN20n80DZRUV9a2Hm6eRtoQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 3C1BFF80020
	for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2026 16:33:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3C1BFF80020
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18d9d13b80d37e00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/861@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/861@alsa-project.org>
Subject: USB-Audio: correct naming scheme for Master Playback
Date: Tue, 29 Sep 2026 16:33:03 +0200 (CEST)
Message-ID-Hash: ZAGUZJT2AEDYPUUSW33SREJODVEENGD7
X-Message-ID-Hash: ZAGUZJT2AEDYPUUSW33SREJODVEENGD7
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZAGUZJT2AEDYPUUSW33SREJODVEENGD7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #861 was opened from fxzzi:

With the merge of https://lore.kernel.org/linux-sound/87bj9g19d6.wl-tiwai@suse.de/ , correct the name for PlaybackVolume as is done in snd-usb-audio, as well as add the new PlaybackSwitch, which will allow us to mute the interface in hardware.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/861
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/861.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
