From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ASoC: core: Call mute for cpu dais as well
Date: Thu, 27 Nov 2014 19:15:03 +0300
Message-ID: <20141127161503.GA21893@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 23A16266192
 for <alsa-devel@alsa-project.org>; Thu, 27 Nov 2014 17:13:28 +0100 (CET)
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
To: ramesh.babu@intel.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Ramesh Babu,

This is a semi-automatic email about new static checker warnings.

The patch ae11601b80b9: "ASoC: core: Call mute for cpu dais as well" 
from Oct 15, 2014, leads to the following Smatch complaint:

sound/soc/soc-pcm.c:777 soc_pcm_prepare()
	 error: we previously assumed 'cpu_dai->driver->ops' could be null (see line 755)

sound/soc/soc-pcm.c
   754	
   755		if (cpu_dai->driver->ops && cpu_dai->driver->ops->prepare) {
                    ^^^^^^^^^^^^^^^^^^^^
I don't think this can be NULL.  Probably we should remove this check.

   756			ret = cpu_dai->driver->ops->prepare(substream, cpu_dai);
   757			if (ret < 0) {
   758				dev_err(cpu_dai->dev, "ASoC: DAI prepare error: %d\n",
   759					ret);
   760				goto out;
   761			}
   762		}
   763	
   764		/* cancel any delayed stream shutdown that is pending */
   765		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
   766		    rtd->pop_wait) {
   767			rtd->pop_wait = 0;
   768			cancel_delayed_work(&rtd->delayed_work);
   769		}
   770	
   771		snd_soc_dapm_stream_event(rtd, substream->stream,
   772				SND_SOC_DAPM_STREAM_START);
   773	
   774		for (i = 0; i < rtd->num_codecs; i++)
   775			snd_soc_dai_digital_mute(rtd->codec_dais[i], 0,
   776						 substream->stream);
   777		snd_soc_dai_digital_mute(cpu_dai, 0, substream->stream);
                                         ^^^^^^^
But if it were NULL then this newly introduced function call would Oops.

   778	
   779	out:

regards,
dan carpenter
