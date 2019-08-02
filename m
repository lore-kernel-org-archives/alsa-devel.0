From: Ard van Breemen <ard@kwaak.net>
Subject: [PATCH 1/2] ALSA snd-usb-audio: Skip bSynchAddress
	endpoint check if it is invalid.
Date: Fri,  2 Aug 2019 13:52:14 +0200
Message-ID: <20190802115215.311-2-ard@kwaak.net>
References: <20190802115215.311-1-ard@kwaak.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kwaak.net (gw-fsck-sorbs.kwaak.net [82.197.218.155])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 59A29F804CA
 for <alsa-devel@alsa-project.org>; Fri,  2 Aug 2019 13:52:44 +0200 (CEST)
In-Reply-To: <20190802115215.311-1-ard@kwaak.net>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Ard van Breemen <ard@kwaak.net>
List-Id: alsa-devel@alsa-project.org

The Linux kernel assumes that get_endpoint(alts,0) and
get_endpoint(alts,1) are eachothers feedback endpoints.
To reassure that validity it will test bsynchaddress to comply with that
assumption. But if the bsyncaddress is 0 (invalid), it will flag that as
a wrong assumption and return an error.
Fix: Skip the test if bSynchAddress is 0.
Note: those with a valid bSynchAddress should have a code quirck added.

Signed-off-by: Ard van Breemen <ard@kwaak.net>
---
 sound/usb/pcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 75b96929f76c..51a8faf25ed8 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -456,6 +456,7 @@ static int set_sync_endpoint(struct snd_usb_substream *subs,
 	}
 	ep = get_endpoint(alts, 1)->bEndpointAddress;
 	if (get_endpoint(alts, 0)->bLength >= USB_DT_ENDPOINT_AUDIO_SIZE &&
+	    get_endpoint(alts, 0)->bSynchAddress != 0 &&
 	    ((is_playback && ep != (unsigned int)(get_endpoint(alts, 0)->bSynchAddress | USB_DIR_IN)) ||
 	     (!is_playback && ep != (unsigned int)(get_endpoint(alts, 0)->bSynchAddress & ~USB_DIR_IN)))) {
 		dev_err(&dev->dev,
-- 
2.17.1
