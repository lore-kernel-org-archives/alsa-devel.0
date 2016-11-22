From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [RFC v2 0/3] ALSA controls management using
	index/device/sub-devices fields
Date: Tue, 22 Nov 2016 11:53:13 +0100
Message-ID: <1479811996-2238-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 230E1266801
 for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2016 11:53:37 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, lgirdwood@gmail.com, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

V2:

Aim of this version is to continue discussion on DAI PCM control focused on ASoC drivers.
In this V2  implementation in Soc-core is simplified to limit impact on existing code.
Proposal is to add field in DAI driver struct to declare PCM controls that
need to be linked to PCM character device on DAI link probing.

 Update of the RFC V1 based on discussions:
 - [RFC 4/4] iecset: allow to select control with device and sub-device numbers
 	no more part of the RFC V2, will be discussed in a separate thread
 - [RFC 2/4] ALSA: control: increment index field for duplicated control.
 	no more part of the RFC V2, no more need as RFC subject is PCM controls
   
- [RFC V2 1/3] ASoC: core: allow DAI PCM controls bound to PCM device
	Patch reworked from V1 to simplify implementation
        - Binding is not done for Dai links tagged with no_pcm (DPCM).
        - no more possibility to add the controls after the DAI link probing.

- [RFC V2 2/3]   ASoC: sti: bind PCM controls to PCM device.
- [RFC V2 3/3]   ASoC: hdmi-codec: Example of PCM control bound to PCM device for multi
        Example of implementation in STI DAI driver and HDMI-codec drivers
        
V1: 
 http://www.spinics.net/lists/alsa-devel/msg56479.html

 1) Alsa-utils patch

- iecset: allow to select control with device and sub-device numbers
  This patch allows to access to 2 iec controls differentiated by
  device/sub-devices numbers
=> For me, this patch is mandatory to be able to address the ASoC IEC
   controls, in case of no fix is implemented to allows index field
   update in ASoC.

2) Alsa driver patches
  - ASoC: core: allow PCM control binding to PCM device
  	Add relationship between DAIs PCM controls and PCM device.

  - ALSA: control: increment index field for duplicated control.
   	Generic implementation of the patch proposed in HDA driver
        (http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/?id=ea9b43add)

  - ASoC: sti: use bind_pcm_ctl
  	implementation of bind_pcm_ctl for sti driver.

Arnaud Pouliquen (3):
  ASoC: core: allow DAI PCM controls bound to PCM device
  ASoC: sti: bind pcm controls to pcm device.
  ASoC: hdmi-codec: Example of PCM control bound to PCM device for multi
    HDMI DAIs.

Regards,

Arnaud

 include/sound/soc-dai.h       |  4 ++++
 sound/soc/codecs/hdmi-codec.c |  4 ++--
 sound/soc/soc-core.c          | 37 +++++++++++++++++++++++++++++++++++++
 sound/soc/sti/sti_uniperif.c  | 33 ++++-----------------------------
 4 files changed, 47 insertions(+), 31 deletions(-)

-- 
1.9.1
