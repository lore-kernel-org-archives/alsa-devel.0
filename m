From: Andrei Popa <andrei.popa@i-neo.ro>
Subject: Re: [ALSA][hda-codec] fix-connexant-headphone-mute
Date: Wed, 02 May 2007 14:28:56 +0300
Message-ID: <1178105336.6255.2.camel@localhost>
References: <1177811017.23940.7.camel@localhost>
	<1177813190.10642.1.camel@localhost> <s5hslafbkdz.wl%tiwai@suse.de>
	<1178102873.7511.3.camel@localhost>  <s5hlkg7bibm.wl%tiwai@suse.de>
Reply-To: andrei.popa@i-neo.ro
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from megainternet.ro (unknown [85.204.20.254])
	by alsa0.perex.cz (Postfix) with ESMTP id 08D72243FA
	for <alsa-devel@alsa-project.org>;
	Wed,  2 May 2007 13:29:08 +0200 (CEST)
In-Reply-To: <s5hlkg7bibm.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2007-05-02 at 13:01 +0200, Takashi Iwai wrote: 
> [keep cc to alsa-devel please]

I am not subscribed to alsa-devel and when I send there a mail I get a
replay:
"
Your mail to 'Alsa-devel' with the subject

    Re: [ALSA][hda-codec] fix-connexant-headphone-mute

Is being held until the list moderator can review it for approval.

The reason it is being held:

    Post by non-member to a members-only list
"

