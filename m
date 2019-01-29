From: b_lkasam@codeaurora.org
Subject: Async ops SOC compress issue
Date: Tue, 29 Jan 2019 12:55:14 +0530
Message-ID: <2c502243cbd2281fabea150cedb56dc1@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 7AB1C26749A
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2019 09:03:07 +0100 (CET)
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
Cc: c_spanic@qti.qualcomm.com, lkasam@qti.qualcomm.com, c_smanag@qti.qualcomm.com
List-Id: alsa-devel@alsa-project.org

Hi ALSA team,
Need inputs wrt one issue seen with soc-compress code.

Please help check below issue seen in soc-compress file wrt handling 
multiple BEs
with async ops ASYNC_DPCM_SND_SOC_HW_PARAMS set for given FE dailink/BE 
dailinks also.

Issue :
pcm_prepare failure when 2 BE's on same FE enabled during compress 
playback,
seen only when both BE's have SOC_HW_PARAM defined as an async_op.

Analysis:
- With SOC_HW_PARAMS defined as async_op on both BE's,
hw_params api for both of these BE's are scheduled for asynchronous 
execution.

- It is observed that dpcm_be_hw_params_prepare is getting invoked 
twice, but for the same BE.

Below are the issue logs taken for above scenario.

12-21 16:38:32.074     0     0 D SDM660 Compress1: connected new DPCM 
playback path SDM660 Compress1 -> INT4_MI2S_RX
12-21 16:38:32.075     0     0 D SDM660 Compress1: connected new DPCM 
playback path SDM660 Compress1 -> INT0_MI2S_RX

12-21 16:38:32.075     0     0 D INT0_MI2S_RX: ASoC: open playback BE 
INT0_MI2S_RX
12-21 16:38:32.076     0     0 D INT4_MI2S_RX: ASoC: open playback BE 
INT4_MI2S_RX

12-21 16:38:32.077     0     0 E soc_compr_set_params_fe: : async 
schedule hw_params for be INT0_MI2S_RX
12-21 16:38:32.077     0     0 E soc_compr_set_params_fe: : async 
schedule hw_params for be INT4_MI2S_RX

12-21 16:38:32.078     0     0 E dpcm_be_hw_params_prepare: : BE 
INT4_MI2S_RX -> dpcm_fe_dai_hw_params_be
12-21 16:38:32.079     0     0 E msm-dai-q6-mi2s soc: 
qcom,msm-dai-mi2s:qcom,msm-dai-q6-int-mi2s4: msm_dai_q6_mi2s_hw_params: 
dai id 11 dai_data->channels = 1

12-21 16:38:32.143     0     0 E dpcm_be_hw_params_prepare: : BE 
INT4_MI2S_RX -> dpcm_fe_dai_hw_params_be
12-21 16:38:32.173     0     0 E msm-dai-q6-mi2s soc: 
qcom,msm-dai-mi2s:qcom,msm-dai-q6-int-mi2s4: msm_dai_q6_mi2s_hw_params: 
ERROR    dai id 11 dai_data->channels = 1

It is not clear why dpcm_be_hw_params_prepare is happening for same BE 
twice even though async schedule was done for both.

- With async_synchronize call after scheduling of hw_param, the behavior 
is as expected.
hw_param for both BE's are success.


diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index ad3cc68..b0a1995 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -535,6 +535,7 @@ static int soc_compr_set_params_fe(struct 
snd_compr_stream *cstream,
                                 }
                         }
                 }
+               async_synchronize_full_domain(&async_domain); - Adding 
this code fixing the issue, but looks not correct way, please suggest
                 for (i = 0; i < j; i++) {
                         cstream->be = be_list[i];
                         dpcm_be_hw_params_prepare(cstream);



With regards
Laxminath Kasam
