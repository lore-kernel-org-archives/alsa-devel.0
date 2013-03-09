From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 3/7] ALSA: hdspm - Provide ALSA control to
	disable 96K frames
Date: Sun, 10 Mar 2013 00:37:23 +0100
Message-ID: <1362872247-29029-4-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1362872247-29029-1-git-send-email-adi@drcomp.erfurt.thur.de>
 <1362872247-29029-2-git-send-email-adi@drcomp.erfurt.thur.de>
 <1362872247-29029-3-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1362872247-29029-3-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

For 96kHz, MADI allows to multiplex the samples (SMUX) or to use a
dedicated 96K mode. The RME cards default to 96K mode, but since not all
external MADI equipment supports this, provide a switch to users that
changes the on-wire protocol to SMUX.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 830a899..60e992d 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -4189,6 +4189,7 @@ static struct snd_kcontrol_new snd_hdspm_controls_madi[] = {
 	HDSPM_SYNC_CHECK("SYNC IN SyncCheck", 3),
 	HDSPM_TOGGLE_SETTING("Line Out", HDSPM_LineOut),
 	HDSPM_TOGGLE_SETTING("TX 64 channels mode", HDSPM_TX_64ch),
+	HDSPM_TOGGLE_SETTING("Disable 96K frames", HDSPM_SMUX),
 	HDSPM_TOGGLE_SETTING("Clear Track Marker", HDSPM_clr_tms),
 	HDSPM_TOGGLE_SETTING("Safe Mode", HDSPM_AutoInp),
 	HDSPM_INPUT_SELECT("Input Select", 0),
-- 
1.7.10.4
