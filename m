From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] ASoC: tlv320aic3x: Fix
	snd_soc_dapm_put_volsw_aic3x callback
Date: Tue, 27 May 2014 13:53:04 +0300
Message-ID: <1401187986-11059-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 184D82619E9
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 12:53:15 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

Hi,

Commit "cf7c1de20c576 ASoC: dapm: Move 'value' field from widget to
control" changed the way how the 'value' has been stored for a widget.
This resulted issues with codec drivers needing and using custom dapm put
callbacks to handle the hw underneath, like the tlv320aic3x driver.
Since the driver is not updated following the mentioned commit it is mostly
broken when we try to change Left/Righ PGA mixers:

amixer sset 'Left PGA Mixer Line1L' off
amixer: Invalid command!

The reason for this is that the custom callback was not calling the
dapm_kcontrol_set_value() to store the value which causes inconsistent state
between the HW and dapm.

Regards,
Peter
---
Peter Ujfalusi (2):
  ASoC: dapm: Export dapm_kcontrol_set_value() so it can be used by
    drivers
  ASoC: tlv320aic3x: Fix Left/Rigth PGA mixer widgets/kcontrols

 include/sound/soc-dapm.h       |  3 +++
 sound/soc/codecs/tlv320aic3x.c | 14 +++++++-------
 sound/soc/soc-dapm.c           |  3 ++-
 3 files changed, 12 insertions(+), 8 deletions(-)

-- 
1.9.3
