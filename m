From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/4] A few more extensions to LPE audio driver
Date: Mon, 13 Feb 2017 15:39:15 +0100
Message-ID: <20170213143919.19543-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EAAFD26691A
 for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2017 15:39:23 +0100 (CET)
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
Cc: Ian W MORRISON <ianwmorrison@gmail.com>, Rakesh A Ughreja <rakesh.a.ughreja@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

Linus decided to take another week for 4.11 merge window, so I could
play a bit more, and here is the result :)

The first patch is the fix for possible GPU hang, and this has been
for a while in my local branch and tested.  This should be OK to merge
soon.  (It's also as same as what Ian tested in the last weekend.)

The next one is merely a cleanup patch, so it's fine, too.  The third
one is a transition to use the runtime PM autosuspend, and it's a
preliminary for the last change.

The last one is the new and experimental one: it enables the keep-link
feature.  With this patch, the device is managed as default via
autosuspend, and the link is opened (but silenced) for the pre-given
time (2 seconds) after the PCM close.  If the application restarts the
stream quickly, the receiver is still warm and can resume gracefully.

All these patches are found in topic/intel-lpe-audio branch.
(BTW, I cleaned up my branches: now for-next branch tracks the latest
 stable patches to be merged, while topic/intel-lpe-audio branch
 tracks the experimental patches.  Beware that the latter may be
 rebased frequently.)


Takashi

===

Takashi Iwai (4):
  ALSA: x86: Handle reset at prepare callback
  ALSA: x86: Drop unused stream.running field
  ALSA: x86: Use runtime PM autosuspend
  ALSA: x86: Enable keep-link feature

 sound/x86/intel_hdmi_audio.c | 110 ++++++++++++++++++++++++++++++++-----------
 sound/x86/intel_hdmi_audio.h |   2 +-
 2 files changed, 84 insertions(+), 28 deletions(-)

-- 
2.11.1
