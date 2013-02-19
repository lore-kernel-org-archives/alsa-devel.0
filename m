From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH v5 0/5] Make HDMI ELD usable for hotplug
Date: Tue, 19 Feb 2013 16:11:21 +0100
Message-ID: <1361286686-21884-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 7302D26522F
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2013 16:11:22 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: fengguang.wu@intel.com, pierre-louis.bossart@linux.intel.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Just more fixups according to Takashi's comments.

David Henningsson (5):
  ALSA: hda - hdmi: ELD shouldn't be valid after unplug
  ALSA: hda - hdmi: Do not expose eld data when eld is invalid
  ALSA: hda - hdmi: Refactor hdmi_eld into parsed_hdmi_eld
  ALSA: hda - hdmi: Protect ELD buffer
  ALSA: hda - hdmi: Notify userspace when ELD control changes

 sound/pci/hda/hda_eld.c    |   52 +++++++++++-----------
 sound/pci/hda/hda_local.h  |   28 +++++++-----
 sound/pci/hda/patch_hdmi.c |  105 ++++++++++++++++++++++++++++++++++----------
 3 files changed, 127 insertions(+), 58 deletions(-)

-- 
1.7.9.5
