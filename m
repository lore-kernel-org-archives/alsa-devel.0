From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 0/3] Make HDMI ELD usable with hotplug
Date: Mon, 18 Feb 2013 14:11:10 +0100
Message-ID: <1361193073-7199-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B91E7264FEB
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2013 14:11:14 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org, fengguang.wu@intel.com, pierre-louis.bossart@linux.intel.com
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

I'm experimenting with using ELD information in PulseAudio and found
that it didn't work very well with hotplugging.
Neither the proc file nor the ELD kcontrol was cleared correctly after
unplug, and there was no way (except polling) to find out when ELD
has become available.

Could use advice on which ones of these that should or should not
be sent to stable.

David Henningsson (3):
  ALSA: hda - hdmi: ELD shouldn't be valid after unplug
  ALSA: hda - hdmi: Do not expose eld data when eld is invalid
  ALSA: hda - hdmi: Notify userspace when ELD control changes

 sound/pci/hda/patch_hdmi.c |   35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

-- 
1.7.9.5
