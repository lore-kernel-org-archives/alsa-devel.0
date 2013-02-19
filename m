From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH v3 0/5] Make HDMI ELD usable for hotplug
Date: Tue, 19 Feb 2013 11:51:09 +0100
Message-ID: <1361271074-17555-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B222B2651D2
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2013 11:51:10 +0100 (CET)
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

Changes since v2: Added refactoring patch to split hdmi_eld into
hdmi_eld and parsed_hdmi_eld.

David Henningsson (5):
  ALSA: hda - hdmi: ELD shouldn't be valid after unplug
  ALSA: hda - hdmi: Do not expose eld data when eld is invalid
  ALSA: hda - hdmi: Refactor hdmi_eld into parsed_hdmi_eld
  ALSA: hda - hdmi: Protect ELD buffer
  ALSA: hda - hdmi: Notify userspace when ELD control changes

 sound/pci/hda/hda_eld.c    |   47 ++++++++++++++----------
 sound/pci/hda/hda_local.h  |   23 +++++++-----
 sound/pci/hda/patch_hdmi.c |   86 +++++++++++++++++++++++++++++++++-----------
 3 files changed, 107 insertions(+), 49 deletions(-)

-- 
1.7.9.5
