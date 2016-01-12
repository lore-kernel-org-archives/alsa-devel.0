From: libin.yang@linux.intel.com
Subject: [PATCH v2 0/3] ALSA: hda - hdmi jack support for
	dynamic pcm assignment
Date: Tue, 12 Jan 2016 11:13:24 +0800
Message-ID: <1452568407-20771-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D816260455
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2016 04:16:41 +0100 (CET)
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

Libin Yang (3):
  ALSA: Add documentation about HD-audio DP MST
  ALSA: hda - add hdmi_pcm to manage hdmi pcm related features
  ALSA: hda - hdmi jack created based on pcm

 Documentation/sound/alsa/HD-Audio-DP-MST-audio.txt |  74 ++++++++++++
 sound/pci/hda/patch_hdmi.c                         | 132 ++++++++++++++-------
 2 files changed, 164 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/sound/alsa/HD-Audio-DP-MST-audio.txt

-- 
1.9.1
