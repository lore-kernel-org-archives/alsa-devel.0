From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] ASoC: rsnd: call missing snd_ctl_remove()
Date: Thu, 15 Dec 2016 12:44:29 +0300
Message-ID: <20161215094428.GA9010@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id D20B1267172
 for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2016 10:44:40 +0100 (CET)
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
To: kuninori.morimoto.gx@renesas.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Kuninori Morimoto,

The patch d1f83d6ef43b: "ASoC: rsnd: call missing snd_ctl_remove()"
from Feb 2, 2015, leads to the following static checker warning:

	sound/soc/sh/rcar/core.c:1034 __rsnd_kctrl_new()
	error: double free of 'kctrl'

sound/soc/sh/rcar/core.c
  1026          int ret;
  1027  
  1028          kctrl = snd_ctl_new1(&knew, mod);
  1029          if (!kctrl)
  1030                  return -ENOMEM;
  1031  
  1032          ret = snd_ctl_add(card, kctrl);
  1033          if (ret < 0) {
  1034                  snd_ctl_free_one(kctrl);

The snd_ctl_add() function frees kctrl on error.  It's a confusing
layering violation IMHO but there are a lot of callers so I'm too lazy
to clean this up myself...

  1035                  return ret;
  1036          }
  1037  

regards,
dan carpenter
