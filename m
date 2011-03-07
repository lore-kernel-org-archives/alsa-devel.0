From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 3/8] hdspmixer: Adjust playback channel count
	on Multiface.
Date: Mon,  7 Mar 2011 19:03:04 +0100
Message-ID: <1299520989-14273-4-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1299520989-14273-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1299520989-14273-1-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The multiface has 18/14 (SS/DS) playback channels, matching the native
18/14 I/O ports. Headphones don't count (only for #destinations).

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/hdspmixer/src/HDSPMixerCard.cxx b/hdspmixer/src/HDSPMixerCard.cxx
index eb51155..cd6a922 100644
--- a/hdspmixer/src/HDSPMixerCard.cxx
+++ b/hdspmixer/src/HDSPMixerCard.cxx
@@ -211,14 +211,14 @@ void HDSPMixerCard::adjustSettings() {
 	switch (speed_mode) {
 	case 0:
 	    channels_input = 18;
-	    channels_playback = 20;
+	    channels_playback = 18;
 	    channel_map_input = channel_map_playback = channel_map_mf_ss;
 	    dest_map = dest_map_mf_ss;
 	    meter_map_input = meter_map_playback = channel_map_mf_ss;
 	    break;
 	case 1:
 	    channels_input = 14;
-	    channels_playback = 16;
+	    channels_playback = 14;
 	    channel_map_input = channel_map_playback = meter_map_ds;
 	    dest_map = dest_map_ds;
 	    meter_map_input = meter_map_playback = meter_map_ds;
-- 
1.7.4.1
