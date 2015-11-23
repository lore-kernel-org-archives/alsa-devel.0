From: libin.yang@linux.intel.com
Subject: [RFC V2 PATCH 0/5] hdmi audio dynamically bind PCM to
	pin
Date: Mon, 23 Nov 2015 22:09:28 +0800
Message-ID: <1448287774-146673-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id E4A8D26145E
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 15:12:25 +0100 (CET)
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

The patches are trying to support dynamically binding PCM to pin
in HDMI/DP audio.

The pin will not bind to any PCM if there is not monitor connected.
When there is a monitor connected to the port (pin), driver will
try to find a proper PCM to assign to the port and setup the pin
if necessary.

Libin Yang (5):
  ALSA: hda - hdmi playback without monitor in dynamic pcm bind mode
  ALSA: hda - hdmi operate spdif based on pcm
  ALSA: hda - hdmi dynamically bind PCM to pin when monitor hotplug
  ALSA: hda - add in_use flag in hda_pcm
  ALSA: hda - hdmi setup pin when monitor hotplug in pcm dynamic
    assignment mode

 sound/pci/hda/hda_codec.h  |   1 +
 sound/pci/hda/patch_hdmi.c | 361 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 343 insertions(+), 19 deletions(-)

-- 
1.9.1
