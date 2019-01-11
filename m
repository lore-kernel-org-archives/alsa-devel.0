From: Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v2 0/5] Stripe control functionality
Date: Fri, 11 Jan 2019 22:52:03 +0530
Message-ID: <1547227328-32558-1-git-send-email-spujar@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com [216.228.121.64])
 by alsa0.perex.cz (Postfix) with ESMTP id 57D20266914
 for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2019 18:22:27 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Sameer Pujar <spujar@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Background
==========

Azalia Controller fetches command and audio data via DMA and send them
to codec through SDO(Serial Data Out) lines. SDO is for outboung and it
broadcasts to all codecs. There is atleast one SDO line present, but
there can be multiple SDO lines supported for extended bandwidth. This
is essential when a platform supports multiple hdmi/dp sinks and there
is a requirement for higher resolution audio playback. In such cases
simultaneous audio playback data can be striped across multiple SDOs.

Global Capabilities(GCAP) Register indicates the capabilities of the
controller. Bits 2:1 of GCAP can be read to know the number of supported
SDO lines (below is from HD audio spec)
  00: 1 SDO
  01: 2 SDO
  10: 4 SDO
  11: Reserved

Stripe control verb reports and controls the stripe capability of an
Audio Output Converter. This verb needs to be implemented only for an
audio output converter and only if the stripe bit of the Audio Widget
Capabilities parameter is 1. 
Stripe control: get code(0xf24) and set code(0x724)

Change log
==========

v1-->v2:
-------- 
  Patch 1: "ALSA: hda: add verbs for stripe control"
    * no change

  Patch 2: "ALSA: hda: Add api to program stripe control bits"
    * no change

  Patch 3: "ALSA: hda: add register offset for stripe control"
    * added mask for stripe control programming

  Patch 4: "ALSA: hda: program stripe bits for controller"
    * used stripe control mask instead of hard coded value

  Patch 5: "ALSA: hda: program stripe control for codec"
    * added conditional check to know if striping is supported.
      If supported, then only stripe verb is implemented.

===========

Sameer Pujar (5):
  ALSA: hda: add verbs for stripe control
  ALSA: hda: Add api to program stripe control bits
  ALSA: hda: add register offset for stripe control
  ALSA: hda: program stripe bits for controller
  ALSA: hda: program stripe control for codec

 include/sound/hda_register.h |  2 ++
 include/sound/hda_verbs.h    |  2 ++
 include/sound/hdaudio.h      |  3 +++
 sound/hda/hdac_stream.c      | 40 ++++++++++++++++++++++++++++++++++++++++
 sound/pci/hda/patch_hdmi.c   | 10 +++++++++-
 5 files changed, 56 insertions(+), 1 deletion(-)

-- 
2.7.4


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
