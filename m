From: srinivas.kandagatla@linaro.org
Subject: [PATCH v2 0/6] ASoC: codecs: msm8916-wcd-analog: Add
	support to MBHC
Date: Wed,  2 Aug 2017 19:09:24 +0200
Message-ID: <20170802170930.26083-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f53.google.com (mail-it0-f53.google.com
 [209.85.214.53])
 by alsa0.perex.cz (Postfix) with ESMTP id CDC4B266847
 for <alsa-devel@alsa-project.org>; Wed,  2 Aug 2017 19:09:42 +0200 (CEST)
Received: by mail-it0-f53.google.com with SMTP id v127so25713508itd.0
 for <alsa-devel@alsa-project.org>; Wed, 02 Aug 2017 10:09:42 -0700 (PDT)
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
Cc: damien.riegel@savoirfairelinux.com, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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

Damien sent a similar patchset to add support to mechanical detection,
but that patch has issues and will not work on most usecases (for example
after a playback/capture session, multicodec case). So I only picked up
the BIT mask patch from that series.

Tested it on DB410c with Audio Mezz board with 4 pole and 3 pole
and during playback and recording use cases.

Changes since v1(https://www.spinics.net/lists/kernel/msg2565463.html):
	- Micbias left to hardware default value suggested by Mark.
	- Updated commit log to reflect low power state for mbhc
	- cleaned up code spotted by Mark.
	- Moved the button voltage threshold to dt, suggested by Mark
	- Fixed key release issue reported by Damien

Srinivas Kandagatla (6):
  ASoC: jack: fix snd_soc_codec_set_jack return error
  ASoC: codecs: msm8916-wcd-analog: move codec reset to probe
  ASoC: codecs: msm8916-wcd-analog: get micbias voltage from dt
  ASoC: codecs: msm8916-wcd-analog: add MBHC support
  ASoC: qcom: apq8016-sbc: Add support to Headset JACK
  arm64: dts: apq8016-sbc: add mbhc buttons support

 .../bindings/sound/qcom,msm8916-wcd-analog.txt     |  18 +-
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          |   2 +
 sound/soc/codecs/msm8916-wcd-analog.c              | 412 +++++++++++++++++++--
 sound/soc/qcom/apq8016_sbc.c                       |  34 ++
 sound/soc/soc-jack.c                               |   2 +-
 5 files changed, 444 insertions(+), 24 deletions(-)

-- 
2.9.3
