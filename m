From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: [PATCH 01/19] ASoC: upd9976: Add Renesas uPD9976
	codec driver
Date: Thu, 5 May 2011 08:33:13 +0800
Message-ID: <20110505003313.GB8633@qtel.sh.intel.com>
References: <20110504133756.32443.6282.stgit@localhost>
	<20110504134458.32443.45825.stgit@localhost>
	<20110504143451.GA10912@opensource.wolfsonmicro.com>
	<s5hbozio66r.wl%tiwai@suse.de>
	<20110504151827.GD1671@qtel.sh.intel.com>
	<s5h62pqo4qu.wl%tiwai@suse.de>
	<20110504161545.GD10912@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 99AFE10391D
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 02:34:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110504161545.GD10912@opensource.wolfsonmicro.com>
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

On Thu, May 05, 2011 at 12:15:46AM +0800, Mark Brown wrote:
> On Wed, May 04, 2011 at 05:38:33PM +0200, Takashi Iwai wrote:
> 
> > If it's the only output, any of them can be a "Master" volume.
> > But if there are other outputs, it shouldn't be named as "Master" at
> > all. 
> 
> If you've got a choice you probably want to pick an analogue control
> over a digital one as this will give better performance.

Good to know that.
But there's no single volume control after DAC that can control all the
outputs. poor about that...

> 
> > Master volume is like Highlander(*), there can be only one :)
> 
> > (*) doesn't mean guys in Edinburgh
> 
> Definitely not, Edinburgh is in the lowlands not the highlands!

-- 
guanqun
