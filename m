From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH v7 4/7] ALSA: hda - Update to use the new
 jack kctls method
Date: Wed, 22 Apr 2015 04:56:00 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A90551DE3D@SHSMSX101.ccr.corp.intel.com>
References: <1429603545-21063-1-git-send-email-yang.jie@intel.com>
 <1429603545-21063-5-git-send-email-yang.jie@intel.com>
 <s5hmw21zttl.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id E78F22652D1
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2015 06:56:09 +0200 (CEST)
In-Reply-To: <s5hmw21zttl.wl-tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Tuesday, April 21, 2015 5:59 PM
> To: Jie, Yang
> Cc: broonie@kernel.org; alsa-devel@alsa-project.org; Girdwood, Liam R
> Subject: Re: [PATCH v7 4/7] ALSA: hda - Update to use the new jack kctls
> method
> 
> At Tue, 21 Apr 2015 16:05:42 +0800,
> Jie Yang wrote:
> >
> > In the new jack kctls design, snd_kcontrol can be created during
> > snd_jack_new(), or calling snd_jack_add_new_kctls() to create and
> > attach to the created jack later.
> >
> > Here we create jack kctls at the jack creating stage, for both
> > phantom/non-phantom jack.
> >
> > Signed-off-by: Jie Yang <yang.jie@intel.com>
> > ---
> >  sound/pci/hda/hda_jack.c | 53
> > +++++++++++++++++-------------------------------
> >  sound/pci/hda/hda_jack.h |  4 +---
> >  2 files changed, 20 insertions(+), 37 deletions(-)
> >
> > diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c index
> > f45c488..3447853 100644
> > --- a/sound/pci/hda/hda_jack.c
> > +++ b/sound/pci/hda/hda_jack.c
> > @@ -132,11 +132,11 @@ void snd_hda_jack_tbl_clear(struct hda_codec
> > *codec)
> >
> >  	for (i = 0; i < codec->jacktbl.used; i++, jack++) {
> >  		struct hda_jack_callback *cb, *next; -#ifdef
> > CONFIG_SND_HDA_INPUT_JACK
> > +
> >  		/* free jack instances manually when clearing/reconfiguring
> */
> >  		if (!codec->bus->shutdown && jack->jack)
> >  			snd_device_free(codec->bus->card, jack->jack); -
> #endif
> > +
> >  		for (cb = jack->callback; cb; cb = next) {
> >  			next = cb->next;
> >  			kfree(cb);
> > @@ -337,20 +337,16 @@ void snd_hda_jack_report_sync(struct
> hda_codec *codec)
> >  	jack = codec->jacktbl.list;
> >  	for (i = 0; i < codec->jacktbl.used; i++, jack++)
> >  		if (jack->nid) {
> > -			if (!jack->kctl || jack->block_report)
> > +			if (!jack->jack_kctl || jack->block_report)
> 
> The all checks of jack->kctl should be replaced with jack->jack.
> That is, you don't have to care about kctl any longer in the hdaudio side.
 
OK, will change them.

> 
> 
> Takashi
