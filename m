From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH 3/4] ASoC: mid-x86: Add support for capture
 in machine driver
Date: Wed, 19 Jan 2011 21:59:59 +0530
Message-ID: <438BB0150E931F4B9CE701519A446301084470BBD4@bgsmsx502.gar.corp.intel.com>
References: <1295441221-32132-1-git-send-email-priya.harsha@intel.com>
	<20110119142423.GA16328@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id C3751244B1
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2011 17:30:06 +0100 (CET)
In-Reply-To: <20110119142423.GA16328@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, "Harsha, Priya" <priya.harsha@intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

> 
> > +	/* we are using DMICs here so configure how the clock and out pin is set
> */
> > +	snd_soc_write(codec, SN95031_DMICBUF0123, 0x85);
> > +	snd_soc_write(codec, SN95031_DMICBUF45, 0x02);
> > +	snd_soc_update_bits(codec, SN95031_DMICMUX, 0x7, 0x07);
> 
> This looks like something which would more normally be done with
> platform data than with writes in the machine driver.
This is actually optional. The DMIC can be used as GPO or DMIC. This is user option.
Wanted to explicitly code here as this machine DMICs are used.

~Vinod
