From: libin.yang@intel.com
Subject: [RFC PATCH 2/4] ASoC: hdac_hdmi: jack_event represents
	the status
Date: Mon, 27 May 2019 17:07:25 +0800
Message-ID: <1558948047-18930-3-git-send-email-libin.yang@intel.com>
References: <1558948047-18930-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E8C64F896E0
 for <alsa-devel@alsa-project.org>; Mon, 27 May 2019 11:27:36 +0200 (CEST)
In-Reply-To: <1558948047-18930-1-git-send-email-libin.yang@intel.com>
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
Cc: tiwai@suse.de, libin.yang@intel.com, broonie@kernel.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

As jack status represents the monitor connected or not, it represents
a status. So it should not be used as a counter. If driver receives
a monitor disconnection event, it should report this disconnection event
to userspace. For example, if the monitor connection event is sent to
driver twice (this should not happen, but in case there is some mistake),
when driver receives monitor disconnection event, it should still send the
disconnection event to user space.

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 5a9e7f9..90c2ee3 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -177,11 +177,6 @@ static void hdac_hdmi_jack_report(struct hdac_hdmi_pcm *pcm,
 		snd_soc_dapm_disable_pin(port->dapm, port->jack_pin);
 
 	if (is_connect) {
-		/*
-		 * Report Jack connect event when a device is connected
-		 * for the first time where same PCM is attached to multiple
-		 * ports.
-		 */
 		if (pcm->jack_event == 0) {
 			dev_dbg(&hdev->dev,
 					"jack report for pcm=%d\n",
@@ -189,17 +184,11 @@ static void hdac_hdmi_jack_report(struct hdac_hdmi_pcm *pcm,
 			snd_soc_jack_report(pcm->jack, SND_JACK_AVOUT,
 						SND_JACK_AVOUT);
 		}
-		pcm->jack_event++;
+		pcm->jack_event = 1;
 	} else {
-		/*
-		 * Report Jack disconnect event when a device is disconnected
-		 * is the only last connected device when same PCM is attached
-		 * to multiple ports.
-		 */
 		if (pcm->jack_event == 1)
 			snd_soc_jack_report(pcm->jack, 0, SND_JACK_AVOUT);
-		if (pcm->jack_event > 0)
-			pcm->jack_event--;
+		pcm->jack_event = 0;
 	}
 
 	snd_soc_dapm_sync(port->dapm);
-- 
2.7.4
