Return-Path: <SRS0=LSvA=IB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EC3C433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Mar 2021 20:31:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B637E64EFD
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Mar 2021 20:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B637E64EFD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6465C1A3B;
	Wed,  3 Mar 2021 21:30:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6465C1A3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614803499;
	bh=Aqsr3qFYNu0mSqcIHFkLVpbbAFePY6VFK4r2NSXrNFM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dYIfm6mEwRHG2h1cuShpuaBUaolzfQtLBCGYReJRDQTz+ElH5sJckrwNjtm2WHhkI
	 4jv1pYkKAhtLwjOMLt6PiB1KfGlMkxVapx8D1nZtFZhfvcZmGow5miP3/+ngZ9uPPx
	 czkA3FG+hPtDib2LkMcNtCGZjh5hwiovcpARICCI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B8DFCF8012D;
	Wed,  3 Mar 2021 21:30:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6696DF8025E; Wed,  3 Mar 2021 19:14:47 +0100 (CET)
Received: from mail.actia.se (mail.actia.se [195.67.112.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7A671F800B2
 for <alsa-devel@alsa-project.org>; Wed,  3 Mar 2021 19:14:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7A671F800B2
Received: from S036ANL.actianordic.se (192.168.16.117) by
 S036ANL.actianordic.se (192.168.16.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 3 Mar 2021 19:14:39 +0100
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%3]) with mapi id
 15.01.2176.004; Wed, 3 Mar 2021 19:14:39 +0100
From: John Ernberg <john.ernberg@actia.se>
To: "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA: usb: Add Plantronics C320-M USB ctrl msg delay quirk
Thread-Topic: [PATCH] ALSA: usb: Add Plantronics C320-M USB ctrl msg delay
 quirk
Thread-Index: AQHXEFkTCsQRnWxDKk2OSuE4/Zlp2w==
Date: Wed, 3 Mar 2021 18:14:39 +0000
Message-ID: <20210303181405.39835-1-john.ernberg@actia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.0
x-originating-ip: [10.11.250.6]
x-esetresult: clean, is OK
x-esetid: 37303A2905BC1358637367
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 03 Mar 2021 21:30:46 +0100
Cc: "kempe@lysator.liu.se" <kempe@lysator.liu.se>,
 John Ernberg <john.ernberg@actia.se>
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

The microphone in the Plantronics C320-M headset will randomly
fail to initialize properly, at least when using Microsoft Teams.
Introducing a 20ms delay on the control messages appears to
resolve the issue.

Link: https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/issues/1065
Tested-by: Andreas Kempe <kempe@lysator.liu.se>
Signed-off-by: John Ernberg <john.ernberg@actia.se>
---

Note: Microsoft Teams is the only application tests have been performed wit=
h
and no other kinds of investigations have been performed, like USB packet l=
ogging.
Originally reported as a possible PulseAudio issue, where it was suggested =
to
try a delay quirk in the kernel.
If other tests should be performed, please let me know which tests and I wi=
ll try to do them.

All testing was done on 5.10, patch was then applied on sound.git master fo=
r submission

I did not register to the mailing lists, please keep me CC on any comments.=
 Thanks!

 sound/usb/quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index d02dac5fcd40..a31b7db92b1e 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1673,6 +1673,14 @@ void snd_usb_ctl_msg_quirk(struct usb_device *dev, u=
nsigned int pipe,
 	    && (requesttype & USB_TYPE_MASK) =3D=3D USB_TYPE_CLASS)
 		msleep(20);
=20
+	/*
+	 * Plantronics C320-M needs a delay to avoid random
+	 * microhpone failures.
+	 */
+	if (chip->usb_id =3D=3D USB_ID(0x047f, 0xc025)  &&
+	    (requesttype & USB_TYPE_MASK) =3D=3D USB_TYPE_CLASS)
+		msleep(20);
+
 	/* Zoom R16/24, many Logitech(at least H650e/H570e/BCC950),
 	 * Jabra 550a, Kingston HyperX needs a tiny delay here,
 	 * otherwise requests like get/set frequency return
--=20
2.30.0
