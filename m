From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ASoC: Add max98925 codec driver
Date: Tue, 17 Mar 2015 21:28:43 +0300
Message-ID: <20150317182843.GA30354@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id E3D7E262632
 for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2015 19:29:05 +0100 (CET)
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
To: yesanishhere@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Anish Kumar,

The patch 1ff2765182d1: "ASoC: Add max98925 codec driver" from Mar 9,
2015, leads to the following static checker warning:

	sound/soc/codecs/max98925.c:274 max98925_rate_value()
	error: buffer overflow 'rate_table' 9 <= 9

sound/soc/codecs/max98925.c
   259  static inline int max98925_rate_value(struct snd_soc_codec *codec,
   260                  int rate, int clock, int *value, int *n, int *m)
   261  {
   262          int ret = -EINVAL;
   263          int i;
   264  
   265          for (i = 0; i < ARRAY_SIZE(rate_table); i++) {
   266                  if (rate_table[i].rate >= rate) {
   267                          *value = rate_table[i].sr;
   268                          *n = rate_table[i].divisors[clock][0];
   269                          *m = rate_table[i].divisors[clock][1];
   270                          ret = 0;
   271                          break;
   272                  }
   273          }
   274          dev_dbg(codec->dev, "%s: sample rate is %d, returning %d\n",
   275                                  __func__, rate_table[i].rate, *value);
                                                  ^^^^^^^^^^^^^^^^^^
If we don't break then we're off by one.

   276          return ret;
   277  }

regards,
dan carpenter
