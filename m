Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41B7E92FFA
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Oct 2023 09:17:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B6D29BC0;
	Fri,  6 Oct 2023 11:16:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B6D29BC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696583854;
	bh=5ElaEkvX9anpJLKnXmdzmX+9dWLAdj16lnOhcTaW4Kg=;
	h=Date:Subject:From:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=SlRKCOnpqQBUxsikRgn2WQG2eT5uTKe0I3mO+S+tzy3ZUhD4BQUYxQds4Zv1P/4Du
	 fvzASfjXi6CR8aKD3Np2aRWXEVsX0VehAEEJti3T9qXuMXkX7pGYmz/Cp4fBEMEILi
	 9LVgHYkoYCsl226JKQLqbkuIo6mBEN//BlsyYhT8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 540C5F8057D; Fri,  6 Oct 2023 11:15:57 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 45B25F80579;
	Fri,  6 Oct 2023 11:15:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2F162F8047D; Fri,  6 Oct 2023 06:49:12 +0200 (CEST)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com
 [IPv6:2607:f8b0:4864:20::1149])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AB5EEF80130
	for <alsa-devel@alsa-project.org>; Fri,  6 Oct 2023 06:48:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB5EEF80130
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20230601 header.b=kXHh0FUL
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-5a4f6729d16so27545657b3.0
        for <alsa-devel@alsa-project.org>;
 Thu, 05 Oct 2023 21:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696567737; x=1697172537;
 darn=alsa-project.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JxejygH5qmziLoyCgFqVOSem9ij83WNjHKlHtGyea/0=;
        b=kXHh0FULNGyQb8rMImeK0URkpaarak+IYRpCOD5HYbT0m79D1K0v3Oy+hOh/pyfFTm
         5XQjdRf0fO5OL5+4afzkdDyfMpZStS4cOJyLYRx/EwXWMNL7c/19ZPSHlOH84BwaUFhJ
         Ff4JuibQc1H9So+ItlkOGqeU2DcKl2Dtn1H5T2HM4B+gu5Nm4t2rFUxQ3Jv2jJu9mSRa
         Y853sAW10Kfqe10f3xmVefs2aL0SXNLui1+U/urSghrV7fyqy6dLeGsKlBsAKWb/4Vfo
         wpnw3RWgKsS0Wqiw7biJvtgUwD98me1qFax4aUgbtga6JM6t2PROH1pFXqaJgrJBEEd3
         gdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696567737; x=1697172537;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JxejygH5qmziLoyCgFqVOSem9ij83WNjHKlHtGyea/0=;
        b=OHIhElwrYTwJ6UapdTOfyEFwP8i8z+MHH14yKDux2uK7kxfFrdamIrlJAHZrX0x+oY
         w+E6SczdjOWLvbU/jk1YRxpAn91EluWJQ+EVvljnh2pAHdr3IPRvZ8onNYQxhFWtdHPn
         ducinccCNWyawoqV3PrIZM5+XVSsnRf2lsdjJgLZbUmvE+EBfq0akS0agzS/IDGa5Iqe
         UyelbtPcWUQ+Ok1uOoP9TFrhkfy2592J0fX4OnF9qThmvtMhH2ab4NW24AIEock67k0o
         dqLpiM30pfRAMGZJgtF1UIolWzQIvdJpHq8aFMwp7rPtZG6jewHFxpyAN2jtW4Hnat6P
         ayfw==
X-Gm-Message-State: AOJu0YyFpJcFrBhaoGHIk04PJDN7uk/fgjmRkxGkXZijBZgeUhXBjeez
	Yfn3pT2bDrnuHYk96x3NzxI2HIdLdbhvYx0=
X-Google-Smtp-Source: 
 AGHT+IFwu0d3ihn4gfb24LNDEvVO/zpZNwaYH6ZkrM4PBSQoFA0Ivz14Dz2lcssbOLr0V1WOd8lY2nHVMkCIGmTr
X-Received: from whalechang-p620.tpe.corp.google.com
 ([2401:fa00:1:17:2858:46bd:751:759d])
 (user=whalechang job=sendgmr) by 2002:a81:aa4d:0:b0:59f:3cde:b33a with SMTP
 id z13-20020a81aa4d000000b0059f3cdeb33amr126492ywk.6.1696567737168; Thu, 05
 Oct 2023 21:48:57 -0700 (PDT)
Date: Fri,  6 Oct 2023 12:48:49 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231006044852.4181022-1-whalechang@google.com>
Subject: [PATCH] ALSA: usb-audio: Fix microphone sound on Opencomm2 Headset
From: Whale Chang <whalechang@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: WhaleChang <whalechang@google.com>, Ai Chao <aichao@kylinos.cn>,
	Jaroslav Kysela <perex@perex.cz>, John Keeping <john@keeping.me.uk>,
 Jussi Laako <jussi@sonarnerd.net>,
	Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: 
 3uZEfZQoKCooAvozsqvo1uu22uzs.q20oz6o-rs9szoz6o-352xsq7.25u@flex--whalechang.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: EJFEVCJXB6SRTDUCHWJKTFXWKPDEBDIS
X-Message-ID-Hash: EJFEVCJXB6SRTDUCHWJKTFXWKPDEBDIS
X-Mailman-Approved-At: Fri, 06 Oct 2023 09:15:52 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EJFEVCJXB6SRTDUCHWJKTFXWKPDEBDIS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: WhaleChang <whalechang@google.com>

When a Opencomm2 Headset is connected to a Bluetooth USB dongle,
the audio playback functions properly, but the microphone does not work.

In the dmesg logs, there are messages indicating that the init_pitch
function fails when the capture process begins.

The microphone only functions when the ep pitch control is not set.

Toggling the pitch control off bypasses the init_piatch function
and allows the microphone to work.

Signed-off-by: WhaleChang <whalechang@google.com>
---

 sound/usb/quirks.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 598659d761cc..d4bbef70d2f7 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1994,7 +1994,11 @@ void snd_usb_audioformat_attributes_quirk(struct snd_usb_audio *chip,
 		/* mic works only when ep packet size is set to wMaxPacketSize */
 		fp->attributes |= UAC_EP_CS_ATTR_FILL_MAX;
 		break;
-
+	case USB_ID(0x3511, 0x2b1e): /* Opencomm2 UC USB Bluetooth dongle */
+		/* mic works only when ep pitch control is not set */
+		if (stream == SNDRV_PCM_STREAM_CAPTURE)
+			fp->attributes &= ~UAC_EP_CS_ATTR_PITCH_CONTROL;
+		break;
 	}
 }
 
-- 
2.42.0.609.gbb76f46606-goog

