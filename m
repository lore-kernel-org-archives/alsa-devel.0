From: libin.yang@linux.intel.com
Subject: [RFC PATCH v3 0/3] support DP MST audio
Date: Thu, 13 Oct 2016 15:49:34 +0800
Message-ID: <1476344977-147193-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id BA42926576D
 for <alsa-devel@alsa-project.org>; Thu, 13 Oct 2016 09:54:48 +0200 (CEST)
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
  ALSA: hda - add DP mst verb support
  ALSA: hda - add DP mst audio support
  ALSA: Documentation about HDA DP MST pin init and connection

 Documentation/sound/alsa/HD-Audio-DP-MST-audio.txt |  17 ++
 sound/pci/hda/hda_codec.c                          |  77 ++++++-
 sound/pci/hda/hda_codec.h                          |   3 +
 sound/pci/hda/patch_hdmi.c                         | 243 ++++++++++++++++-----
 4 files changed, 285 insertions(+), 55 deletions(-)

-- 
1.9.1
