From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: topology: Fix not to keep a
 reference to	tplg fw
Date: Thu, 26 Nov 2015 21:43:43 +0530
Message-ID: <20151126161343.GD2309@localhost>
References: <1448547060-32749-1-git-send-email-subhransu.s.prusty@intel.com>
 <s5hoaeh6t8w.wl-tiwai@suse.de> <20151126091016.GK25173@localhost>
 <s5hio4p6rt4.wl-tiwai@suse.de> <20151126112457.GC2309@localhost>
 <s5h7fl5t23z.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D793261A8C
 for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2015 17:09:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h7fl5t23z.wl-tiwai@suse.de>
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
Cc: patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 26, 2015 at 12:46:24PM +0100, Takashi Iwai wrote:

> > Sorry it a oops, paging request failure and not a panic
> > 
> > > > Your second point is applicable here as card instantiation is delayed often
> > > > for us as all components may not be present and delayed probe finally
> > > > creates the card.
> > > > 
> > > > > > Issue is caught with id#87b5ed8ecb9fe05a696e1c0b53c7a49ea66432c1
> > > > > 
> > > > > You should put the commit subject, too.
> > > > 
> > > > Yes we will add that
> > > > 
> > > > > > So create a copy of the memory and assign to names instead.
> > > > > 
> > > > > And who releases these duplicated memory?  It looks like another
> > > > > memory leak to me.
> > > > 
> > > > That is a good point and I think we should do devm_kstrdup() here so that
> > > > this is freed when we cleanup the device, or do you have any better
> > > > suggestion ?
> > > 
> > > devm_kstrdup() is bad in this case.  You can reload the topology
> > > unlimitedly, and the memory won't be freed until the device unbind,
> > > thus it keeps hogging.
> > > 
> > > You really need to identify which path hits the issue exactly how.  In
> > > general, the string passed to template is only for creating the kctl.
> > > Once when kctl is created, the whole snd_kcontrol_new template and the
> > > allocated string is no use, so they can be freed.
> > 
> > but then question of where should these be freed. For current drivers they
> > declare controls statically, so memory is always there.. How do free up in
> > the cases where we allocate dynamically?
> 
> Well, for judging this, we have to follow the code more closely.  And
> it's why I asked which path does it happen exactly.
> 
> There are two different paths where the snd_kcontrol_new is used: the
> standard controls and dapm.  The former is immediately instantiated
> via snd_soc_cnew(), so it's fine as is, no need to change.  But the
> latter is different.
> 
> The latter, dapm case, always allocates the snd_kcontrol_new array in
> kcontrol_news field.  So, we need to change in each function
> allocating this to do kstrdump() for each kcontrol_new element, and
> each place calling kfree() of kcontrol_news should free the string of
> each item in return.

It is the latter dapm case with added complexity of topology core creating
these kcontrols. I will reproduce this and send the oops tomorrow

-- 
~Vinod
