From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ASoC: davinci-mcasp: Set rule constraints if
 implicit BCLK divider is used
Date: Fri, 10 Apr 2015 12:33:36 +0300
Message-ID: <20150410093336.GA5779@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 54D392605F0
 for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2015 11:33:49 +0200 (CEST)
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
To: jsarha@ti.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Jyri Sarha,

The patch a75a053f1eef: "ASoC: davinci-mcasp: Set rule constraints if
implicit BCLK divider is used" from Mar 20, 2015, leads to the
following Sparse warning:

	sound/soc/davinci/davinci-mcasp.c:1098:45:
	warning: Variable length array is used.

sound/soc/davinci/davinci-mcasp.c
  1088  static int davinci_mcasp_hw_rule_channels(struct snd_pcm_hw_params *params,
  1089                                            struct snd_pcm_hw_rule *rule)
  1090  {
  1091          struct davinci_mcasp_ruledata *rd = rule->private;
  1092          struct snd_interval *ci =
  1093                  hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
  1094          int sbits = params_width(params);
  1095          int rate = params_rate(params);
  1096          int max_chan_per_wire = rd->mcasp->tdm_slots < ci->max ?
  1097                  rd->mcasp->tdm_slots : ci->max;
  1098          unsigned int list[ci->max - ci->min + 1];
                                  ^^^^^^^^^^^^^^^^^^^^^
I wasnt able to determine where these values are capped.  The worry is
that the kernel only has an 8k stack so if they are too high it could
oops.  I think these values can come from the user in
snd_pcm_hw_params_user() but I'm an newbie to the code and I didn't
see where the limits were enforced.

  1099          int c1, c, count = 0;
  1100  
  1101          for (c1 = ci->min; c1 <= max_chan_per_wire; c1++) {
  1102                  uint bclk_freq = c1*sbits*rate;
  1103                  int ppm;


regards,
dan carpenter
