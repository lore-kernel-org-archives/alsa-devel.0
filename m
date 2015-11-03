From: libin.yang@linux.intel.com
Subject: [RFC PATCH 0/2] ALSA: hda - DP MST audio for Jack
	support
Date: Tue,  3 Nov 2015 16:42:54 +0800
Message-ID: <1446540176-110181-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 5402026053B
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2015 09:44:29 +0100 (CET)
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
Cc: libin.yang@intel.com, Libin Yang <libin.yang@linux.intel.com>, mengdong.lin@linux.intel.com
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@linux.intel.com>

This is the patch set for Jack support for DP MST audio

Libin Yang (2):
  ALSA: hda - jack support DP MST audio
  ALSA: hda - hdmi audio add dynamically jack binding to pin

 sound/pci/hda/hda_jack.c   | 186 ++++++++++++++++++++++++++++++++++++++++-----
 sound/pci/hda/hda_jack.h   |  32 +++++++-
 sound/pci/hda/patch_hdmi.c | 116 ++++++++++++++++++++++------
 3 files changed, 288 insertions(+), 46 deletions(-)

-- 
1.9.1
