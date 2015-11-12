From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 0/4] HDA/i915 jack handling using component
Date: Thu, 12 Nov 2015 17:20:10 +0100
Message-ID: <1447345214-7212-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B5C682659D7
 for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2015 17:20:25 +0100 (CET)
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
Cc: Libin Yang <libin.yang@linux.intel.com>, mengdong.lin@linux.intel.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi,

after the previous discussion ([RFC PATCH 0/2] ALSA: hda - DP MST
audio for Jack support), I thought it'd be even easier to give a
concrete code for further discussion; so here we go, it's a patchset
to implement the jack via audio component.

In the end, I added a new audio component ops to fetch the current
ELD, since the state is unknown at the time the audio driver starts.
The other two patches are just a cleanup.

This series is submitted just as an RFC, basically for a better
understanding, not seriously considered to be merged as is.
(That's why no intel-gfx is Cc'ed yet.)

Note that the i915 patches are applied to the latest Linus tree, while
patch_hdmi.c patch is to my for-linus branch.  The patches are found
in test/hdmi-jack branch of sound git tree.


Takashi

===

Takashi Iwai (4):
  drm/i915: Add get_eld audio component
  drm/i915: Remove superfluous NULL check
  drm/i915: refactoring audio component functions
  ALSA: hda - Use component ops for i915 HDMI/DP audio jack handling

 drivers/gpu/drm/i915/intel_audio.c | 73 ++++++++++++++++++++++++---------
 drivers/gpu/drm/i915/intel_drv.h   |  1 +
 include/drm/i915_component.h       |  4 ++
 sound/pci/hda/patch_hdmi.c         | 83 +++++++++++++++++++++++++++++++++++++-
 4 files changed, 141 insertions(+), 20 deletions(-)

-- 
2.6.3
