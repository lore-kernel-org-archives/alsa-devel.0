From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ASoC: add Renesas R-Car module feature
Date: Fri, 8 Nov 2013 13:02:06 +0300
Message-ID: <20131108100206.GP27977@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B2102617A4
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2013 11:02:15 +0100 (CET)
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

The patch cdaa3cdfb4a7: "ASoC: add Renesas R-Car module feature" from 
Jul 21, 2013, leads to the following Smatch complaint:

sound/soc/sh/rcar/core.c:294 rsnd_dai_connect()
	 warn: variable dereferenced before check 'mod' (see line 291)

sound/soc/sh/rcar/core.c
   290	{
   291		struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
                                         ^^^^^^^^^^^^^^^^^^^^^
Dereference.

   292		struct device *dev = rsnd_priv_to_dev(priv);
   293	
   294		if (!mod) {
                    ^^^^
Check.

   295			dev_err(dev, "NULL mod\n");
   296			return -EIO;

regards,
dan carpenter
