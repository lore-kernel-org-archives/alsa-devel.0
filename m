From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 1/2] ALSA: usb: fix corrupted pointers due to
	interface setting change
Date: Thu, 13 Aug 2015 17:42:32 -0500
Message-ID: <1439505753-3532-2-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1439505753-3532-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 28924264F33
 for <alsa-devel@alsa-project.org>; Fri, 14 Aug 2015 00:42:40 +0200 (CEST)
In-Reply-To: <1439505753-3532-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

When a transition occurs between alternate settings that do not use the
same synchronization method, the substream pointers were not reset.
This prevents audio from being played during the second transition.

Identified and tested with M-Audio Transit device
(0763:2006 Midiman M-Audio Transit)

Details of the issue:

First playback to adaptive endpoint:
$ aplay -Dhw:1,0 ~/24_96.wav
Playing WAVE '/home/plb/24_96.wav' : Signed 24 bit Little Endian in 3bytes,
Rate 96000 Hz, Stereo

[ 3169.297556] usb 1-2: setting usb interface 1:1
[ 3169.297568] usb 1-2: Creating new playback data endpoint #3
[ 3169.298563] usb 1-2: Setting params for ep #3 (type 0, 3 urbs), ret=0
[ 3169.298574] usb 1-2: Starting data EP @ffff880035fc8000

first playback to asynchronous endpoint:
$ aplay -Dhw:1,0 ~/16_48.wav
Playing WAVE '/home/plb/16_48.wav' : Signed 16 bit Little Endian,
Rate 48000 Hz, Stereo

[ 3204.520251] usb 1-2: setting usb interface 1:3
[ 3204.520264] usb 1-2: Creating new playback data endpoint #3
[ 3204.520272] usb 1-2: Creating new capture sync endpoint #83
[ 3204.521162] usb 1-2: Setting params for ep #3 (type 0, 4 urbs), ret=0
[ 3204.521177] usb 1-2: Setting params for ep #83 (type 1, 4 urbs), ret=0
[ 3204.521182] usb 1-2: Starting data EP @ffff880035fce000
[ 3204.521204] usb 1-2: Starting sync EP @ffff8800bd616000

second playback to adaptive endpoint: no audio and error on terminal:
$ aplay -Dhw:1,0 ~/24_96.wav
Playing WAVE '/home/plb/24_96.wav' : Signed 24 bit Little Endian in 3bytes,
Rate 96000 Hz, Stereo
aplay: pcm_write:1939: write error: Input/output error

[ 3239.483589] usb 1-2: setting usb interface 1:1
[ 3239.483601] usb 1-2: Re-using EP 3 in iface 1,1 @ffff880035fc8000
[ 3239.484590] usb 1-2: Setting params for ep #3 (type 0, 4 urbs), ret=0
[ 3239.484606] usb 1-2: Setting params for ep #83 (type 1, 4 urbs), ret=0

This last line shows that a sync endpoint is used when it shouldn't.
The sync endpoint is no longer valid and the pointers are corrupted

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/usb/pcm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index b4ef410..7cd7c03 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -395,6 +395,19 @@ static int set_sync_endpoint(struct snd_usb_substream *subs,
 	if (err < 0)
 		return err;
 
+	if ((is_playback && (attr != USB_ENDPOINT_SYNC_ASYNC)) ||
+		(!is_playback && (attr != USB_ENDPOINT_SYNC_ADAPTIVE))) {
+
+		/*
+		 * Clean-up subs pointers to make sure sync_endpoint is never
+		 * configured. This is needed in case of a transition between
+		 * alternate settings using different synchronization modes
+		 * where the previous sync_endpoint may no longer be valid.
+		 */
+		subs->sync_endpoint = NULL;
+		subs->data_endpoint->sync_master = NULL;
+	}
+
 	if (altsd->bNumEndpoints < 2)
 		return 0;
 
-- 
1.9.1
