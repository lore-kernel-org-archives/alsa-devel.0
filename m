From: Carlo Caione <carlo@caione.org>
Subject: [PATCH 0/2] rt5651: Enable jack detection
Date: Thu, 19 Oct 2017 12:03:21 +0100
Message-ID: <20171019110323.23751-1-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f195.google.com (mail-wr0-f195.google.com
 [209.85.128.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D702266EE0
 for <alsa-devel@alsa-project.org>; Thu, 19 Oct 2017 13:03:29 +0200 (CEST)
Received: by mail-wr0-f195.google.com with SMTP id l1so7889617wrc.3
 for <alsa-devel@alsa-project.org>; Thu, 19 Oct 2017 04:03:29 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux@endlessm.com, bardliao@realtek.com, oder_chiou@realtek.com, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, albertchen@realtek.com, edgar_shen@realtek.com
Cc: Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

From: Carlo Caione <carlo@endlessm.com>

Small set of patches to enable jack detection for the rt5651 codec.

Please note that:
- The jack detection is restricted to the JD1_1 pin only (the only
  hardware I have uses this pin for jack detection)
- AFAICT (reading the rt5651 datasheet) there is no way to detect
  runtime the type of the jack inserted as done for the others rt56*
  codecs, so in the driver I always assume that we are dealing with an
  headset.

Carlo Caione (2):
  ASoC: rt5651: Enable jack detection on JD1_1
  ASoC: intel: byt: Add headset jack

 include/sound/rt5651.h                |  7 +++
 sound/soc/codecs/rt5651.c             | 91 ++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/rt5651.h             |  3 ++
 sound/soc/intel/boards/bytcr_rt5651.c | 24 +++++++++
 4 files changed, 123 insertions(+), 2 deletions(-)

-- 
2.14.2
