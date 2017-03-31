From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/3] Improve SKL+ position reporting for legacy
	HD-audio
Date: Fri, 31 Mar 2017 10:49:27 +0200
Message-ID: <20170331084930.813-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BAFDA2669DD
 for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2017 10:49:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Vinod Koul <vinod.koul@intel.com>, Rakesh A Ughreja <rakesh.a.ughreja@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

this is a port of SKL-specific hacks to the legacy HD-audio driver for
improving the PCM position reporting that has been applied to ASoC
driver so far.


Takashi

===

Takashi Iwai (3):
  ALSA: hda - Avoid tricky macros
  ALSA: hda - Move SKL+ vendor specific register definitions to
    hda_register.h
  ALSA: hda - Improved position reporting on SKL+

 include/sound/hda_register.h  | 22 ++++++++++++++++++++--
 include/sound/hdaudio.h       | 28 ++++++++++++++++++----------
 sound/hda/hdac_controller.c   |  2 +-
 sound/hda/hdac_stream.c       |  4 ++--
 sound/pci/hda/hda_intel.c     | 40 ++++++++++++++++++++++++++++++++++++----
 sound/soc/intel/skylake/skl.h | 21 ---------------------
 6 files changed, 77 insertions(+), 40 deletions(-)

-- 
2.11.1
