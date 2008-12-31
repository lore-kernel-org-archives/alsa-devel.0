From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/2] ASoC: TWL4030: Add DAPM based capture
	implementation
Date: Wed, 31 Dec 2008 10:08:36 +0200
Message-ID: <1230710918-2741-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id A664B1037EC
	for <alsa-devel@alsa-project.org>; Wed, 31 Dec 2008 09:08:50 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: sakoman@gmail.com
List-Id: alsa-devel@alsa-project.org

Hello,

It has been a long time...
Finally I have managed to get the DAPM based capture implementation working.
I have not counted, but there were several dead end trials before I ended up
with the current implementation.

I have tested the capture implementation with the following configs:
digimic0, Headset mic, AUX connected (not on the same board).
So far the capture path behaved in a sane way, powering/enabling only the needed
components in the capture path.

All of the user controls are showing under the 'Capture' tab in alsamixer.

Example for the board file maintainers to get the capture working:
Let's say the board have the following input selection:
Headset mic, AUXL/R (Line in), digimic0

static const struct snd_soc_dapm_widget BOARD_dapm_widgets[] = {
	SND_SOC_DAPM_MIC("Digital Mic", NULL),
	SND_SOC_DAPM_MIC("Headset Mic", NULL),
	SND_SOC_DAPM_LINE("Line in", NULL);
};

static const struct snd_soc_dapm_route audio_map[] = {
	{"DIGIMIC0", NULL, "Mic Bias 1"},
	{"Mic Bias 1", NULL, "Digital Mic"},

	{"HSMIC", NULL, "Headset Mic Bias"},
	{"Headset Mic Bias", NULL, "Headset Mic"},

	{"AUXL", NULL, "Line in"},
	{"AUXR", NULL, "Line in"},
};

To record from the Headset mic:
amixer sset 'Analog Left' 'Headset mic' # select the Headset for Analog left
amixer sset 'TX1' 'Analog'	# Select the Analog path for TX1
amixer sset 'TX2' 'Digimic1'	# will disable the TX2 path, since digimic1 is
				# not connected
amixer sset 'Analog' 2,2	# set the analog capture volume


Have a Happy New Year!

---
Peter Ujfalusi (2):
 ASoC: TWL4030: Make the enum filter generic for twl4030
 ASoC: TWL4030: DAPM based capture implementation

 sound/soc/codecs/twl4030.c |  377 ++++++++++++++++++++++----------------------
 sound/soc/codecs/twl4030.h |    7 +
 2 files changed, 196 insertions(+), 188 deletions(-)
