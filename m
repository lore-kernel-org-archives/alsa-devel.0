From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC 0/2] ASoC: core: Ignoring pmdown_time for
	playback stream power down
Date: Thu, 13 Oct 2011 16:23:33 +0300
Message-ID: <1318512215-2331-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog107.obsmtp.com (na3sys009aog107.obsmtp.com
	[74.125.149.197])
	by alsa0.perex.cz (Postfix) with ESMTP id 3179F103876
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Oct 2011 15:23:57 +0200 (CEST)
Received: by mail-ey0-f179.google.com with SMTP id 10so2232885eyz.24
	for <alsa-devel@alsa-project.org>; Thu, 13 Oct 2011 06:23:44 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Hello Mark,

Add support in core to ignore the pmdown_time when stopping the playback stream.
This will inline the DAPM stream stop event, so it is going to be executed
without delay at stream close time (for playback stream).

Backround: with the McPDM protocol we are sendning not only
the pure audio stream, but OMAP McPDM also transmits
additional information (for example offset cancellation).
If McPDM is stopped prior to the DAC this information will
be not sent to the codec, which can result noise rendered
by the twl6040 codec.

Is this something that you were suggesting?

Regards,
Peter
---
Peter Ujfalusi (2):
  ASoC: soc-pcm: Add flag to ignore pmdown_time at pcm_close
  ASoC: sdp4430: Request core to inline the DAPM sequence

 include/sound/soc.h      |    3 +++
 sound/soc/omap/sdp4430.c |    1 +
 sound/soc/soc-pcm.c      |   15 +++++++++++----
 3 files changed, 15 insertions(+), 4 deletions(-)

-- 
1.7.7
