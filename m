From: libin.yang@linux.intel.com
Subject: [RFC PATCH 0/2] hdmi audio dynamically bind PCM to pin
Date: Wed, 18 Nov 2015 16:46:57 +0800
Message-ID: <1447836419-34336-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 749FE26051B
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 09:48:51 +0100 (CET)
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

The patches are trying to support dynamically binding PCM to pin in HDMI audio.

The first patch:
When PCM is open when there is no pin (port) bound to the PCM,
the driver try to open the PCM successfully. It will try to find
an available converter to assign to the PCM.
In PCM prepare, if there is no pin bound to the PCM, the driver
will do the simple configuration and return true.
In PCM close, if there is no pin bound to the PCM, the driver will
simply close it.
All the pin configuration will be setup in the hotplug which is done
in patch 2.
As the PCM is dynamically bound to the pin, the pcm_lock is necessary
for the whole pcm open/prepare/close process.

The second patch:
The patch mainly handle the hotplug event.
Each time monitor is connected, a proper PCM will be bound to the pin.
If the PCM is in use, the pin must be configured.
Each time monitor is disconnect, the PCM will be unbound from the pin.
The pin will be reset.

Libin Yang (2):
  ALSA: hda - hdmi playback without monitor in dynamic pcm bind mode
  ALSA: hda - hdmi dynamically bind PCM to pin when monitor hotplug

 sound/pci/hda/hda_codec.h  |   1 +
 sound/pci/hda/patch_hdmi.c | 354 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 337 insertions(+), 18 deletions(-)

-- 
1.9.1
