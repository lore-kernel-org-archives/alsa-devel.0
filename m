From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: [PATCH alsa-lib] conf: add support for USB AudioSport
	Quattro (tm)
Date: Sat, 31 Jan 2015 23:26:07 +0500
Message-ID: <1422728767-5292-1-git-send-email-patrakov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 2786E260500
 for <alsa-devel@alsa-project.org>; Sat, 31 Jan 2015 19:26:25 +0100 (CET)
Received: by mail-wg0-f51.google.com with SMTP id k14so32001864wgh.10
 for <alsa-devel@alsa-project.org>; Sat, 31 Jan 2015 10:26:24 -0800 (PST)
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
Cc: tiwai@suse.de, "Alexander E. Patrakov" <patrakov@gmail.com>
List-Id: alsa-devel@alsa-project.org

This patch resulted from discussion with redlion_ on #alsa IRC channel
on Freenode. 4-channel playback now works. 4-channel capture works too,
but not simultaneously with playback (hardware limitation).

Alsa-info before the fix:
http://www.alsa-project.org/db/?f=a3673622074b88a1abf4ccc6e7f37d0b5b72f34a

Signed-off-by: Alexander E. Patrakov <patrakov@gmail.com>
---
 src/conf/cards/USB-Audio.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/conf/cards/USB-Audio.conf b/src/conf/cards/USB-Audio.conf
index 05e5d09..4cbf85e 100644
--- a/src/conf/cards/USB-Audio.conf
+++ b/src/conf/cards/USB-Audio.conf
@@ -30,6 +30,7 @@ USB-Audio.pcm.surround40_type {
 	"OmniStudio" two_stereo_devices
 	"Quattro" two_stereo_devices
 	"SB Audigy 2 NX" six_channels
+	"USB AudioSport Quattro (tm)" two_stereo_devices
 }
 
 # If a device does not use the first PCM device for digital data, the device
-- 
2.2.1
