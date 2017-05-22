From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/3] ALSA: core: modify .ack callback to
 take arguments for updating appl ptr
Date: Mon, 22 May 2017 11:11:03 +0530
Message-ID: <20170522054103.GU15061@localhost>
References: <1494896518-23399-1-git-send-email-subhransu.s.prusty@intel.com>
 <1494896518-23399-3-git-send-email-subhransu.s.prusty@intel.com>
 <s5hinl11h0j.wl-tiwai@suse.de>
 <20170516073653.GA25195@subhransu-desktop>
 <20170518061821.GD25195@subhransu-desktop>
 <s5hk25emvrg.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id CE509266C7B
 for <alsa-devel@alsa-project.org>; Mon, 22 May 2017 07:38:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hk25emvrg.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, lgirdwood@gmail.com, Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 18, 2017 at 10:09:23AM +0200, Takashi Iwai wrote:
> On Thu, 18 May 2017 08:18:21 +0200,
> Subhransu S. Prusty wrote:
> > 
> > On Tue, May 16, 2017 at 01:06:57PM +0530, Subhransu S. Prusty wrote:
> > > On Tue, May 16, 2017 at 07:56:44AM +0200, Takashi Iwai wrote:
> > > > On Tue, 16 May 2017 03:01:57 +0200,
> > > > Subhransu S. Prusty wrote:
> > > > > 
> > > > > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > > > 
> > > > > When appl_ptr is updated let low-level driver know, e.g.  to let the
> > > > > low-level driver/hardware pre-fetch data opportunistically.
> > > > > 
> > > > > The existing .ack callback is extended with new attribute argument, to
> > > > > support this capability. Legacy driver subscribe to SND_PCM_ACK_LEGACY and
> > > > > doesn't process ack if it is not set. SND_PCM_ACK_APP_PTR can be used to
> > > > > process the application ptr update in the driver like in the skylake
> > > > > driver which can use this to inform position of appl pointer to host DMA
> > > > > controller. The skylake driver to process the SND_PCM_ACK_APP_PTR will be
> > > > > submitted with a separate patch set.
> > > > > 
> > > > > In the ALSA core, this capability is independent from the NO_REWIND
> > > > > hardware flag. The low-level driver may however tie both options and only
> > > > > use the updated appl_ptr when rewinds are disabled due to hardware
> > > > > limitations.
> > > > > 
> > > > > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > > > Signed-off-by: Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>
> > > > > Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> > > > 
> > > > It might be me who suggested the extension of the ack ops, but now
> > > > looking at the result, I reconsider whether it'd be a better choice if
> > > > we add another ops (e.g. update_appl_ptr()) instead.  Could you try to
> > > > rewrite the patch in that way for comparison?
> > > 
> > > Here is the version using update_appl_ptr.
> > 
> > Hi Takashi,
> > 
> > Did you get a chance to look at the update_appl_ptr changes?
> > Please let us know which one will be preferable, will submit the patches
> > accordingly.
> 
> Now I have a mixed feeling.  Using ack() is basically "the right
> thing".  The update of appl_ptr in forward/rewind and sync_ptr should
> be notified to ack() in general.  It's the purpose of ack(), after
> all.  In that sense, we may call ack() without any argument from any
> places.
> 
> The only problem is that the rewind is broken on some drivers, and
> calling ack() may lead to unexpected results.

Precisely the reason we went with an arg to make it opt-in and ensure
existing drivers don't break

> That is, we should look at these existing drivers and handle the
> rewind case (negative appl_ptr diff) appropriately -- or maybe we
> should add a flag to disallow the rewind on such drivers.
> After that, ack() can be called safely from all places that update
> appl_ptr.

Testing a large set of those drivers will be an issue :(

> ... this is one way.  Another way is to allow a quick hack and doubly
> call a new callback.

Sorry but how would invoking twice help here?

> 
> I prefer the former, but obviously it'll take longer.  So it depends
> on urgency.

We have been going back and forth on this for at least couple of years now,
so I would really love this to get merged before next window :)

-- 
~Vinod
