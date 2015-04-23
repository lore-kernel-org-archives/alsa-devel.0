From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH v9 0/7] ALSA: jack: Refactoring for jack
	kctls
Date: Thu, 23 Apr 2015 13:45:07 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A90551F692@SHSMSX101.ccr.corp.intel.com>
References: <1429756366-22520-1-git-send-email-yang.jie@intel.com>
 <s5h8udjko4m.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 6AEA1261A84
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 15:45:19 +0200 (CEST)
In-Reply-To: <s5h8udjko4m.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "tanu.kaskinen@linux.intel.com" <tanu.kaskinen@linux.intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thursday, April 23, 2015 8:47 PM
> To: Jie, Yang
> Cc: broonie@kernel.org; alsa-devel@alsa-project.org; Girdwood, Liam R;
> tanu.kaskinen@linux.intel.com
> Subject: Re: [PATCH v9 0/7] ALSA: jack: Refactoring for jack kctls
> 
> At Thu, 23 Apr 2015 10:32:39 +0800,
> Jie Yang wrote:
> >
> > Currently only hda will create kctls for hda jacks, for asoc, people
> > may need create jack kctls in specific driver.
> >
> > Here we are introducing kctls for each jack, by creating kctls and add
> > them to jack controls list (considering exist of combo jack). At the
> > same time, we will report events for each control in the list.
> >
> > With this new implementation, both HDA and soc jack kctls works fine,
> > they are compatible for old HDA jack kctls, too.
> >
> > For soc,
> > a. snd_jack_new() with NULL jack_kctl; b. for each pin, call
> > snd_jack_add_kctls() to add one kctl(it will call snd_ctl_add() to add
> > kctl to card);
> >
> > For HDA,
> > With snd_jack_new(), we can use phantom_jack = true for phantom jack
> > creating, and the jack kctl pointer will be filled with the new
> > created kcontrol.
> >
> > Changes in v9:
> > 1. move struct snd_jack_kctl definition to jack.c, to hides the
> > internal implementation details; 2. some small code fixing; 3. update
> > documentation file.
> >
> > Changes in v8:
> > 1. remove snd_jack_kctl from HDA part, change snd_jack_new param to
> > use bool for creating kcontrol at jack creating stage; 2. create jack
> > for phantom jack, with no input device; 3. remove HDA jack
> > get_unique_index() and index related code.
> >
> > Changes in v7:
> > 1. move name generating and index getting part into ctljack.c; 2.
> > remove exposing private_data and destructor to hda, then jack core can
> > handle kctls by itself totally.
> > 3. some small code fixing.
> >
> > Changes in v6:
> > 1. refine kctl name generating function; 2. integrate HDA jack kctl
> > more deeply, support phantom jack in snd_jack_new(); 3. add
> > documentation for Jack kcontrols to explain how to use it.
> >
> > Changes in v5:
> > 1. remove SND_KCTL_JACK config item, we need jack kctl once
> > CONFIG_SND_JACK is selected.
> >
> > Changes in v4:
> > 1. use snd_ctl_find_id() to get avaliable index; 2. add initial kctl
> > for snd_jack_new(compatible for HDA); 3. add struct snd_jack_kctl *
> > field to struct hda_jack_tbl; 4. new kctls for soc jack during jack
> > pins creating.
> > 5. add a patch to remove exporting snd_kctl_jack_new().
> >
> > Changes in v3:
> > 1. replace bit index with bit mask in jack_kctl; 2. add exception for
> > SND_JACK_HEADSET and SND_JACK_AVOUT, only create one jack kctl for
> > these two combo jacks, respectively.
> > 3. add NULL check, mem kfree, and fix some potential risk.
> >
> > Change in v2:
> > 1. define jack_kctl struct, and put jack kctl related stuff there; 2.
> > add a patch to remove the existing controls for HDA jack.
> >
> > Jie Yang (7):
> >   ALSA: jack: implement kctl creating for jack device
> >   ALSA: Jack: handle jack embedded kcontrol creating within ctljack
> >   ALSA: jack: extend snd_jack_new to support phantom jack
> >   ALSA: hda - Update to use the new jack kctls method
> >   ASoC: jack: create kctls according to jack pins info
> >   ALSA: jack: remove exporting ctljack functions
> >   ALSA: Docs: Add documentation for Jack kcontrols
> 
> Thanks, now the series look almost good, but still a few things to be
> fixed:
> 
> - Please rebase it on top of for-linus branch (or Linus tree).
>   Some patches can't be applied cleanly due to recent HD-audio
>   reworks.

OK, I will rebase it on top of your for-linus branch and resend. 

> 
> - Fix typos and syntax errors in comments and descriptions.
>   A spell checker is your friend.
 
I just download one from git://github.com/mprpic/git-spell-check.git,
now learning to use it, do you have better suggestion?

> 
> - The kerneldoc comment doesn't have to be applied to static
>   functions.  Drop an asterisk from "/**" from snd_jack_kctl_new().
 
OK, will remove it.

> 
> - For ASoC change, I'd like to have an ack from Mark.
>   It's a trivial addition but I'm not sure whether he is satisfied
>   with this new style.
 
Understood. 

Hi, Mark, per my understanding, we didn't create specific kcontrols for
each ASoC jack, now, my new change reuse the jack pins' info to create
these kcontrols, which can be seen and controlled from upper layer
(e.g. PA). 

I checked it on Broadwell-rt286 platform, together with ucm config file,
here pulseaudio can switch on/off headphone/mic kcontrols for headset
jack fluently.

How do you think about this implementation? Are there any risk or side
effect for it in your opinion?

~Keyon
> 
> 
> Takashi
