From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/2] RFC: support for audio wall clock
Date: Thu, 28 Jun 2012 16:12:33 -0500
Message-ID: <1340917955-31422-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 8488024454
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Jun 2012 23:12:43 +0200 (CEST)
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

V2 of patches to show how the audio wall clock (eg. the
HDAudio one) can be used to provide precise audio timestamps and track
the drift between audio time and system time. On my laptop I am able
to track a 7ppm delta.  
I will explain in more details how this can be
used during LPC in San Diego, but with the summer coming I'd like to
get feedback as there are changes to the core/alsa-lib that haven't
been modified in years.

TODO:
- 64-bit alignment, verification of pcm_compat.c changes
- handling of digital inputs, need to disable wall-clock timestamps in that case (feedback from Clemens)
- check differences in protocol
- change timecounter to avoid accumulation of rounding errors in cycle->ns conversions
- check overflows
- rework the timecounter init on trigger

Pierre-Louis Bossart (2):
  ALSA: core: add hooks for audio timestamps read from WALLCLOCK
  ALSA: hda: support for wallclock timestamps

 include/sound/asound.h    |    7 ++++-
 include/sound/pcm.h       |    2 +
 sound/core/pcm_compat.c   |   13 +++++++++-
 sound/core/pcm_lib.c      |   15 ++++++++++-
 sound/core/pcm_native.c   |    2 +
 sound/pci/hda/hda_intel.c |   54 ++++++++++++++++++++++++++++++++++++++++++++-
 6 files changed, 86 insertions(+), 7 deletions(-)

-- 
1.7.6.5
