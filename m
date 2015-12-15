From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v3 0/8] Add support for voice control on
	Arizona ADSP
Date: Tue, 15 Dec 2015 11:29:41 +0000
Message-ID: <1450178989-8749-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id AA183261A73
 for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2015 12:29:52 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

This series add support for voice control on wm8280/5110. This is
done by opening a compressed record channel, upon which data will
be available once the voice control functionality has been
triggered on the DSP.

Changes since v2:
 - Fix specified using in printf for size_t in wm_adsp_compr_read,
   as reported by the kbuild test robot.

Thanks,
Charles

Charles Keepax (8):
  ASoC: wm5110: Provide basic hookup for voice control
  ASoC: wm_adsp: Factor out finding the location of an algorithm region
  ALSA: compress: Add SND_AUDIOCODEC_BESPOKE
  ASoC: wm_adsp: Add support for opening a compressed stream
  ASoC: wm_adsp: Add code to locate and initialise compressed buffer
  ASoC: wm_adsp: Attach buffers and streams together
  ASoC: wm_adsp: Add a handler for the compressed IRQ
  ASoC: wm_adsp: Pull data through compressed read

 include/uapi/sound/compress_params.h |   5 +-
 sound/soc/codecs/Kconfig             |   1 +
 sound/soc/codecs/arizona.h           |   2 +-
 sound/soc/codecs/wm5110.c            |  95 +++-
 sound/soc/codecs/wm_adsp.c           | 907 ++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/wm_adsp.h           |  21 +
 6 files changed, 1010 insertions(+), 21 deletions(-)

-- 
2.1.4
