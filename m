From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] alsa-lib conf: Add "Plantronics USB
 Headset" to S/PDIF blacklist
Date: Tue, 08 May 2012 15:33:37 -0700
Message-ID: <4FA99F41.7010002@canonical.com>
References: <1336516285-10131-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010900050302030302060002"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 2CE561044DA
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2012 00:33:42 +0200 (CEST)
In-Reply-To: <1336516285-10131-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010900050302030302060002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

2012-05-08 15:31, David Henningsson skrev:
> Unsurprisingly, Plantronics does not have S/PDIF connections
> on their headsets.
>
> Signed-off-by: David Henningsson<david.henningsson@canonical.com>
> ---
>   src/conf/cards/USB-Audio.conf |    1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/src/conf/cards/USB-Audio.conf b/src/conf/cards/USB-Audio.conf
> index 0a0e374..db18dad 100644
> --- a/src/conf/cards/USB-Audio.conf
> +++ b/src/conf/cards/USB-Audio.conf
> @@ -43,6 +43,7 @@ USB-Audio.pcm.iec958_device {
>   	"Logitech USB Headset" 999
>   	"Logitech Wireless Headset" 999
>   	"Sennheiser USB headset" 999
> +	"Plantronics USB Headset" 999
>   	"USB Device 0x46d:0x992" 999
>   }
>
Hm, I must have missed the alphabetic order, attaching modified patch.

--------------010900050302030302060002
Content-Type: text/x-patch;
 name="0001-alsa-lib-conf-Add-Plantronics-USB-Headset-to-S-PDIF-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-alsa-lib-conf-Add-Plantronics-USB-Headset-to-S-PDIF-.pa";
 filename*1="tch"

>From 9fb11528d773d14950ef33fa6fec73e82858f09c Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Tue, 8 May 2012 15:27:01 -0700
Subject: [PATCH] alsa-lib conf: Add "Plantronics USB Headset" to S/PDIF
 blacklist

Unsurprisingly, Plantronics does not have S/PDIF connections
on their headsets.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 src/conf/cards/USB-Audio.conf |    1 +
 1 file changed, 1 insertion(+)

diff --git a/src/conf/cards/USB-Audio.conf b/src/conf/cards/USB-Audio.conf
index 0a0e374..732e8f0 100644
--- a/src/conf/cards/USB-Audio.conf
+++ b/src/conf/cards/USB-Audio.conf
@@ -42,6 +42,7 @@ USB-Audio.pcm.iec958_device {
 	"Logitech Speaker Lapdesk N700" 999	
 	"Logitech USB Headset" 999
 	"Logitech Wireless Headset" 999
+	"Plantronics USB Headset" 999
 	"Sennheiser USB headset" 999
 	"USB Device 0x46d:0x992" 999
 }
-- 
1.7.9.5


--------------010900050302030302060002
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------010900050302030302060002--
