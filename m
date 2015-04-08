From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH v4 0/5] ALSA: jack: Refactoring for jack
 kctls
Date: Wed, 8 Apr 2015 07:59:12 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A90550618B@shsmsx102.ccr.corp.intel.com>
References: <1428062838-14786-1-git-send-email-yang.jie@intel.com>
 <s5h1tjvq5wd.wl-tiwai@suse.de> <5524D6D8.60205@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id CD7C3265122
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 09:59:17 +0200 (CEST)
In-Reply-To: <5524D6D8.60205@canonical.com>
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
> Sent: Wednesday, April 08, 2015 3:21 PM
> To: Takashi Iwai; Jie, Yang
> Cc: alsa-devel@alsa-project.org; broonie@kernel.org; Girdwood, Liam R
> Subject: Re: [alsa-devel] [PATCH v4 0/5] ALSA: jack: Refactoring for jack kctls
> 
> 
> 
> On 2015-04-07 18:06, Takashi Iwai wrote:
> > This would work, yes.  But, I have some uneasy feeling, something not
> > well digested...
> >
> > Ideally, we want a single API for representing both input and kctl
> > jacks.
> 
> Maybe this is somewhat my fault for steering Yang in that direction. But the
> requirements are somewhat different.
> 
> HDA has the phantom jacks, and the exact naming for each kctl requirements.
> ASoC has the combination/button requirements, i e one jack can represent
> more than one kctl.
> 
> The phantom jack requirement means that the snd_kctl_jack_new API
> cannot be removed straight away; we could move it to be internal to HDA
> (it's not much code anyway), but I don't see a need for that.
> 
> But the HDA code can be moved around to look like this:
> 
>     if (phantom_jack) {
>        snd_kctl_jack_new();

Let me add line here to clarify:
+        snd_hda_ctl_add();

>     }
>     else {
>        snd_jack_new();
>        snd_jack_add_new_kctls();

I thought of this at the beginning, as you talk below, it looks more like what
we did for ASoC case.

What I concern here is that it may make input jack kctl looks like a little
different with before(I am not sure, maybe you guys are more clearly about
what will occurs without calling snd_ctl_add()-->snd_array_new()...)? 

>     }
> 
> Now the HDA looks more like the ASoC variant. Yang, what do you think
> about that? That would make the API simpler, wouldn't it?

Here repeat what I stated in another reply:

For jack creating, we use the same API -- snd_jack_new();

For kctl creating, yes, we use different APIs:
snd_jack_kctl_new() for input jacks(HDA),
snd_jack_add_kctls() for kctl jacks(ASoC).

There are 2 reasons that I made them different:
1. a. for HDA phantom jack, in the old/exist logic, __snd_hda_jack_add_kctl()
will also call snd_kctl_jack_new() and snd_hda_ctl_add(), it will create kctls 
and add them to card(also assigning some arrays, they are different with calling
snd_ctl_add() only, which is what we will do for ASoC kctl adding); 
    b. for HDA input/phantom jack, all of those occurs before calling 
snd_jack_new().

So, we have to split jack new and kctl new functions here, because for HDA 
phantom/input jack and ASoC kctl jack, they are quite different here.

2. we may need generate kctl name for ASoC kctls(snd_jack_kctl_name_gen(), 
removing suffix " Jack" as you proposed before, or everything needed after); 
but for HDA input jack kctls, the naming has been finished before calling 
__snd_hda_jack_add_kctl(), we should not change them anymore. 

Thanks,
~Keyon
> 
> --
> David Henningsson, Canonical Ltd.
> https://launchpad.net/~diwic
