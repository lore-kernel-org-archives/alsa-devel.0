From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 01/10] ASoC: upd9976: Add Renesas
 uPD9976 codec driver
Date: Sat, 7 May 2011 15:27:35 +0100
Message-ID: <20110507142734.GA26700@opensource.wolfsonmicro.com>
References: <20110506125437.GJ23729@opensource.wolfsonmicro.com>
	<20110506125308.GI23729@opensource.wolfsonmicro.com>
	<20110506110730.GG23729@opensource.wolfsonmicro.com>
	<20110506101726.GF23729@opensource.wolfsonmicro.com>
	<20110507142112.GC13216@qtel.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1D1152443B
	for <alsa-devel@alsa-project.org>;
	Sat,  7 May 2011 16:27:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110507142112.GC13216@qtel.sh.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lu Guanqun <guanqun.lu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "Koul, Vinod" <vinod.koul@intel.com>, ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, "Wang, Xingchao" <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

On Sat, May 07, 2011 at 10:21:12PM +0800, Lu Guanqun wrote:
> On Fri, May 06, 2011 at 06:17:27PM +0800, Mark Brown wrote:
> > On Fri, May 06, 2011 at 01:46:03PM +0800, Lu Guanqun wrote:

> > > +static DECLARE_TLV_DB_SCALE(adac_tlv, -8400, 75, 0);
> > > +static const struct snd_kcontrol_new upd9976_snd_controls[] = {

> > Use of blank lines here is really odd.

> I don't see a blank line between upd9976_snd_controls and Master Volume.

Yes, exactly.  There's randomly omitted vertical space which makes
things hard to read.

> Do you mean the blank line between the above comment and
> DECLARE_TLV_DB_SCALE line?  I'll remove these blank lines.

No, don't do that.

> OK. Let me make the code more clear.
> how about this?

That's fine.

> > > +	if (upd9976->irq < 0 || !upd9976->irq_mem)
> > > +		return 0;

> > It'd seem better to have this condition the other way around so if you
> > need to add more conditional stuff things will be clearer.

> changing it to `if (upd9976->ira >= 0 && !upd9976->irq_mem) is logically
> ok, but it introduces more indentation for a large block of code...

Put it in a function if that's an issue.

> > These look like regular routing controls to me...  If they do need to be
> > set with magic writes they should be platform data but things like
> > pseudo differential inputs are normally just represented as two single
> > ended inputs for which userspace just happens to choose a path that
> > looks differential.

> The above DMIC output might fit routing control in some way, but I think
> the MIC2 configuration is hardware specific, this is not related to
> routing quite much. Let me check whether it's easy to be implemented as
> a routing control or platform data...

Really, this is *very* common - a pseudo differential input is just two
single ended inputs that happen to be used to fake a differential input
on a given board.  It's likely that a board will use the same setup most
of the time (though sometimes it does change) but they should still not
be configuring this with magic register writes in the machine driver.
