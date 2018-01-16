From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] ASoC: snd_soc_component_driver has
	snd_compr_ops
Date: Tue, 16 Jan 2018 14:12:42 +0300
Message-ID: <20180116111242.GA6302@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by alsa0.perex.cz (Postfix) with ESMTP id EACE6266E7C
 for <alsa-devel@alsa-project.org>; Tue, 16 Jan 2018 12:12:51 +0100 (CET)
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

The patch 9e7e3738ab0e: "ASoC: snd_soc_component_driver has
snd_compr_ops" from Oct 11, 2017, leads to the following static
checker warning:

	sound/soc/soc-compress.c:109 soc_compr_open()
	warn: 'cstream->runtime->private_data' double freed

sound/soc/soc-compress.c
    91          return 0;
    92  
    93  machine_err:
    94          for_each_rtdcom(rtd, rtdcom) {
    95                  component = rtdcom->component;
    96  
    97                  /* ignore duplication for now */
    98                  if (platform && (component == &platform->component))
    99                          continue;
   100  
   101                  if (!component->driver->compr_ops ||
   102                      !component->driver->compr_ops->free)
   103                          continue;
   104  
   105                  component->driver->compr_ops->free(cstream);
                                                    ^^^^^^^^^^^^^^^
This is in a loop so is the really right?  We end up freeing cstream
over and over?

   106          }
   107  
   108          if (platform && platform->driver->compr_ops && platform->driver->compr_ops->free)
   109                  platform->driver->compr_ops->free(cstream);
                                                    ^^^^^^^^^^^^^
This second call is what triggers the warning.

   110  plat_err:
   111          if (cpu_dai->driver->cops && cpu_dai->driver->cops->shutdown)
   112                  cpu_dai->driver->cops->shutdown(cstream, cpu_dai);
   113  out:
   114          mutex_unlock(&rtd->pcm_mutex);
   115          return ret;
   116  }

regards,
dan carpenter
