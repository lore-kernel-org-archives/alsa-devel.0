From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] ASoC: soc-core: add snd_soc_rtdcom_xxx()
Date: Mon, 11 Sep 2017 10:44:32 +0300
Message-ID: <20170911074432.etwitlire74a3jff@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id C8CF22668BF
 for <alsa-devel@alsa-project.org>; Mon, 11 Sep 2017 09:45:03 +0200 (CEST)
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

This is a semi-automatic email about new static checker warnings.

The patch a0ac44115223: "ASoC: soc-core: add snd_soc_rtdcom_xxx()" 
from Aug 8, 2017, leads to the following Smatch complaint:

sound/soc/soc-core.c:644 soc_free_pcm_runtime()
	 error: we previously assumed 'rtd' could be null (see line 642)

sound/soc/soc-core.c
   641	{
   642		if (rtd && rtd->codec_dais)
                    ^^^
Check for NULL.

   643			kfree(rtd->codec_dais);
   644		snd_soc_rtdcom_del_all(rtd);
                                       ^^^
The check adds a new unchecked dereference inside the function.  It's
weird that we call INIT_LIST_HEAD(&rtd->component_list), btw.  Don't we
need to free the elements in the list?

   645		kfree(rtd);
   646	}

regards,
dan carpenter
