From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ASoC: fsl_asrc: Add ASRC ASoC CPU DAI and platform
	drivers
Date: Thu, 31 Jul 2014 12:33:16 +0300
Message-ID: <20140731093316.GG30276@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id E78FD265051
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 11:33:55 +0200 (CEST)
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
To: nicoleotsuka@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Nicolin Chen,

This is a semi-automatic email about new static checker warnings.

The patch 3117bb3109dc: "ASoC: fsl_asrc: Add ASRC ASoC CPU DAI and 
platform drivers" from Jul 29, 2014, leads to the following Smatch 
complaint:

sound/soc/fsl/fsl_asrc_dma.c:304 fsl_asrc_dma_shutdown()
	 warn: variable dereferenced before check 'pair' (see line 302)

sound/soc/fsl/fsl_asrc_dma.c
   301		struct fsl_asrc_pair *pair = runtime->private_data;
   302		struct fsl_asrc *asrc_priv = pair->asrc_priv;
                                             ^^^^^^^^^^^^^^^
Dereference.

   303	
   304		if (pair && asrc_priv->pair[pair->index] == pair)
                    ^^^^

Check.

   305			asrc_priv->pair[pair->index] = NULL;
   306	

regards,
dan carpenter
