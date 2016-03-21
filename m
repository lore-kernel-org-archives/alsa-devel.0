From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: compress: Pass error out of
 soc_compr_pointer
Date: Mon, 21 Mar 2016 13:07:06 +0000
Message-ID: <20160321130706.GL1490@localhost.localdomain>
References: <1457606694-10985-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20160311074843.GV11154@localhost>
 <20160311100425.GH1490@localhost.localdomain>
 <20160311103747.GZ11154@localhost> <s5hbn6l5meo.wl-tiwai@suse.de>
 <20160311111428.GB11154@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D775264F37
 for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2016 14:07:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20160311111428.GB11154@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 11, 2016 at 04:44:28PM +0530, Vinod Koul wrote:
> On Fri, Mar 11, 2016 at 11:39:11AM +0100, Takashi Iwai wrote:
> > On Fri, 11 Mar 2016 11:37:47 +0100,
> > Vinod Koul wrote:
> > > 
> > > On Fri, Mar 11, 2016 at 10:04:25AM +0000, Charles Keepax wrote:
> > > > On Fri, Mar 11, 2016 at 01:18:43PM +0530, Vinod Koul wrote:
> > > > > On Thu, Mar 10, 2016 at 10:44:51AM +0000, Charles Keepax wrote:
> > > > > > The soc_compr_pointer does not correctly pass any errors returned by the
> > > > > > driver callback back up the stack. This patch corrects this issue.
> > > > > 
> > > > > Should we do that :) I am not too sure. Pointer query is supposed to read
> > > > > the current value and return. You are trying to indicate that stream has
> > > > > gone bad which is not the same as read faced an error...
> > > > > 
> > > > > Also please use cover letter for these things to describe problem you are
> > > > > trying to solve.
> > > > 
> > > > Apologies for not doing so, I had been viewing this as more of a
> > > > simple oversight in the framework rather than a design choice.
> > > > 
> > > > The problem I am looking at is the DSP suffers an unrecoverable
> > > > error. We can find out about this error in our driver because the
> > > > DSP returns some error status to us.  This is fine if user-space
> > > > is doing a read as reads return error status back to user-space
> > > > so the user can find out that things have gone bad. However, if
> > > > user-space is doing an avail request there is no path for the
> > > > error to come back up to user-space. The pointer request returns
> > > > zero available data, so a read never happens and we basically
> > > > just end up sitting waiting for data on a stream that we know
> > > > full well has died.
> > > 
> > > So this confirms my hunch and we should then notify core of error by stopping
> > > the stream properly and then return error on poll/pointer query.
> > > 
> > > So cna try this untested patch, whcih includes a hack for stopped state. We
> > > don't seem to have a stopped state in ALSA, that bit would need refinement
> > 
> > In PCM, the stopped state is either SETUP/PREPARE or XRUN.
> 
> We didn't use PREPARE so we can set to XRUN. So here is alternate patch for
> this, whcih looks much better :)

Sorry about the delay in responding here. Are we really
completely opposed to the idea of passing error state through
the AVAIL? Basically I see there as being two problems with the
approach being suggested here.

1) It only covers errors the DSP can detect. For example if
the SPI transactions start failing whilst we are doing avail
callbacks we get into the same situation. Although we could call
this snd_compr_stop on any error from within our driver, but then
how was that better than just passing the errors?

2) The locking is exceptionally awkward, the trouble is you are
calling right from the bottom of the stack upto the top, and
then going back down again. So for example we have a lock in
our driver that syncs between the IRQ, the DSP powering up/down
through DAPM, and the compressed callbacks. We will want to call
snd_compr_stop from within the IRQ handler as the DSP should give
us an IRQ on an error. But then to ensure that the stream we are
going to pass to snd_compr_stop is valid we need to hold that
lock whilst we make the call. But this leads to a potential mutex
inversion. As we can do driver lock, stream->device_lock on the
IRQ path and stream->device->lock, driver lock on all the normal
callback paths. Not to mention the fact that snd_compr_stop is
then going to want to call trigger which will give us a double
lock on the driver lock.

How about allowing errors to propogate through the pointer
callback but then shutting down the stream from the core code
instead? We could perhaps say that a pointer call failing is
indicative of a fatal error?

Thanks,
Charles
