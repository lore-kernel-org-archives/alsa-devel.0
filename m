From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ASoC: rsnd: show debug message for SSI/SRC/DVC
	connection
Date: Tue, 21 Jul 2015 00:45:40 +0300
Message-ID: <20150720214540.GA22293@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id DE9C1261545
 for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2015 23:43:20 +0200 (CEST)
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

The patch 84e95355602c: "ASoC: rsnd: show debug message for 
SSI/SRC/DVC connection" from Jul 15, 2015, leads to the following 
Smatch complaint:

sound/soc/sh/rcar/core.c:338 rsnd_dai_connect()
	 warn: variable dereferenced before check 'mod' (see line 335)

sound/soc/sh/rcar/core.c
   334	{
   335		struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
                                         ^^^^^^^^^^^^^^^^^^^^^
Patch adds new dereference.

   336		struct device *dev = rsnd_priv_to_dev(priv);
   337	
   338		if (!mod)
                    ^^^^
Existing code assumed "mod" could be NULL.

   339			return -EIO;
   340	

regards,
dan carpenter
