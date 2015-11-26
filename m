From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: topology: Fix not to keep a
 reference to	tplg fw
Date: Thu, 26 Nov 2015 16:49:58 +0530
Message-ID: <20151126111958.GB2309@localhost>
References: <1448547060-32749-1-git-send-email-subhransu.s.prusty@intel.com>
 <s5hoaeh6t8w.wl-tiwai@suse.de> <20151126091016.GK25173@localhost>
 <s5hio4p6rt4.wl-tiwai@suse.de>
 <20151126110123.GZ1929@sirena.org.uk>
 <s5hd1uxt42r.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D1442614C5
 for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2015 12:16:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hd1uxt42r.wl-tiwai@suse.de>
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
Cc: patches.audio@intel.com, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 26, 2015 at 12:03:56PM +0100, Takashi Iwai wrote:
> On Thu, 26 Nov 2015 12:01:23 +0100,
> Mark Brown wrote:
> > 
> > On Thu, Nov 26, 2015 at 10:19:51AM +0100, Takashi Iwai wrote:
> > > Vinod Koul wrote:
> > 
> > > > So in SKL, we do request firmware of topology binary and topology core uses
> > > > that for strings here, so the patch 87b5ed8ec freed the topology binary
> > > > which causes panic while accessing kcontrols.
> > 
> > > This is strange.  If it's about the kctl name string, the panic
> > > shouldn't happen at accessing the kctl but at instantiating the kctl
> > > from snd_kcontrol_new that contains the invalid string pointer.
> > > The kctl object contains the string in itself, and there copies the
> > > string from the template.
> > 
> > I guess it's possible that if the control creation happens soon enough
> > after the memory is freed the data will still be valid.  This could be
> > tested for by hacking things to deliberately trash the memory before we
> > get to control creation.
> > 
> > > You really need to identify which path hits the issue exactly how.  In
> > > general, the string passed to template is only for creating the kctl.
> > > Once when kctl is created, the whole snd_kcontrol_new template and the
> > > allocated string is no use, so they can be freed.
> > 
> > That does suggest a fairly simple fix of just holding on to the firmware
> > for longer assuming that the analysis is correct.
> 
> Right, that would be the simplest fix.  Just assure that the whole f/w
> image is kept until all objects are instantiated.

Yes, going by the discussion here, we can then free the topology firmware
later, but then question is how do we know when is the card completely
instantiated and we can free the topology binary... I do not know how..

Only thing I can think of is to free this is driver .remove()

So then we can simply revert 87b5ed8ecb : ('ASoC: Intel: Skylake: fix memory
leak) and then add a new one..

Thanks
-- 
~Vinod
