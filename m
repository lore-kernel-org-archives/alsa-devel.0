From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] ASoC: sti: Add CPU DAI driver for playback
Date: Fri, 28 Apr 2017 14:28:41 +0300
Message-ID: <20170428112841.ictuhyfhzwvcmlhv@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 4989C266860
 for <alsa-devel@alsa-project.org>; Fri, 28 Apr 2017 13:28:52 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: arnaud.pouliquen@st.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Arnaud Pouliquen,

The patch 76c2145ded6b: "ASoC: sti: Add CPU DAI driver for playback"
from Jun 22, 2015, leads to the following static checker warning:

    sound/soc/sti/uniperif_player.c:1077 uni_player_init()
    warn: unused return: ret = PTR_ERR()

sound/soc/sti/uniperif_player.c
  1047  int uni_player_init(struct platform_device *pdev,
  1048                      struct uniperif *player)
  1049  {
  1050          int ret = 0;
  1051  
  1052          player->dev = &pdev->dev;
  1053          player->state = UNIPERIF_STATE_STOPPED;
  1054          player->dai_ops = &uni_player_dai_ops;
  1055  
  1056          /* Get PCM_CLK_SEL & PCMP_VALID_SEL from audio-glue-ctrl SoC reg */
  1057          ret = uni_player_parse_dt_audio_glue(pdev, player);
  1058  
  1059          if (ret < 0) {
  1060                  dev_err(player->dev, "Failed to parse DeviceTree\n");
  1061                  return ret;
  1062          }
  1063  
  1064          /* Underflow recovery is only supported on later ip revisions */
  1065          if (player->ver >= SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0)
  1066                  player->underflow_enabled = 1;
  1067  
  1068          if (UNIPERIF_TYPE_IS_TDM(player))
  1069                  player->hw = &uni_tdm_hw;
  1070          else
  1071                  player->hw = &uni_player_pcm_hw;
  1072  
  1073          /* Get uniperif resource */
  1074          player->clk = of_clk_get(pdev->dev.of_node, 0);
  1075          if (IS_ERR(player->clk)) {
  1076                  dev_err(player->dev, "Failed to get clock\n");
  1077                  ret = PTR_ERR(player->clk);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^
This should probably be "return PTR_ERR(player->clk);?  Can we run
without a clk?

  1078          }
  1079  
  1080          /* Select the frequency synthesizer clock */
  1081          if (player->clk_sel) {
  1082                  ret = regmap_field_write(player->clk_sel, 1);
  1083                  if (ret) {
  1084                          dev_err(player->dev,
  1085                                  "%s: Failed to select freq synth clock\n",
  1086                                  __func__);
  1087                          return ret;
  1088                  }
  1089          }

regards,
dan carpenter
