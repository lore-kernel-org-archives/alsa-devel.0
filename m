From: libin.yang@linux.intel.com
Subject: [RFC PATCH 0/2] ALSA: hda - patch set for DP MST audio
	support
Date: Tue,  3 Nov 2015 16:22:51 +0800
Message-ID: <1446538973-109373-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 57542260505
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2015 09:24:15 +0100 (CET)
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
Cc: Libin Yang <libin.yang@linux.intel.com>, mengdong.lin@linux.intel.com
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@linux.intel.com>

This is one of the patch sets to support DP MST audio.
This patch set is to support dynamic PCM attachment to pin

As there are still other patches, it may be better to put the patches in
a specific branch?

Libin Yang (2):
  ALSA: hda - add hda_dev_t typedef for DP MST audio
  ALSA: hda - HDMI codec driver dynamically attach PCM

 include/sound/hdaudio.h    |   1 +
 sound/pci/hda/hda_codec.c  |   5 +-
 sound/pci/hda/hda_codec.h  |   1 +
 sound/pci/hda/patch_hdmi.c | 170 +++++++++++++++++++++++++++++++++++++++++----
 4 files changed, 163 insertions(+), 14 deletions(-)

-- 
1.9.1
