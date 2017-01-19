From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] ASoC: dapm: Implement and instantiate DAI
	widgets
Date: Thu, 19 Jan 2017 10:38:26 +0300
Message-ID: <20170119073826.GA28899@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C6C92666EC
 for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2017 08:38:39 +0100 (CET)
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
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Mark Brown,

The patch 888df395ebc5: "ASoC: dapm: Implement and instantiate DAI
widgets" from Feb 16, 2012, leads to the following static checker
warning:

	sound/soc/soc-dapm.c:3944 snd_soc_dapm_new_dai_widgets()
	error: 'w' dereferencing possible ERR_PTR()

sound/soc/soc-dapm.c
  3929          if (dai->driver->playback.stream_name) {
  3930                  template.id = snd_soc_dapm_dai_in;
  3931                  template.name = dai->driver->playback.stream_name;
  3932                  template.sname = dai->driver->playback.stream_name;
  3933  
  3934                  dev_dbg(dai->dev, "ASoC: adding %s widget\n",
  3935                          template.name);
  3936  
  3937                  w = snd_soc_dapm_new_control_unlocked(dapm, &template);

This can either return NULL or ERR_PTR(-EPROBE_DEFER).

  3938                  if (!w) {
  3939                          dev_err(dapm->dev, "ASoC: Failed to create %s widget\n",
  3940                                  dai->driver->playback.stream_name);
  3941                          return -ENOMEM;
  3942                  }
  3943  
  3944                  w->priv = dai;
                        ^^^^^^^^^^^^^

  3945                  dai->playback_widget = w;
  3946          }

regards,
dan carpenter
