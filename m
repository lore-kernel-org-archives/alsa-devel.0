From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ASoC: dapm: Allow regulators to bypass as well as
 disable when idle
Date: Thu, 27 Sep 2012 22:57:58 +0300
Message-ID: <20120927195758.GA10652@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rcsinet15.oracle.com (rcsinet15.oracle.com [148.87.113.117])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C71326030B
 for <alsa-devel@alsa-project.org>; Thu, 27 Sep 2012 21:58:14 +0200 (CEST)
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

Hi Mark,

I had a question about patch c05b84d14b23: "ASoC: dapm: Allow regulators
to bypass as well as disable when idle" from Sep 7, 2012.

  1022          if (SND_SOC_DAPM_EVENT_ON(event)) {
  1023                  if (w->invert & SND_SOC_DAPM_REGULATOR_BYPASS) {
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  1024                          ret = regulator_allow_bypass(w->regulator, true);
  1025                          if (ret != 0)
  1026                                  dev_warn(w->dapm->dev,
  1027                                           "Failed to bypass %s: %d\n",
  1028                                           w->name, ret);
  1029                  }
  1030  
  1031                  return regulator_enable(w->regulator);
  1032          } else {
  1033                  if (w->invert & SND_SOC_DAPM_REGULATOR_BYPASS) {
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Right now ->invert is a single bit bitfield.  We mostly test
"if (w->invert) {...".  Are we planning to add some more bits in there?

  1034                          ret = regulator_allow_bypass(w->regulator, false);
  1035                          if (ret != 0)
  1036                                  dev_warn(w->dapm->dev,
  1037                                           "Failed to unbypass %s: %d\n",
  1038                                           w->name, ret);
  1039                  }

regards,
dan carpenter
