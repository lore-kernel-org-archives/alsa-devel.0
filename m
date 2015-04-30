From: Bram Bos <buramu@gmail.com>
Subject: Re: Simple Mixer help
Date: Thu, 30 Apr 2015 13:51:06 +0200
Message-ID: <CAPaK8baHETB0trSEug0Qv7ZiA7M7tUcCrK6YiDiDdQC-LeD8_g@mail.gmail.com>
References: <CAPaK8bb7mvNjf-EwEciBQth68hRWvXEE5cwAqUdRBk5QcXRqYw@mail.gmail.com>
 <CAPaK8baiMvLVkn5=Q8RkR-v0TjAugaYBZR9+=tnbtCv2xa84KA@mail.gmail.com>
 <s5hvbgedjs0.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f169.google.com (mail-ob0-f169.google.com
 [209.85.214.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 005572614F4
 for <Alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 13:51:07 +0200 (CEST)
Received: by obblk2 with SMTP id lk2so3123907obb.0
 for <Alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 04:51:06 -0700 (PDT)
In-Reply-To: <s5hvbgedjs0.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Problem solved, thanks Takashi!

Archiving for benefit of future generations, here's what made it work for
me:

void SetAlsaMasterVolume(long volume){
     long min, max;
     snd_mixer_t *handle;
     snd_mixer_selem_id_t *sid;
     const char *card = "hw2"; // just for this example, don't hard-code
this!
     const char *selem_name = "PCM"; // for some reason Master didn't work,
but PCM does...

     snd_mixer_open(&handle, 0);
     snd_mixer_attach(handle, card);
     snd_mixer_selem_register(handle, NULL, NULL);
     snd_mixer_load(handle);

     snd_mixer_selem_id_alloca(&sid);
     snd_mixer_selem_id_set_index(sid, 0); // no need to change the index
in this case
     snd_mixer_selem_id_set_name(sid, selem_name);
     snd_mixer_elem_t* elem = snd_mixer_find_selem(handle, sid);

     snd_mixer_selem_get_playback_volume_range(elem, &min, &max);
     snd_mixer_selem_set_playback_volume_all(elem, volume * max / 100);

     snd_mixer_close(handle);
}


2015-04-30 11:53 GMT+02:00 Takashi Iwai <tiwai@suse.de>:

> At Thu, 30 Apr 2015 10:29:14 +0200,
> Bram Bos wrote:
> >
> > Ok, so perhaps this is not the forum to ask support for using ALSA in
> > application development.
>
> It's no wrong place, but not everybody has enough time, so be patient
> :)
>
> > Can anyone point me to a place where I can ask such questions.?
> >
> > The existing ALSA documentation is not sufficient to help me out here.
>
> The device name concept isn't written so much, although it's a quite
> basic idea.  Maybe someone should work on it.
>
> As you have already noticed, ALSA device may contain the card number.
> For the control / mixer API, you can get the direct access to a
> certain hardware with "hw:X" name string where X is the card number.
>
>
> Takashi
>
> >
> > Thanks!
> >
> > 2015-04-29 16:15 GMT+02:00 Bram Bos <buramu@gmail.com>:
> >
> > > I want to get access to the ALSA Simple Mixer interface, but rather
> than
> > > the 'default' sound device I want to target a specific USB sound
> device.
> > >
> > > I'm at a loss how to refer to it...  I am using a modified version of
> the
> > > code below but I have no idea what to replace the "card" and
> "selem_name"
> > > strings with. The device name? The 'hwX.Y' string?
> > >
> > > And do I need to change the index#?
> > >
> > > Too many variables to solve this by trial and error.
> > > Any hints appreciated!
> > >
> > > void SetAlsaMasterVolume(long volume){
> > >     long min, max;
> > >     snd_mixer_t *handle;
> > >     snd_mixer_selem_id_t *sid;
> > >     const char *card = "default";
> > >     const char *selem_name = "Master";
> > >
> > >     snd_mixer_open(&handle, 0);
> > >     snd_mixer_attach(handle, card);
> > >     snd_mixer_selem_register(handle, NULL, NULL);
> > >     snd_mixer_load(handle);
> > >
> > >     snd_mixer_selem_id_alloca(&sid);
> > >     snd_mixer_selem_id_set_index(sid, 0);
> > >     snd_mixer_selem_id_set_name(sid, selem_name);
> > >     snd_mixer_elem_t* elem = snd_mixer_find_selem(handle, sid);
> > >
> > >     snd_mixer_selem_get_playback_volume_range(elem, &min, &max);
> > >     snd_mixer_selem_set_playback_volume_all(elem, volume * max / 100);
> > >
> > >     snd_mixer_close(handle);}
> > >
> > >
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
>
