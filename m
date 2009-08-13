From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/2] ASoC: TWL4030: Cosmetic and PM related
	changes
Date: Thu, 13 Aug 2009 15:59:32 +0300
Message-ID: <1250168374-24280-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id EBB3324531
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Aug 2009 14:59:43 +0200 (CEST)
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
Cc: broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hello,

I'm not sure, if the first patch is acceptable by ASoC standards, but:
Before the patch the analog capture path strings ended up like this at the end:
"Analog Left Capture Route Main mic Switch"
These switches showed up in the playback tab of alsamixer, which was not nice.
After the patch the strings will be like this:
"Analog Left Main mic Capture Route"
Which show up correctly in alsamixer as "Analog Left Main mic" under the
capture tab.

The second patch cleans up the output amplifier mute/un-mute by adding PGA_E to
all output pins, which were handled by the twl4030_codec_mute function.
Since those gain controls attached to the outputs are not in DAPM domain (yet?)
and they have to be muted/turned off when they are not needed.
Previously all of these (Earpiece PreDrivL/R, CarkitL/R) muted/un-muted at the
same time without checking if the output actually is needed, there could be
cases when the output amplifier is enabled but no actual audio data is routed
there, which could leak some noise on the output.

I know about the changes in core that makes this hassle with the mute
unnecesary (the core sets the BIAS_ON also when any bypass path is active),
I'll be looking at that next.

---
Peter Ujfalusi (2):
  ASoC: TWL4030: Fix for capture mixer strings
  ASoC: TWL4030: Introduce PGAs for outputs

 sound/soc/codecs/twl4030.c |  155 ++++++++++++++++++++++++--------------------
 1 files changed, 85 insertions(+), 70 deletions(-)
