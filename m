From: Michal Hocko <mhocko@suse.cz>
Subject: Re: [alsa-devel] Headphone output doesn't work with 3.0.0-rc* anymore
Date: Fri, 10 Jun 2011 11:30:19 +0200
Message-ID: <20110610093019.GC4110@tiehlicka.suse.cz>
References: <20110609090607.GB4207@tiehlicka.suse.cz>
 <s5hei33xsxn.wl%tiwai@suse.de>
 <20110609092826.GC4207@tiehlicka.suse.cz>
 <s5haadrxrsm.wl%tiwai@suse.de>
 <20110609111401.GA3994@tiehlicka.suse.cz>
 <s5htybyw52q.wl%tiwai@suse.de>
 <20110610075640.GA4832@tiehlicka.suse.cz>
 <s5hk4cuw1be.wl%tiwai@suse.de>
 <20110610085117.GA4110@tiehlicka.suse.cz>
 <s5haadqvybo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5haadqvybo.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri 10-06-11 11:18:51, Takashi Iwai wrote:
> At Fri, 10 Jun 2011 10:51:17 +0200,
> Michal Hocko wrote:
> > 
> > On Fri 10-06-11 10:14:13, Takashi Iwai wrote:
> > > At Fri, 10 Jun 2011 09:56:40 +0200,
> > > Michal Hocko wrote:
> > > > 
> > > > On Fri 10-06-11 08:53:01, Takashi Iwai wrote:
> > > > > At Thu, 9 Jun 2011 13:14:01 +0200,
[...]
> > > > OK, I git checkout v2.6.39 -- sound/pci/*.[ch] (see the patch bellow for
> > > > reference). I have kept the earlier patch.
> > > 
> > > Gah, sorry, a wrong path.  It must be sound/pci/hda/*.[ch].
> > > Also, please remove my previous patch.  It's irrelevant with 2.6.39
> > > although it should be harmless.
> > 
> > OK, I have reverted the whole hda directory to 2.6.39 which means AFAIU
> > that the driver is at the same state as it was in that kernel. And the
> > sound really works. Both outputs are active whem they should be.
> 
> Thanks, it's really good to know that we have a good working-base.
> 
> Now, can you switch back to 3.0rc2 with my fix patch and retest?

Sorry, I am confused now. How this would be different from the previous
testing where I had that patch applied on top of rc2?

-- 
Michal Hocko
SUSE Labs
SUSE LINUX s.r.o.
Lihovarska 1060/12
190 00 Praha 9    
Czech Republic
