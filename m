From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v5 03/12] ALSA: control: Add init callback
	for kcontrol
Date: Mon, 8 Sep 2014 16:38:55 +0530
Message-ID: <20140908110855.GL1610@intel.com>
References: <1409661367-19047-1-git-send-email-subhransu.s.prusty@intel.com>
 <1409661367-19047-4-git-send-email-subhransu.s.prusty@intel.com>
 <20140906142124.GG2601@sirena.org.uk>
 <s5hppf8g2ul.wl-tiwai@suse.de> <20140908041421.GI1610@intel.com>
 <s5hppf6a679.wl-tiwai@suse.de> <20140908080807.GJ1610@intel.com>
 <s5hlhpua4pi.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id E70BE265130
 for <alsa-devel@alsa-project.org>; Mon,  8 Sep 2014 13:31:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hlhpua4pi.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 08, 2014 at 10:36:57AM +0200, Takashi Iwai wrote:
> At Mon, 8 Sep 2014 13:38:07 +0530,
> Vinod Koul wrote:
> > 
> > On Mon, Sep 08, 2014 at 10:04:42AM +0200, Takashi Iwai wrote:
> > > At Mon, 8 Sep 2014 09:44:21 +0530,
> > > Vinod Koul wrote:
> > > > 
> > > > On Sat, Sep 06, 2014 at 05:56:02PM +0200, Takashi Iwai wrote:
> > > > > At Sat, 6 Sep 2014 15:21:24 +0100,
> > > > > Mark Brown wrote:
> > > > > > 
> > > > > > On Tue, Sep 02, 2014 at 06:05:58PM +0530, Subhransu S. Prusty wrote:
> > > > > > > Some controls need to initialize stuffs like pvt data, so they need a
> > > > > > > callback if the control creation is successful.
> > > > > > 
> > > > > > Adding Takashi - this is ALSA core code so he needs to review it.
> > > > > 
> > > > > This would bloat effectively the data size of all sound drivers, so I
> > > > > can't ack it without more proper reasoning.  That is, please convince
> > > > > me why this change must be taken for the cost of size bloat of all
> > > > > sound drivers.  Can't you do it in the caller side of snd_ctl_add()
> > > > > like many other drivers already do?
> > > > Okay lets step back and see why we need this :)
> > > > 
> > > > In our case after the control creation we need to allocate memory which will
> > > > hold the data for the byte controls. This can be done only after the
> > > > controls are created (by asoc).
> > > 
> > > Why?  Because you don't need how many bytes to allocate?
> > > 
> > > > For that we need a callback into driver so that we can allocate the memory.
> > > > Thats why we added .init() method. If you have any other way to do this, we
> > > > are all ears :)
> > > 
> > > For example, you can embed an init flag into your record and call the
> > > initializer in get/put callback if not called yet.
> > Yes but that would involve open coding in all control hanlers for the driver :
> > 
> > if (!initialized)
> > 	allocate_control_mem();
> > 
> > This approach was done earlier (checking in info) and flaged off by Mark. It make better to
> > have these handled in the framework.
> 
> For the cost of bloating all sound drivers with every control element?
> No.  You can extend the framework, but not in this way.
Yes makes sense.

> For example, it's nonsense to keep this permanently in each control
> element, and both in kcontrol and kcontrol_new.  Remember that this is
> a oneshot callback that is called only after creation...
Yes indeed, so we are going to rely on the falg in driver records and initialize at
first invocation.

Updated series spinning now
-- 
~Vinod
