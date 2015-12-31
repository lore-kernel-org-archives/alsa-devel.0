From: libin.yang@linux.intel.com
Subject: [PATCH 0/4] ALSA: hda - hdmi jack support for dynamic
	pcm assignment
Date: Thu, 31 Dec 2015 09:22:18 +0800
Message-ID: <1451524942-17288-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A2FF265AD8
 for <alsa-devel@alsa-project.org>; Thu, 31 Dec 2015 02:25:19 +0100 (CET)
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

The patchset adds hdmi jack support for dynamic pcm assignment

Libin Yang (4):
  ALSA: Add documentation about HD-audio DP MST
  ALSA: hda - add hdmi_pcm to manage hdmi pcm related features
  ALSA: hda - hdmi jack created based on pcm
  ALSA: hda - hdmi monitor hotplug support for dynamic pcm assignment

 Documentation/sound/alsa/HD-Audio-DP-MST-audio.txt |  75 +++++++
 sound/pci/hda/patch_hdmi.c                         | 229 +++++++++++++++------
 2 files changed, 243 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/sound/alsa/HD-Audio-DP-MST-audio.txt

-- 
1.9.1
