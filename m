From: Damien Zammit <damien.zammit@gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio - Capture and duplex
 support for Digidesign Mbox 1 sound card.
Date: Mon, 27 Jan 2014 02:30:02 +1100
Message-ID: <52E529FA.3030101@gmail.com>
References: <52E5254A.8090308@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060905050702040506050107"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f48.google.com (mail-pb0-f48.google.com
 [209.85.160.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C2C226164D
 for <alsa-devel@alsa-project.org>; Sun, 26 Jan 2014 16:30:27 +0100 (CET)
Received: by mail-pb0-f48.google.com with SMTP id rr13so4949514pbb.21
 for <alsa-devel@alsa-project.org>; Sun, 26 Jan 2014 07:30:26 -0800 (PST)
Received: from [192.168.140.2] (14-201-185-176.static.tpgi.com.au.
 [14.201.185.176])
 by mx.google.com with ESMTPSA id qw8sm23117319pbb.27.2014.01.26.07.30.23
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Sun, 26 Jan 2014 07:30:24 -0800 (PST)
In-Reply-To: <52E5254A.8090308@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060905050702040506050107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This second patch removes a few extra lines I added by mistake when I 
merged my private repo to the one for submission.


--------------060905050702040506050107
Content-Type: text/x-patch;
 name="0002-Removed-accidental-extra-lines.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0002-Removed-accidental-extra-lines.patch"

[PATCH] ALSA: usb-audio - Capture and duplex support for Digidesign Mbox 1 sound card.

This second patch removes a few extra lines I added by mistake when I merged my private repo to the one for submission.

Signed-off-by: Damien Zammit <damien@zamaudio.com>
---
 sound/usb/quirks-table.h |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 0ea9f00..f799359 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2921,11 +2921,6 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.maxpacksize = 0x130,
 					.rates = SNDRV_PCM_RATE_44100 |
 						 SNDRV_PCM_RATE_48000,
-					.attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
-					.endpoint = 0x02,
-					.ep_attr = 0x01,
-					.rates = SNDRV_PCM_RATE_44100 |
-						 SNDRV_PCM_RATE_48000,
 					.rate_min = 44100,
 					.rate_max = 48000,
 					.nr_rates = 2,
-- 
1.7.9.5


--------------060905050702040506050107
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------060905050702040506050107--
