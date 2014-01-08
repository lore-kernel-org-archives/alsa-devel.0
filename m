From: mengdong.lin@intel.com
Subject: [PATCH 0/3] ALSA: hda - enable display audio for Intel
	Broadwell
Date: Wed,  8 Jan 2014 15:55:07 -0500
Message-ID: <cover.1389214150.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id ACE9F2651FC
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 04:50:18 +0100 (CET)
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
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

The following patches enable HDMI/DP audio for Intel Broadwell platform from
audio driver side. Gfx driver just reuses Haswell audio enabling code.

Mengdong Lin (3):
  ALSA: hda - add device ID for Broadwell display audio controller
  ALSA: hda - add codec ID for Broadwell display audio codec
  ALSA: hda/hdmi - apply all Haswell fix-ups to Broadwell display codec

 sound/pci/hda/hda_intel.c  |  3 +++
 sound/pci/hda/patch_hdmi.c | 17 +++++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

-- 
1.8.1.2
