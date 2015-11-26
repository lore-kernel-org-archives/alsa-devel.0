From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: topology: Fix not to keep a
 reference to	tplg fw
Date: Thu, 26 Nov 2015 14:40:16 +0530
Message-ID: <20151126091016.GK25173@localhost>
References: <1448547060-32749-1-git-send-email-subhransu.s.prusty@intel.com>
 <s5hoaeh6t8w.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id DC4812665A1
 for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2015 10:06:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hoaeh6t8w.wl-tiwai@suse.de>
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

On Thu, Nov 26, 2015 at 09:48:47AM +0100, Takashi Iwai wrote:
> On Thu, 26 Nov 2015 15:11:00 +0100,
> Subhransu S. Prusty wrote:
> > 
> > During element creation, the name of some of the elements point
> > to memory referenced in tplg fw. If the tplg fw is released after
> > tplg is parsed by framework, kernel panic happens during creation
> > of elements while card initialization.
> 
> In which code path?  When the kctl is already instantiated from
> snd_kcontrol_new template, we don't have to duplicate the string.
> The only case where the strdup() is required is to delay the
> instantiation, i.e. storing the kcontrol_new object itself instead of
> referring temporarily.

So in SKL, we do request firmware of topology binary and topology core uses
that for strings here, so the patch 87b5ed8ec freed the topology binary
which causes panic while accessing kcontrols.

Your second point is applicable here as card instantiation is delayed often
for us as all components may not be present and delayed probe finally
creates the card.

> > Issue is caught with id#87b5ed8ecb9fe05a696e1c0b53c7a49ea66432c1
> 
> You should put the commit subject, too.

Yes we will add that

> > So create a copy of the memory and assign to names instead.
> 
> And who releases these duplicated memory?  It looks like another
> memory leak to me.

That is a good point and I think we should do devm_kstrdup() here so that
this is freed when we cleanup the device, or do you have any better
suggestion ?

-- 
~Vinod
