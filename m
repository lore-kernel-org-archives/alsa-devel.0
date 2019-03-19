From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 00/12] Add support for Halo Core DSPs
Date: Tue, 19 Mar 2019 11:52:03 +0000
Message-ID: <20190319115215.22960-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E738EF8968A
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2019 12:52:25 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, david.rhodes@cirrus.com
List-Id: alsa-devel@alsa-project.org

This series starts with a couple of small bug fixes but the
bulk of the series is refactoring to prepare for, then adding
the new Halo Core DSP support.

Halo Core is similar to the older ADSP cores but requires
slightly different proceedure to enable/disable the core. We
do add a new revision of the WMFW file format to support this
core as well. This revision is currently only supported on Halo
Core although it is expected this will probably be expanded
to include ADSP in the future.

Thanks,
Charles

Charles Keepax (8):
  ASoC: wm_adsp: Correct handling of compressed streams that restart
  ASoC: wm_adsp: Correct error messages in wm_adsp_buffer_get_error
  ASoC: wm_adsp: Add locking to wm_adsp2_bus_error
  ASoC: wm_adsp: Shutdown any compressed streams on DSP watchdog timeout
  ASoC: wm_adsp: Don't export wm_adsp2_lock
  ASoC: wm_adsp: Refactor firmware status reading
  ASoC: wm_adsp: Factor out parsing of firmware ID header
  ASoC: wm_adsp: Factor out DSP specific operations

Richard Fitzgerald (2):
  ASoC: wm_adsp: Move wm_adsp2_set_dspclk to CODEC drivers
  ASoC: wm_adsp: Add HALO MPU fault logging

Stuart Henderson (1):
  ASoC: wm_adsp: Add WDT expiry IRQ handling support for Halo core

Wen Shi (1):
  ASoC: wm_adsp: Add support for new Halo core DSPs

 sound/soc/codecs/cs47l24.c |    4 +-
 sound/soc/codecs/wm5102.c  |    4 +-
 sound/soc/codecs/wm5110.c  |    4 +-
 sound/soc/codecs/wm_adsp.c | 1038 +++++++++++++++++++++++++++++++++-----------
 sound/soc/codecs/wm_adsp.h |   51 ++-
 sound/soc/codecs/wmfw.h    |   30 ++
 6 files changed, 859 insertions(+), 272 deletions(-)

-- 
2.11.0
