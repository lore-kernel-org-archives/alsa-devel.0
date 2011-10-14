From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 0/2] ASoC: core: Ignoring pmdown_time for
	playback stream power down
Date: Fri, 14 Oct 2011 14:43:32 +0300
Message-ID: <1318592614-13110-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog119.obsmtp.com (na3sys009aog119.obsmtp.com
	[74.125.149.246])
	by alsa0.perex.cz (Postfix) with ESMTP id 57CB21037F3
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Oct 2011 13:43:37 +0200 (CEST)
Received: by mail-gx0-f169.google.com with SMTP id k5so1181432ggd.0
	for <alsa-devel@alsa-project.org>; Fri, 14 Oct 2011 04:43:35 -0700 (PDT)
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

Changes since v1 (RFC):
- move the flag to per codec (snd_soc_codec)
- twl6040 to request to ignore the pmdown_time

Add support in core to ignore the pmdown_time when stopping the playback stream.
This will inline the DAPM stream stop event, so it is going to be executed
without delay at stream close time (for playback stream).

Backround: with the McPDM protocol we are sendning not only
the pure audio stream, but OMAP McPDM also transmits
additional information (for example offset cancellation).
If McPDM is stopped prior to the DAC this information will
be not sent to the codec, which can result noise rendered
by the twl6040 codec.

Regards,
Peter
---
Peter Ujfalusi (2):
  ASoC: core: Add flag to ignore pmdown_time at pcm_close
  ASoC: twl6040: Request core to inline the DAPM sequence

 include/sound/soc.h        |    1 +
 sound/soc/codecs/twl6040.c |    1 +
 sound/soc/soc-pcm.c        |   15 +++++++++++----
 3 files changed, 13 insertions(+), 4 deletions(-)

-- 
1.7.7
