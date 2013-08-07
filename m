From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: [PATCH] [alsa-lib] UCM: Document some standard values
Date: Wed,  7 Aug 2013 23:26:31 +0530
Message-ID: <1375898191-17517-1-git-send-email-arun.raghavan@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.135.160])
 by alsa0.perex.cz (Postfix) with ESMTP id B9B6D261793
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2013 19:54:33 +0200 (CEST)
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
Cc: Arun Raghavan <arun.raghavan@collabora.co.uk>
List-Id: alsa-devel@alsa-project.org

Playback/CaptureChannels has been around for a bit. Playback/CaptureRate
is new and is intended to be used to specify the sample rate at which
the Playback/CapturePCM should be opened.
---
 include/use-case.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/use-case.h b/include/use-case.h
index 93b3456..4e13249 100644
--- a/include/use-case.h
+++ b/include/use-case.h
@@ -259,9 +259,13 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
  *   TQ			- Tone Quality
  *   PlaybackPCM	- full PCM playback device name
  *   CapturePCM		- full PCM capture device name
+ *   PlaybackRate	- playback device sample rate
+ *   PlaybackChannels	- playback device channel count
  *   PlaybackCTL	- playback control device name
  *   PlaybackVolume	- playback control volume ID string
  *   PlaybackSwitch	- playback control switch ID string
+ *   CaptureRate	- capture device sample rate
+ *   CaptureChannels	- capture device channel count
  *   CaptureCTL		- capture control device name
  *   CaptureVolume	- capture control volume ID string
  *   CaptureSwitch	- capture control switch ID string
-- 
1.8.2.1
