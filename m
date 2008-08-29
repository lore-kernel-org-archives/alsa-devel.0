From: Liam Girdwood <lrg@kernel.org>
Subject: Re: get rid of controls with snd_ctl_remove
Date: Fri, 29 Aug 2008 14:16:52 +0100
Message-ID: <1220015812.6499.42.camel@odin>
References: <200808291454.42441.harryrat@postnuklear.de>
	<s5hhc94gel4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 8DE6024421
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Aug 2008 15:16:57 +0200 (CEST)
In-Reply-To: <s5hhc94gel4.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Harald Radke <harryrat@postnuklear.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2008-08-29 at 15:01 +0200, Takashi Iwai wrote:
> At Fri, 29 Aug 2008 14:54:42 +0200,
> Harald Radke wrote:
> > 
> > Hi there!
> > 
> > Please be patient with me, I am quite inexperienced with alsa programming, so 
> > this might be a dumb question:
> > 
> > We have a WM8750 working in our PDA, the codec is working so far but I want to 
> > remove some of the control since they aren't needed.
> > 
> > Instead of copying the wm8750.c file and adjusting it, I want to write another 
> > module which basically get rid of those controls, something like:
> > 
> > [...]
> > 
> > static const char* unused_controls[] = {"AAAA", "BBBB,"CCCC"};
> > 
> >         struct snd_kcontrol *ctl;
> > 
> >         list_for_each_entry(ctl, &card->controls, list)
> 
> You can't use list_for_each_entry() together with removal.
> Use list_for_each_entry_safe() for such a purpose.
> 
> But...
> 
> >           for(i=0; i <  ARRAY_SIZE(unused_controls); i++)
> >             if (!strcmp(unused_controls[i],ctl->id.name)) {
> >               down_write(&card->controls_rwsem);
> >               snd_ctl_remove(card,ctl);
> >               up_write(&card->controls_rwsem);
> >               break;
> >             }
> 
> It'd be easier like the following:
> 
> 	for (i = 0; i < ARRAY_SIZE(unused_controls); i++) {
> 		struct snd_ctl_elem_id id;
> 		memset(&id, 0, sizeof(id));
> 		strcpy(id.name, unused_controls[i]);
> 		id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
> 		snd_ctl_remove_id(card, &id);
> 	}

I'd prefer an addition to our API to handle this more _common_ case
rather than just removing controls. 

Something where we can mark controls as "disabled" so alsamixer and
friends wont render/get them. This would also allow scenario code to
disable relevant mixers and then re-enable when required.

Liam
