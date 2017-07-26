From: srinivas.kandagatla@linaro.org
Subject: [PATCH v1 0/6] ASoC: codecs: msm8916-wcd-analog: Add
	support to MBHC
Date: Wed, 26 Jul 2017 02:35:06 +0200
Message-ID: <20170726003512.18965-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f52.google.com (mail-it0-f52.google.com
 [209.85.214.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 36899267354
 for <alsa-devel@alsa-project.org>; Wed, 26 Jul 2017 02:35:24 +0200 (CEST)
Received: by mail-it0-f52.google.com with SMTP id v127so13341388itd.0
 for <alsa-devel@alsa-project.org>; Tue, 25 Jul 2017 17:35:24 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patchset adds support to MBHC(Multibutton headset control) block in PM8916
analog block. MBHC support comes from2 blocks first mechanical headset detection
and second headset type, 5 button detection.

This patchset adds support to:
1> Support to NC and NO type of headset Jacks.
2> Mechanical insertion and detection of headset jack.
3> Detect a 3 pole Headphone and a 4 pole Headset.
4> Detect 5 buttons.

First patch fixes error code returned by snd_soc_codec_set_jack() to be
more precise for users. Second patch is patch from Damien, followed by few
fixes to codec driver w.r.t mbhc and final patch to add mbhc support.

Damien sent a similar patchset to add support to mechanical detection,
but that patch has issues and will not work on most usecases (for example
after a playback/capture session, multicodec case). So I only picked up
the BIT mask patch from that series.

Tested it on DB410c with Audio Mezz board with 4 pole and 3 pole
and during playback and recording use cases.

root@linaro-alip:~# evtest 
No device specified, trying to scan all of /dev/input/event*
Available devices:
/dev/input/event0:      pm8941_pwrkey
/dev/input/event1:      DB410c Headset Jack
/dev/input/event2:      gpio_keys
Select the device event number [0-2]: 1
Input driver version is 1.0.1
Input device ID: bus 0x0 vendor 0x0 product 0x0 version 0x0
Input device name: "DB410c Headset Jack"
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 114 (KEY_VOLUMEDOWN)
    Event code 115 (KEY_VOLUMEUP)
    Event code 226 (KEY_MEDIA)
    Event code 260 (BTN_4)
    Event code 582 (KEY_VOICECOMMAND)
  Event type 5 (EV_SW)
    Event code 2 (SW_HEADPHONE_INSERT) state 1
    Event code 4 (SW_MICROPHONE_INSERT) state 1
Properties:
Testing ... (interrupt to exit)
Event: time 1501001112.059684, type 1 (EV_KEY), code 226 (KEY_MEDIA), value 1
Event: time 1501001112.059684, type 5 (EV_SW), code 2 (SW_HEADPHONE_INSERT), value 0
Event: time 1501001112.059684, type 5 (EV_SW), code 4 (SW_MICROPHONE_INSERT), value 0
Event: time 1501001112.059684, -------------- SYN_REPORT ------------
Event: time 1501001112.254116, type 1 (EV_KEY), code 226 (KEY_MEDIA), value 0
Event: time 1501001112.254116, -------------- SYN_REPORT ------------
Event: time 1501001113.154184, type 1 (EV_KEY), code 114 (KEY_VOLUMEDOWN), value 1
Event: time 1501001113.154184, -------------- SYN_REPORT ------------
Event: time 1501001113.319658, type 1 (EV_KEY), code 114 (KEY_VOLUMEDOWN), value 0
Event: time 1501001113.319658, -------------- SYN_REPORT ------------
Event: time 1501001113.781084, type 1 (EV_KEY), code 226 (KEY_MEDIA), value 1
Event: time 1501001113.781084, -------------- SYN_REPORT ------------
Event: time 1501001114.024930, type 1 (EV_KEY), code 226 (KEY_MEDIA), value 0
Event: time 1501001114.024930, -------------- SYN_REPORT ------------
Event: time 1501001114.419082, type 1 (EV_KEY), code 114 (KEY_VOLUMEDOWN), value 1
Event: time 1501001114.419082, -------------- SYN_REPORT ------------
Event: time 1501001114.576011, type 1 (EV_KEY), code 114 (KEY_VOLUMEDOWN), value 0
Event: time 1501001114.576011, -------------- SYN_REPORT ------------
Event: time 1501001114.795281, type 1 (EV_KEY), code 114 (KEY_VOLUMEDOWN), value 1
Event: time 1501001114.795281, -------------- SYN_REPORT ------------
Event: time 1501001114.863333, type 1 (EV_KEY), code 114 (KEY_VOLUMEDOWN), value 0
Event: time 1501001114.863333, -------------- SYN_REPORT ------------
Event: time 1501001116.603372, type 1 (EV_KEY), code 226 (KEY_MEDIA), value 1
Event: time 1501001116.603372, -------------- SYN_REPORT ------------
Damien Riegel (1):
  ASoC: codecs: msm8916-analog: fix DIG_CLK_CTL_RXD3_CLK_EN define

Srinivas Kandagatla (5):
  ASoC: jack: fix snd_soc_codec_set_jack return error
  ASoC: codecs: msm8916-wcd-analog: move codec reset to probe
  ASoC: codecs: msm8916-wcd-analog: set default micbias voltage to 1.8
  ASoC: codecs: msm8916-wcd-analog: add MBHC support
  ASoC: qcom: apq8016-sbc: Add support to Headset JACK

 .../bindings/sound/qcom,msm8916-wcd-analog.txt     |   9 +
 sound/soc/codecs/msm8916-wcd-analog.c              | 359 +++++++++++++++++++--
 sound/soc/codecs/msm8916-wcd.h                     |  12 +
 sound/soc/qcom/apq8016_sbc.c                       |  52 +++
 sound/soc/soc-jack.c                               |   2 +-
 5 files changed, 410 insertions(+), 24 deletions(-)
 create mode 100644 sound/soc/codecs/msm8916-wcd.h

-- 
2.9.3
