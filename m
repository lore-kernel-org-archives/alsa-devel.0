From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] ASoC: dapm: Move connection of CODEC to
	CODEC DAIs
Date: Fri, 7 Sep 2018 21:55:06 +0300
Message-ID: <20180907185506.oxb2ziukeouqmuc6@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by alsa0.perex.cz (Postfix) with ESMTP id 700B626781A
 for <alsa-devel@alsa-project.org>; Fri,  7 Sep 2018 20:55:24 +0200 (CEST)
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
To: ckeepax@opensource.cirrus.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Charles Keepax,

The patch 778ff5bb8689: "ASoC: dapm: Move connection of CODEC to
CODEC DAIs" from Sep 5, 2018, leads to the following static checker
warning:

    sound/soc/soc-dapm.c:4089 dapm_connect_dai_link_widgets()
    error: 'playback' dereferencing possible ERR_PTR()

    sound/soc/soc-dapm.c:4110 dapm_connect_dai_link_widgets()
    error: 'capture' dereferencing possible ERR_PTR()

sound/soc/soc-dapm.c
  4077  
  4078          for_each_rtd_codec_dai(rtd, i, codec_dai) {
  4079  
  4080                  /* connect BE DAI playback if widgets are valid */
  4081                  codec = codec_dai->playback_widget;
  4082  
  4083                  if (playback_cpu && codec) {
  4084                          if (!playback) {
  4085                                  playback = snd_soc_dapm_new_dai(card, rtd,
  4086                                                                  playback_cpu,
  4087                                                                  codec);
  4088  
  4089                                  snd_soc_dapm_add_path(&card->dapm, playback_cpu,
  4090                                                        playback, NULL, NULL);
                                                              ^^^^^^^^
snd_soc_dapm_new_dai() returns error pointers.

  4091                          }
  4092  
  4093                          dev_dbg(rtd->dev, "connected DAI link %s:%s -> %s:%s\n",
  4094                                  cpu_dai->component->name, playback_cpu->name,
  4095                                  codec_dai->component->name, codec->name);
  4096  
  4097                          snd_soc_dapm_add_path(&card->dapm, playback, codec,
  4098                                                NULL, NULL);
  4099                  }
  4100  
  4101                  /* connect BE DAI capture if widgets are valid */
  4102                  codec = codec_dai->capture_widget;
  4103  
  4104                  if (codec && capture_cpu) {
  4105                          if (!capture) {
  4106                                  capture = snd_soc_dapm_new_dai(card, rtd,
  4107                                                                 codec,
  4108                                                                 capture_cpu);
  4109  
  4110                                  snd_soc_dapm_add_path(&card->dapm, capture,
  4111                                                        capture_cpu, NULL, NULL);
                                                              ^^^^^^^^^^^
  4112                          }
  4113  
  4114                          dev_dbg(rtd->dev, "connected DAI link %s:%s -> %s:%s\n",
  4115                                  codec_dai->component->name, codec->name,
  4116                                  cpu_dai->component->name, capture_cpu->name);
  4117  
  4118                          snd_soc_dapm_add_path(&card->dapm, codec, capture,
  4119                                                NULL, NULL);

regards,
dan carpenter
