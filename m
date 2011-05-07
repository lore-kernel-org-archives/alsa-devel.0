From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: [PATCH v2 01/10] ASoC: upd9976: Add Renesas
	uPD9976 codec driver
Date: Sat, 7 May 2011 22:43:19 +0800
Message-ID: <20110507144319.GE13216@qtel.sh.intel.com>
References: <20110506125437.GJ23729@opensource.wolfsonmicro.com>
	<20110506125308.GI23729@opensource.wolfsonmicro.com>
	<20110506110730.GG23729@opensource.wolfsonmicro.com>
	<20110506101726.GF23729@opensource.wolfsonmicro.com>
	<20110507142112.GC13216@qtel.sh.intel.com>
	<20110507142734.GA26700@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 7CD63243B3
	for <alsa-devel@alsa-project.org>;
	Sat,  7 May 2011 16:44:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110507142734.GA26700@opensource.wolfsonmicro.com>
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

On Sat, May 07, 2011 at 10:27:35PM +0800, Mark Brown wrote:
> > changing it to `if (upd9976->ira >= 0 && !upd9976->irq_mem) is logically
> > ok, but it introduces more indentation for a large block of code...
> 
> Put it in a function if that's an issue.

OK.

> 
> > > These look like regular routing controls to me...  If they do need to be
> > > set with magic writes they should be platform data but things like
> > > pseudo differential inputs are normally just represented as two single
> > > ended inputs for which userspace just happens to choose a path that
> > > looks differential.
> 
> > The above DMIC output might fit routing control in some way, but I think
> > the MIC2 configuration is hardware specific, this is not related to
> > routing quite much. Let me check whether it's easy to be implemented as
> > a routing control or platform data...
> 
> Really, this is *very* common - a pseudo differential input is just two
> single ended inputs that happen to be used to fake a differential input
> on a given board.  It's likely that a board will use the same setup most
> of the time (though sometimes it does change) but they should still not
> be configuring this with magic register writes in the machine driver.

As this should not be configured in machine driver, I'll make it a
control so that user is about to change it (this should only be set
once, and leave it there untouched).

-- 
guanqun
