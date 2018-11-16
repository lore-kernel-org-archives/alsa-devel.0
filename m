From: Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH 0/2] ASoC: SDM845: Update MI2S and TDM configuration
Date: Fri, 16 Nov 2018 13:11:56 +0530
Message-ID: <1542354118-23360-1-git-send-email-rohitkr@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: plai@codeaurora.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com, srinivas.kandagatla@linaro.org
Cc: Rohit kumar <rohitkr@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

Update bit clock rate, slot width for TDM and MI2S
interfaces. Also add support for secondary MI2S TX
interface in SDM845 machine driver.

Rohit kumar (2):
  ASoC: sdm845: Update slot_width for Quaternary TDM port
  ASoC: sdm845: Add support for Secondary MI2S interface

 sound/soc/qcom/sdm845.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
