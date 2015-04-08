From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH v4 0/5] ALSA: jack: Refactoring for jack
 kctls
Date: Wed, 8 Apr 2015 09:18:10 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A905506247@shsmsx102.ccr.corp.intel.com>
References: <1428062838-14786-1-git-send-email-yang.jie@intel.com>
 <s5h1tjvq5wd.wl-tiwai@suse.de> <5524D6D8.60205@canonical.com>
 <E7B1D079BA13FB44A978CC8F69C7D6A90550618B@shsmsx102.ccr.corp.intel.com>
 <5524E677.2020803@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id A1CA42651AC
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 11:18:17 +0200 (CEST)
In-Reply-To: <5524E677.2020803@canonical.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: David Henningsson [mailto:david.henningsson@canonical.com]
> Sent: Wednesday, April 08, 2015 4:28 PM
> To: Jie, Yang; Takashi Iwai
> Cc: alsa-devel@alsa-project.org; broonie@kernel.org; Girdwood, Liam R
> Subject: Re: [alsa-devel] [PATCH v4 0/5] ALSA: jack: Refactoring for jack kctls
> 
> 
> 
> On 2015-04-08 09:59, Jie, Yang wrote:
> >> -----Original Message-----
> >> From: David Henningsson [mailto:david.henningsson@canonical.com]
> >> Sent: Wednesday, April 08, 2015 3:21 PM
> >> To: Takashi Iwai; Jie, Yang
> >> Cc: alsa-devel@alsa-project.org; broonie@kernel.org; Girdwood, Liam R
> >> Subject: Re: [alsa-devel] [PATCH v4 0/5] ALSA: jack: Refactoring for
> >> jack kctls
> >>
> >>
> >>
> >> On 2015-04-07 18:06, Takashi Iwai wrote:
> >>> This would work, yes.  But, I have some uneasy feeling, something
> >>> not well digested...
> >>>
> >>> Ideally, we want a single API for representing both input and kctl
> >>> jacks.
> >>
> >> Maybe this is somewhat my fault for steering Yang in that direction.
> >> But the requirements are somewhat different.
> >>
> >> HDA has the phantom jacks, and the exact naming for each kctl
> requirements.
> >> ASoC has the combination/button requirements, i e one jack can
> >> represent more than one kctl.
> >>
> >> The phantom jack requirement means that the snd_kctl_jack_new API
> >> cannot be removed straight away; we could move it to be internal to
> >> HDA (it's not much code anyway), but I don't see a need for that.
> >>
> >> But the HDA code can be moved around to look like this:
> >>
> >>      if (phantom_jack) {
> >>         snd_kctl_jack_new();
> >
> > Let me add line here to clarify:
> > +        snd_hda_ctl_add();
> >
> >>      }
> >>      else {
> >>         snd_jack_new();
> >>         snd_jack_add_new_kctls();
> >
> > I thought of this at the beginning, as you talk below, it looks more
> > like what we did for ASoC case.
> >
> > What I concern here is that it may make input jack kctl looks like a
> > little different with before(I am not sure, maybe you guys are more
> > clearly about what will occurs without calling snd_ctl_add()--
> >snd_array_new()...)?
> 
> I'm not sure I understand this question. Maybe the answers below help
> answering it?
 
Right.

> 
> >>      }
> >>
> >> Now the HDA looks more like the ASoC variant. Yang, what do you think
> >> about that? That would make the API simpler, wouldn't it?
> >
> > Here repeat what I stated in another reply:
> >
> > For jack creating, we use the same API -- snd_jack_new();
> >
> > For kctl creating, yes, we use different APIs:
> > snd_jack_kctl_new() for input jacks(HDA),
> > snd_jack_add_kctls() for kctl jacks(ASoC).
> >
> > There are 2 reasons that I made them different:
> > 1. a. for HDA phantom jack, in the old/exist logic,
> > __snd_hda_jack_add_kctl() will also call snd_kctl_jack_new() and
> > snd_hda_ctl_add(), it will create kctls and add them to card(also
> > assigning some arrays, they are different with calling
> > snd_ctl_add() only, which is what we will do for ASoC kctl adding);
> 
> Actually, now that I look at snd_hda_ctl_add, I don't know why we need to
> call it for HDA jacks. There does not seem to be anything relevant for HDA
> jacks there. I think we can just call snd_ctl_add for HDA jacks too.

OK, then it may make life easier.  Hi Takashi, you agree with this?
Do we need add those kctls to the HDA codec, or to hda_nid_item?

> 
> With your refactoring, all we need to remember is to remove the jacks (i e
> both the input device and the kctls) in both snd_hda_codec_reset and
> snd_hda_codec_free, and I suspect this is already taken care of?

Yes, in my solution, almost nothing change for HDA jack, that is:
in  snd_hda_codec_reset/free, 
snd_hda_ctls_clear() is called, where the kctls will be removed;
snd_hda_jack_tbl_clear() is called, Where the jacks will be removed.

> 
> >      b. for HDA input/phantom jack, all of those occurs before calling
> > snd_jack_new().
> 
> My point is that it would be possible to move the HDA code around so that
> snd_jack_new is called first. And with Takashi's suggestion of a
> "create_input_dev" flag, it would be called for both real and phantom jacks.
 
I can add this if it is really needed.

> 
> > So, we have to split jack new and kctl new functions here, because for
> > HDA phantom/input jack and ASoC kctl jack, they are quite different here.
> >
> > 2. we may need generate kctl name for ASoC
> > kctls(snd_jack_kctl_name_gen(), removing suffix " Jack" as you
> > proposed before, or everything needed after); but for HDA input jack
> > kctls, the naming has been finished before calling
> __snd_hda_jack_add_kctl(), we should not change them anymore.
> 
> snd_jack_kctl_name_gen seems only to remove a " Jack" suffix. I think we
> can safely call it for both ASoC and HDA jacks. If a HDA jack ends up being
> labelled something with " Jack Jack", it's a bug anyway.
> 
> (Side note: but you might want to fix snd_jack_kctl_name_gen to make
> strange names like "My Jacket Computer" not be cropped to "My Jacket
> Com")

Thanks for pointing out this, fixed now. 

> 
> --
> David Henningsson, Canonical Ltd.
> https://launchpad.net/~diwic
