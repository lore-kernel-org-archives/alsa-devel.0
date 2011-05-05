From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: [PATCH 05/19] ASoC: mrst_machine: enable user to
 select different output
Date: Thu, 5 May 2011 08:34:07 +0800
Message-ID: <20110505003407.GC8633@qtel.sh.intel.com>
References: <20110504133756.32443.6282.stgit@localhost>
	<20110504134519.32443.90599.stgit@localhost>
	<20110504162231.GF10912@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C46E10391D
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 02:35:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110504162231.GF10912@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, "Koul, Vinod" <vinod.koul@intel.com>, ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, "Wang, Xingchao" <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 05, 2011 at 12:22:32AM +0800, Mark Brown wrote:
> On Wed, May 04, 2011 at 09:45:19PM +0800, Lu Guanqun wrote:
> 
> > +	ret = snd_soc_add_controls(codec,
> > +				   mrst_snd_controls,
> > +				   ARRAY_SIZE(mrst_snd_controls));
> > +	if (ret)
> > +		return ret;
> > +
> 
> It'd be better to use the data based init stuff to add the controls.

OK. Will change that.

-- 
guanqun
