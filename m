From: libin.yang@linux.intel.com
Subject: [RFC PATCH 0/3] support DP MST audio
Date: Mon, 26 Sep 2016 16:35:35 +0800
Message-ID: <1474878938-10260-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FD662665B0
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2016 10:40:06 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: libin.yang@intel.com, mengdong.lin@intel.com, Libin Yang <libin.yang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@linux.intel.com>

This patchset starts to support DP MST audio.

This patchset is based on drm-intel-nightly on
git://anongit.freedesktop.org/drm-intel

Libin Yang (3):
  ALSA: hda - codec add DP MST support for connection list
  ALSA: hda - add DP mst verb support
  ALSA: hda - add DP mst audio support

 sound/pci/hda/hda_codec.c      | 129 ++++++++++++++++++-----
 sound/pci/hda/hda_codec.h      |  18 ++--
 sound/pci/hda/hda_generic.c    |  18 ++--
 sound/pci/hda/hda_proc.c       |   2 +-
 sound/pci/hda/patch_analog.c   |  18 ++--
 sound/pci/hda/patch_hdmi.c     | 228 +++++++++++++++++++++++++++++++----------
 sound/pci/hda/patch_realtek.c  |  22 ++--
 sound/pci/hda/patch_sigmatel.c |   4 +-
 sound/pci/hda/patch_via.c      |  10 +-
 9 files changed, 328 insertions(+), 121 deletions(-)

-- 
1.9.1
