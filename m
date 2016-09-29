From: libin.yang@linux.intel.com
Subject: [RFC PATCH v2 0/2] support DP MST audio
Date: Thu, 29 Sep 2016 10:22:20 +0800
Message-ID: <1475115742-146473-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id BFE2C2614A0
 for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2016 04:27:02 +0200 (CEST)
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

Libin Yang (2):
  ALSA: hda - add DP mst verb support
  ALSA: hda - add DP mst audio support

 sound/pci/hda/hda_codec.c  |  77 +++++++++++++++-
 sound/pci/hda/hda_codec.h  |   3 +
 sound/pci/hda/patch_hdmi.c | 216 ++++++++++++++++++++++++++++++++++-----------
 3 files changed, 241 insertions(+), 55 deletions(-)

-- 
1.9.1
