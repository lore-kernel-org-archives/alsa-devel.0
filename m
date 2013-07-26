From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: RFC: support for 12 & 24Khz
Date: Fri, 26 Jul 2013 11:39:08 +0530
Message-ID: <20130726060908.GA1986@intel.com>
References: <20130724172640.GE18642@intel.com> <51F0CAC0.9090702@ladisch.de>
 <20130725154501.GN18642@intel.com> <s5h1u6mk3dm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B6BD2610AF
 for <alsa-devel@alsa-project.org>; Fri, 26 Jul 2013 08:47:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h1u6mk3dm.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: pierre-louis.bossart@linux.jf.intel.com, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 25, 2013 at 06:31:33PM +0200, Takashi Iwai wrote:
> At Thu, 25 Jul 2013 21:15:01 +0530,
> Vinod Koul wrote:
> > 
> > On Thu, Jul 25, 2013 at 08:50:40AM +0200, Clemens Ladisch wrote:
> > > Vinod Koul wrote:
> > > > For compressed audio we also need to support the PCM rates of 12 and 24KHz.
> > > >
> > > > Looking at pcm.h these are not defined
> > > 
> > > You don't need such symbols to use a rate.  These symbols are intended
> > > for often-used rates.  As long as only one or two drivers use a rate,
> > > they can just set KNOT and install a constraint.
> > okay so how exactly is the rate passed to driver and converted and sent to
> > drivers?
> 
> Define the own hw_constraint.  Usually it's implemented via
> snd_pcm_hw_constraint_list().
Thanks
> 
> > > > But am worried about wider impact of adding these rates.
> > > >
> > > > Can you let me know if more is required to be done or below is fine
> > > 
> > > Grep for 176400 in sound/core/, include/, and in alsa-lib.
> > SNDRV_PCM_RATE_176400?
> 
> Heh, this was an already added one.  Rather take a look at
> SNDRV_PCM_RATE_KNOT.
Okay so the orignal problem is that we use SNDRV_PCM_RATE_XXX to send the sample
rate to decoder. Some decoders very commonly use 12 and 24Khz, so I would like
them to be added.

I think 12 and 24 are fairly common rates and should be added. Do you agree?

~Vinod
-- 
