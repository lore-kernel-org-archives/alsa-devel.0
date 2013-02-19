From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH v2 0/4] Make HDMI ELD usable for hotplug
Date: Tue, 19 Feb 2013 09:47:33 +0100
Message-ID: <1361263657-15888-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 261162651AB
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2013 09:47:34 +0100 (CET)
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
Cc: fengguang.wu@intel.com, pierre-louis.bossart@linux.intel.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

New day, new patches. This time there is a proper lock around
access to the ELD buffer. I hope this satisfies the previous
comments.

I've also tested the patches together with some PulseAudio patches
I'm writing and the notification works just fine. The ELD data
shows up 300 ms after hotplug, so it's likely the first repoll
giving me new ELD data).

David Henningsson (4):
  ALSA: hda - hdmi: ELD shouldn't be valid after unplug
  ALSA: hda - hdmi: Do not expose eld data when eld is invalid
  ALSA: hda - hdmi: protect access to ELD buffer
  ALSA: hda - hdmi: Notify userspace when ELD control changes

 sound/pci/hda/hda_eld.c    |   12 ++++++--
 sound/pci/hda/hda_local.h  |    3 ++
 sound/pci/hda/patch_hdmi.c |   67 +++++++++++++++++++++++++++++++++++---------
 3 files changed, 66 insertions(+), 16 deletions(-)

-- 
1.7.9.5
