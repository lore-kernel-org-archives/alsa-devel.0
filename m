From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 0/4] ALSA: control: return payload length
	of TLV operation
Date: Tue, 30 Aug 2016 08:44:41 +0900
Message-ID: <1472514285-3769-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 00D4B26648B
 for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2016 01:44:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, broonie@linaro.org, omair.m.abdullah@intel.com
List-Id: alsa-devel@alsa-project.org

Hi,

ALSA control interface has a feature named TLV. This is originally designed
to transfer information about threshold level. Later, it's used for I/O
operation.

In current implementation of this feature, length of handled data is not
returned to applications. This is not better as a feature related to I/O.

This patchset attempts to improve this feature so that the length is
returned to application in a 'length' field of tlv packet structure
(struct snd_ctl_tlv).

Takashi Sakamoto (4):
  ALSA: control: return payload length for TLV operation
  ALSA: control: delegate checking the length of data payload to each
    drivers
  ALSA: control: add kerneldoc for snd_kcontrol_tlv_rw_t
  ALSA: control: bump up protocol version to 2.0.8

 include/sound/control.h      | 22 ++++++++++++++++++++--
 include/sound/soc.h          |  2 +-
 include/uapi/sound/asound.h  |  2 +-
 sound/core/control.c         | 30 +++++++++++++++++++-----------
 sound/core/pcm_lib.c         | 15 ++++++++-------
 sound/core/vmaster.c         |  2 +-
 sound/hda/hdmi_chmap.c       | 16 +++++++++-------
 sound/pci/hda/hda_codec.c    | 12 ++++++++----
 sound/pci/hda/hda_local.h    |  4 ++--
 sound/pci/hda/patch_ca0132.c |  2 +-
 sound/pci/lola/lola_mixer.c  |  7 +++++--
 sound/soc/soc-ops.c          |  9 +++++----
 sound/usb/mixer.c            |  7 +++++--
 sound/usb/mixer.h            |  2 +-
 sound/usb/stream.c           | 13 ++++++++-----
 15 files changed, 94 insertions(+), 51 deletions(-)

-- 
2.7.4
