From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [bug report] ASoC: sti: Add CPU DAI driver for
	playback
Date: Fri, 28 Apr 2017 14:02:58 +0200
Message-ID: <d217c7f0-f6c2-8f10-a7f1-90ac29f64aab@st.com>
References: <20170428112841.ictuhyfhzwvcmlhv@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 2B52E267348
 for <alsa-devel@alsa-project.org>; Fri, 28 Apr 2017 14:03:02 +0200 (CEST)
In-Reply-To: <20170428112841.ictuhyfhzwvcmlhv@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Dan,

On 04/28/2017 01:28 PM, Dan Carpenter wrote:
> Hello Arnaud Pouliquen,
> 
> The patch 76c2145ded6b: "ASoC: sti: Add CPU DAI driver for playback"
> from Jun 22, 2015, leads to the following static checker warning:
> 
>     sound/soc/sti/uniperif_player.c:1077 uni_player_init()
>     warn: unused return: ret = PTR_ERR()
> 
> sound/soc/sti/uniperif_player.c
>   1047  int uni_player_init(struct platform_device *pdev,
>   1048                      struct uniperif *player)
>   1049  {
>   1050          int ret = 0;
>   1051  
>   1052          player->dev = &pdev->dev;
>   1053          player->state = UNIPERIF_STATE_STOPPED;
>   1054          player->dai_ops = &uni_player_dai_ops;
>   1055  
>   1056          /* Get PCM_CLK_SEL & PCMP_VALID_SEL from audio-glue-ctrl SoC reg */
>   1057          ret = uni_player_parse_dt_audio_glue(pdev, player);
>   1058  
>   1059          if (ret < 0) {
>   1060                  dev_err(player->dev, "Failed to parse DeviceTree\n");
>   1061                  return ret;
>   1062          }
>   1063  
>   1064          /* Underflow recovery is only supported on later ip revisions */
>   1065          if (player->ver >= SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0)
>   1066                  player->underflow_enabled = 1;
>   1067  
>   1068          if (UNIPERIF_TYPE_IS_TDM(player))
>   1069                  player->hw = &uni_tdm_hw;
>   1070          else
>   1071                  player->hw = &uni_player_pcm_hw;
>   1072  
>   1073          /* Get uniperif resource */
>   1074          player->clk = of_clk_get(pdev->dev.of_node, 0);
>   1075          if (IS_ERR(player->clk)) {
>   1076                  dev_err(player->dev, "Failed to get clock\n");
>   1077                  ret = PTR_ERR(player->clk);
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^
> This should probably be "return PTR_ERR(player->clk);?  Can we run
> without a clk?
Yes you are right, thanks for highlighting the issue. the clock is
mandatory.

Don't hesitate to propose the patch, i will ack it. Or tell me if you
prefer that i fix it on my side...

Regards
Arnaud
