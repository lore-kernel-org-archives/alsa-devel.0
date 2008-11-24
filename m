From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/9] ASoC: TWL4030: Add mixer controls for
	outputs
Date: Mon, 24 Nov 2008 13:49:34 +0200
Message-ID: <1227527383-22516-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B6B924362
	for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2008 12:49:54 +0100 (CET)
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

I have tried to clean up the changes that I have at the momnent.
After the series you will have 'ultimate' control on how the
audio is routed to the outputs of TWL.
One can select the possible inputs (for the output) on all cahnnels.
Also I have added gain (volume) controls, wherever it is possible,
but they are working for both channels in case of stereo outputs.

I tried to name the controls to match with the output's name, so
you can easily tell which pin(s) the control will touch.

The capture part is not touched, yet.

I have not included the changes regarding to the
SND_SOC_DAPM_OUTPUT() things.
So you have one (actually two) outputs and you can use the mixer
interface to select where the audio actually routed.

The next step is to make correct dapm mapping for the TWL, but
that will take some time.

Please comment, if I'm doing something that I should not.

---
Peter Ujfalusi (9):
 ASoC: TWL4030: Change the Master volume control to TLV
 ASoC: TWL4030: Add CGAIN volume control
 ASoC: TWL4030: Add helper function for mux handling.
 ASoC: TWL4030: Add helper function for output gain controls
 ASoC: TWL4030: Add PreDriv outupt mux and volume controls
 ASoC: TWL4030: Add Headset outupt mux and volume controls
 ASoC: TWL4030: Add Carkit outupt mux and volume controls
 ASoC: TWL4030: Add Hands-free outupt mux control
 ASoC: TWL4030: Add Earpiece outupt mux and volume controls

 sound/soc/codecs/twl4030.c |  298 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 296 insertions(+), 2 deletions(-)
