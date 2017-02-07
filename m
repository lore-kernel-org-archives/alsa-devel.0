From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/6] Yet another experiments with LPE audio
Date: Tue,  7 Feb 2017 14:11:16 +0100
Message-ID: <20170207131122.6345-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 30457266FCD
 for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2017 14:11:24 +0100 (CET)
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org

Another day, another patchset.  Here I put a largish cleanup patch to
just shuffle the code, in addition to the new S16 and S32 formats
support and the support for a single period with no period wakeup as
we've discussed in the previous thread.  One patch to remove BATCH
flag is same and kept in the middle of this series.

I guess I can merge the first three patches now.  As Pierre still
seems to have a concern about BATCH, the rest three patches can
postpone.  It worked stably on my machine, but it'd be appreciated if
anyone else can test it on other machines, too (especially with BYT).

As usual, they are found in topic/intel-lpe-audio-cleanup branch.


Takashi

===

Takashi Iwai (6):
  ALSA: x86: Rearrange defines
  ALSA: x86: Support S32 format
  ALSA: x86: Support S16 format
  ALSA: x86: Don't pass SNDRV_PCM_INFO_BATCH flag
  ALSA: x86: Allow single period PCM operation
  ALSA: x86: Allow no-period-wakeup setup

 sound/x86/intel_hdmi_audio.c     | 53 +++++++++++++++-------
 sound/x86/intel_hdmi_audio.h     | 64 ++++++++++++++++----------
 sound/x86/intel_hdmi_lpe_audio.h | 97 +++++++++++++++++-----------------------
 3 files changed, 118 insertions(+), 96 deletions(-)

-- 
2.11.0
