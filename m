From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/2 take2] SoC: TWL4030 and SDP3430 HS ramp
	configuration
Date: Fri, 22 May 2009 10:13:14 +0300
Message-ID: <1242976396-7667-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 20F34243FF
	for <alsa-devel@alsa-project.org>;
	Fri, 22 May 2009 09:13:47 +0200 (CEST)
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
Cc: sakoman@gmail.com, anuj.aggarwal@ti.com, getarunks@gmail.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hello,

I have found few typos in the patches, resending...

he following series adds support for platform dependent Headset pop removal
configuration for the twl4030 codec.

Platform drivers can fill the twl4030_setup_data structure and pass it with
snd_soc_device->codec_data to the codec driver.

As an example - based on the feedback for the ramp_delay value variations - the
sdp3430.c board is updated to pass the correct ramp settings.

If you know for the other platforms using the twl4030 codec the correct HS ramp
configuration, please update those files...

Mark: This series needs the DAPM restructuring and HS pop removal related
patches for twl4030 codec.

---
Peter Ujfalusi (2):
  ASoC: TWL4030: Add support for platform dependent configuration
  ASoC: SDP4030: Use the twl4030_setup_data for headset pop-removal

 sound/soc/codecs/twl4030.c |   22 +++++++++++++++++++---
 sound/soc/codecs/twl4030.h |    5 +++++
 sound/soc/omap/sdp3430.c   |    7 +++++++
 3 files changed, 31 insertions(+), 3 deletions(-)
