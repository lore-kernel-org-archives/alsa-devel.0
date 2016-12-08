From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH 0/2] Generic HDMI codec: Add channel mapping
	control
Date: Thu, 8 Dec 2016 17:37:45 +0100
Message-ID: <1481215067-19362-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A0C12674F1
 for <alsa-devel@alsa-project.org>; Thu,  8 Dec 2016 17:37:55 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org
Cc: kernel@stlinux.com, Takashi Iwai <tiwai@suse.de>, lgirdwood@gmail.com, Jyri Sarha <jsarha@ti.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, David Airlie <airlied@linux.ie>, broonie@kernel.org, Daniel Vetter <daniel.vetter@intel.com>
List-Id: alsa-devel@alsa-project.org

Aim of this patch is to add  'Playback Channel Map' control to export 
audio capabilities in term of HDMI sink speakers allocation.
This patch follow discussion initiates here: 
[RFC] ASOC: HDMI audio info frame speaker allocation
http://www.spinics.net/lists/alsa-devel/msg57363.html

The code is fully inspired from HDA driver.
On hw_param, HDMI sink speaker capabilities are exported via TLV ops
and  a CEA allocation is choson, based on ELD information and the number of
channels requested by user.

Mains differences with HDA implementation are:
 - Control is read only
 - Channel swap is not supported. Consequence is that unused channel in
   the mid of CEA audio infoframe channel mapping are considered as
   active.
   example for channel allocation 0x02: FL, FR, 0, FC)
	This configuration is only available for a 4 channels stream.
  - Channel allocation table has been reordered and HDMI 2.0 is not
    supported.

Arnaud Pouliquen (2):
  DRM: add help to get ELD speaker allocation
  ASoC: hdmi-codec: add channel mapping control

 include/drm/drm_edid.h        |  13 ++
 sound/soc/codecs/hdmi-codec.c | 346 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 358 insertions(+), 1 deletion(-)

-- 
1.9.1
