From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/3] ALSA: snd-usb: Accept UAC2 FORMAT_TYPE
 descriptors with bLength > 6
Date: Thu, 04 Aug 2011 16:17:42 +0200
Message-ID: <4E3AAA06.3020204@ladisch.de>
References: <1312466188-3428-1-git-send-email-zonque@gmail.com>	<1312466188-3428-2-git-send-email-zonque@gmail.com>
	<s5h1ux1l18a.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 7A24A24466
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Aug 2011 16:14:15 +0200 (CEST)
In-Reply-To: <s5h1ux1l18a.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Daniel Mack wrote:
>> @@ -352,7 +352,7 @@ int snd_usb_parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
>>  			continue;
>>  		}
>>  		if (((protocol == UAC_VERSION_1) && (fmt->bLength < 8)) ||
>> -		    ((protocol == UAC_VERSION_2) && (fmt->bLength != 6))) {
>> +		    ((protocol == UAC_VERSION_2) && (fmt->bLength < 6))) {
>>  			snd_printk(KERN_ERR "%d:%u:%d : invalid UAC_FORMAT_TYPE desc (protocol %d, bLength %d)\n",
>>  				   dev->devnum, iface_no, altno, protocol, fmt->bLength);
>>  			continue;
> 
> This patch isn't applicable to sound git tree.  Any missing patch?

Obviously some temporary debugging patch to log protocol/bLength.

--8<---------------------------------------------------------------->8--
ALSA: snd-usb: Accept UAC2 FORMAT_TYPE descriptors with bLength > 6

The Focusrite Scarlett 18i6 USB has them that way, which is probably a
bug. Anyway, the driver should simply ignore this fact.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Reported-by: Nicolai Krakowiak <nicolai.krakowiak@gmail.com>
Cc: stable@kernel.org
Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/usb/endpoint.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 1eea7e3..1867bbd 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -352,7 +352,7 @@ int snd_usb_parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
 			continue;
 		}
 		if (((protocol == UAC_VERSION_1) && (fmt->bLength < 8)) ||
-		    ((protocol == UAC_VERSION_2) && (fmt->bLength != 6))) {
+		    ((protocol == UAC_VERSION_2) && (fmt->bLength < 6))) {
 			snd_printk(KERN_ERR "%d:%u:%d : invalid UAC_FORMAT_TYPE desc\n",
 				   dev->devnum, iface_no, altno);
 			continue;
