From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [RFC 0/4] ALSA controls management using
	index/device/sub-devices fields
Date: Tue, 8 Nov 2016 09:11:11 +0100
Message-ID: <1478592675-23092-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D9401266EEF
 for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2016 09:13:11 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

I tried to summarize my observation based on discussions concerning the
instantiation of the ALSA controls, initiate in following thread:
[PATCH] ASoC: core: allow control index different from 0 
    https://www.spinics.net/lists/ALSA-devel/msg55415.html

My test environment: sti platform, 3 playback devices with associated instances of controls

card 0: STIB2120 [STI-B2120], device 0: Uni Player #0 (HDMI)-i2s-hifi 
	numid=1,iface=PCM,name='ELD'
	numid=3,iface=PCM,name='IEC958 Playback Default'
	numid=2,iface=PCM,name='PCM Playback Oversampling Freq.
				Adjustment'
card 0: STIB2120 [STI-B2120], device 1: Uni Player #2 (DAC)-sas-dai-dac 
	numid=4,iface=PCM,name='PCM Playback Oversampling Freq.
				Adjustment',device=2
card 0: STIB2120 [STI-B2120], device 2: Uni Player #3 (SPDIF)-sas-dai-
spdif-out
	numid=6,iface=PCM,name='IEC958 Playback Default',device=2
	numid=5,iface=PCM,name='PCM Playback Oversampling Freq.
				Adjustment',device=3

1) From user land point of view 

1-1) How to Instantiate generic ALSA control

The  point is the handling of multi instance of generic ALSA controls.
In this case "prefix" can not be used. Controls have to be identified
by a combination of device/sub-device/index

Examples of controls that seem generics:
iface=PCM,name='Capture Channel Map'
iface=PCM,name='Playback Channel Map'
iface=PCM,name='ELD'

iface=MIXER,name='Master Playback Switch'
iface=MIXER,name='Master Playback Volume'
iface=MIXER,name='Capture Switch'
iface=MIXER,name='Capture Volume'

iface=MIXER/PCM,name='IEC958 Playback Con Mask'
iface=MIXER/PCM,name='IEC958 Playback Pro Mask'
iface=MIXER/PCM,name='IEC958 Playback Default'
iface=MIXER/PCM,name='IEC958 Playback Switch'

1-2) Different ways of using control instantiation
 Here is a short benchmark on applications using ALSA controls:
- iecset and "amixer scontrols" base control instantiation on "index".
- GStreamer and pulseaudio seems based on "device" (through the ALSA
  card conf files).
- "amixer controls" support both.

 I supposse that this is the reason why "device" and "index fields
  are  both fixed in HDA-intel.cong aligned with driver.  

1-3) Questions:
   - If i consider description provided by Takashi Sakamoto in thread:
    https://www.spinics.net/lists/ALSA-devel/msg55451.html

    Should we always apply this rules?
      - MIXER control type: as it is not linked to PCM device but card,
	"index" is used to instantiate control.
      - PCM control type: as it is linked to PCM device,
        "device/subdevice" is used to instantiate control.
    Or could we consider that a control can be instantiated using
      device/subdevice fields  and/or index fields?

   - Concerning IEC controls, should we consider them as PCM or MIXER
     type controls? In current implementations both are used...

2) From driver point of view

2-1) None SOC drivers:
Today solution seems to base indexation on both "index" and "device"
number. Device indexation seems not linked to PCM device number
Example in  ea9b43addc4d ("ALSA: hda - Fix broken workaround for HDMI/SPDIF conflicts").
http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/?id=ea9b43add

=> The drawback is that each driver has to implement it. Could be nice
   to have in generic code....

2-2) SOC drivers:
  -  it is not possible to use "index" using helper functions as
    snd_soc_cnew forces index to 0.
    Solution could be to implement in soc_core as done in HDA driver. 
   => duplication of the code in ASoC and None ASoC drivers.
  - Relation chip between control and PCM device. if rules mentioned
    in 1-3 should be respected, need to link control to PCM device.
    This point seems quite tricky... At least DAI controls can be
    simply linked to PCM device during DAI-link probing. 	

3) Patches proposed:
Based on these observations, here are some patches that i tested in my
environment. There are complementary,  and could answer to some 
limitations mentioned above.
  
3-1) Alsa-utils patch

- iecset: allow to select control with device and sub-device numbers
  This patch allows to access to 2 iec controls differentiated by
  device/sub-devices numbers
=> For me, this patch is mandatory to be able to address the ASoC IEC
   controls, in case of no fix is implemented to allows index field
   update in ASoC.

3-2) Alsa driver patches
  - ASoC: core: allow PCM control binding to PCM device
  	Add relationship between DAIs PCM controls and PCM device.

  - ALSA: control: increment index field for duplicated control.
   	Generic implementation of the patch proposed in HDA driver
        (http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/?id=ea9b43add)

  - ASoC: sti: use bind_pcm_ctl
  	implementation of bind_pcm_ctl for sti driver.
        
 Best Regards,
 Arnaud
-- 
1.9.1