> 
> At Wed, 02 May 2007 13:47:53 +0300,
> Andrei Popa wrote:
> > 
> > On Wed, 2007-05-02 at 12:16 +0200, Takashi Iwai wrote:
> > > At Sun, 29 Apr 2007 05:19:50 +0300,
> > > Andrei Popa wrote:
> > > > 
> > > > On Sun, 2007-04-29 at 04:43 +0300, Andrei Popa wrote:
> > > > > Hi,
> > > > > 
> > > > > The sound works ok with the built-in speakers on my Fujitsu laptop(amilo
> > > > > pro v3205). But if I plug in headphones in the audio out jack there is
> > > > > no sound in the headphones. With kernel 2.6.20 it worked ok. With 2.6.21
> > > > > it doesn't.
> > > > > This BUG is reported in ALSA bugtracking system with ID 0003039.
> > > > > 
> > > > > Patch that fixes this bug:
> > > > > 
> > > > > diff --git a/sound/pci/hda/patch_conexant.c
> > > > > b/sound/pci/hda/patch_conexant.c
> > > > > index 46e93c6..5edd330 100644
> > > > > --- a/sound/pci/hda/patch_conexant.c
> > > > > +++ b/sound/pci/hda/patch_conexant.c
> > > > > @@ -636,7 +636,7 @@ static void cxt5045_hp_automute(struct hda_codec
> > > > > *codec)
> > > > > 
> > > > >         bits = (spec->hp_present || !spec->cur_eapd) ? 0x80 : 0;
> > > > >         snd_hda_codec_amp_update(codec, 0x10, 0, HDA_OUTPUT, 0, 0x80,
> > > > > bits);
> > > > > -       snd_hda_codec_amp_update(codec, 0x10, 1, HDA_OUTPUT, 0, 0x80,
> > > > > bits);
> > > > > +       snd_hda_codec_amp_update(codec, 0x10, 1, HDA_OUTPUT, 0, 0,
> > > > > bits);
> > > > >  }
> > > > > 
> > > > >  /* unsolicited event for HP jack sensing */
> > > > > @@ -988,10 +988,10 @@ static void cxt5047_hp_automute(struct hda_codec
> > > > > *codec)
> > > > > 
> > > > >         bits = (spec->hp_present || !spec->cur_eapd) ? 0x80 : 0;
> > > > >         snd_hda_codec_amp_update(codec, 0x1d, 0, HDA_OUTPUT, 0, 0x80,
> > > > > bits);
> > > > > -       snd_hda_codec_amp_update(codec, 0x1d, 1, HDA_OUTPUT, 0, 0x80,
> > > > > bits);
> > > > > +       snd_hda_codec_amp_update(codec, 0x1d, 1, HDA_OUTPUT, 0, 0,
> > > > > bits);
> > > > >         /* Mute/Unmute PCM 2 for good measure - some systems need this
> > > > > */
> > > > >         snd_hda_codec_amp_update(codec, 0x1c, 0, HDA_OUTPUT, 0, 0x80,
> > > > > bits);
> > > > > -       snd_hda_codec_amp_update(codec, 0x1c, 1, HDA_OUTPUT, 0, 0x80,
> > > > > bits);
> > > > > +       snd_hda_codec_amp_update(codec, 0x1c, 1, HDA_OUTPUT, 0, 0,
> > > > > bits);
> > > > >  }
> > > > > 
> > > > >  /* toggle input of built-in and mic jack appropriately */
> > > > > 
> > > > 
> > > > first patch was broken. it only worked for the right channel.
> > > > this fixes this:
> > > > 
> > > > diff --git a/sound/pci/hda/patch_conexant.c
> > > > b/sound/pci/hda/patch_conexant.c
> > > > index 46e93c6..0822df7 100644
> > > > --- a/sound/pci/hda/patch_conexant.c
> > > > +++ b/sound/pci/hda/patch_conexant.c
> > > > @@ -635,8 +635,8 @@ static void cxt5045_hp_automute(struct hda_codec
> > > > *codec)
> > > >                                      AC_VERB_GET_PIN_SENSE, 0) &
> > > > 0x80000000;
> > > > 
> > > >         bits = (spec->hp_present || !spec->cur_eapd) ? 0x80 : 0;
> > > > -       snd_hda_codec_amp_update(codec, 0x10, 0, HDA_OUTPUT, 0, 0x80,
> > > > bits);
> > > > -       snd_hda_codec_amp_update(codec, 0x10, 1, HDA_OUTPUT, 0, 0x80,
> > > > bits);
> > > > +       snd_hda_codec_amp_update(codec, 0x10, 0, HDA_OUTPUT, 0, 0,
> > > > bits);
> > > > +       snd_hda_codec_amp_update(codec, 0x10, 1, HDA_OUTPUT, 0, 0,
> > > > bits);
> > > >  }
> > > > 
> > > >  /* unsolicited event for HP jack sensing */
> > > > @@ -987,11 +987,11 @@ static void cxt5047_hp_automute(struct hda_codec
> > > > *codec)
> > > >                                      AC_VERB_GET_PIN_SENSE, 0) &
> > > > 0x80000000;
> > > > 
> > > >         bits = (spec->hp_present || !spec->cur_eapd) ? 0x80 : 0;
> > > > -       snd_hda_codec_amp_update(codec, 0x1d, 0, HDA_OUTPUT, 0, 0x80,
> > > > bits);
> > > > -       snd_hda_codec_amp_update(codec, 0x1d, 1, HDA_OUTPUT, 0, 0x80,
> > > > bits);
> > > > +       snd_hda_codec_amp_update(codec, 0x1d, 0, HDA_OUTPUT, 0, 0,
> > > > bits);
> > > > +       snd_hda_codec_amp_update(codec, 0x1d, 1, HDA_OUTPUT, 0, 0,
> > > > bits);
> > > >         /* Mute/Unmute PCM 2 for good measure - some systems need this
> > > > */
> > > > -       snd_hda_codec_amp_update(codec, 0x1c, 0, HDA_OUTPUT, 0, 0x80,
> > > > bits);
> > > > -       snd_hda_codec_amp_update(codec, 0x1c, 1, HDA_OUTPUT, 0, 0x80,
> > > > bits);
> > > > +       snd_hda_codec_amp_update(codec, 0x1c, 0, HDA_OUTPUT, 0, 0,
> > > > bits);
> > > > +       snd_hda_codec_amp_update(codec, 0x1c, 1, HDA_OUTPUT, 0, 0,
> > > > bits);
> > > >  }
> > > > 
> > > >  /* toggle input of built-in and mic jack appropriately */
> > > 
> > > But this means to _unmute_ the speaker (0x1d) when you plug HP.
> > > So, something else should be wrong.  Is hp_present detected properly
> > > per plugging or unplugging?
> > > 
> > 
> > when I debugged the problem I think hp_present was "0" when the HP were
> > plugged in and "-28953535"(a big negative number) when the HP were
> > unplugged.
> 
> Weird, then this returns exactly the inversed bit.
> Could you double-check?

I was mistaken, it's how you said it must be:

static void cxt5045_hp_automute(struct hda_codec *codec)
{
        struct conexant_spec *spec = codec->spec;
        unsigned int bits;

        spec->hp_present = snd_hda_codec_read(codec, 0x11, 0,
                                     AC_VERB_GET_PIN_SENSE, 0) &
0x80000000;

        printk(KERN_INFO "hp_present=%d\n",spec->hp_present);

        bits = (spec->hp_present || !spec->cur_eapd) ? 0x80 : 0;
        snd_hda_codec_amp_update(codec, 0x10, 0, HDA_OUTPUT, 0, 0,
bits);
        snd_hda_codec_amp_update(codec, 0x10, 1, HDA_OUTPUT, 0, 0,
bits);
}


hp_present=0 /* HP unplugged */
hp_present=-2147483648 /* HP plugged */


> 
> Anyway, having both this auto-mute and manual switches is confusing.
> If they exist, we'd need to add notifier to the control at unsol
> event handler.
> 
> 
> Takashi
