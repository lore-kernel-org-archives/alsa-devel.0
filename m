From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH 01/19] ASoC: upd9976: Add Renesas uPD9976
 codec driver
Date: Thu, 05 May 2011 08:42:57 +0530
Message-ID: <1304565177.20953.31.camel@vkoul-udesk3>
References: <20110504133756.32443.6282.stgit@localhost>
	<20110504134458.32443.45825.stgit@localhost>
	<20110504144600.GA7366@opensource.wolfsonmicro.com>
	<20110504151250.GC1671@qtel.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 89DFD243BA
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 05:45:12 +0200 (CEST)
In-Reply-To: <20110504151250.GC1671@qtel.sh.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Lu, Guanqun" <guanqun.lu@intel.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, ALSA <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Wang,
	Xingchao" <xingchao.wang@intel.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-05-04 at 20:42 +0530, Lu, Guanqun wrote:
> On Wed, May 04, 2011 at 10:46:00PM +0800, Dimitris Papastamos wrote:
> > On Wed, May 04, 2011 at 09:44:58PM +0800, Lu Guanqun wrote:
> > > +	if (ret)
> > > +		pr_err("upd9976 read of 0x%x failed, error: %d\n", reg, ret);
> > > +	return value;
> > > +}
> > 
> > dev_err() would be more preferable.
any specific reasons for that?

-- 
~Vinod
