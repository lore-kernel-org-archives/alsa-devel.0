From: "Sebastian H." <vand2@gmx.de>
Subject: Re: Alsamixer-Qt4 0.4.0 released
Date: Sun, 26 Sep 2010 12:36:09 +0200
Message-ID: <4C9F2219.9040304@gmx.de>
References: <4C595A52.7030401@gmx.de>	<AANLkTimM9L=_Day945Y0XQZotLN7-HrXZbiWuO5dCO65@mail.gmail.com>	<4C9DD21C.4000505@gmx.de>
	<AANLkTi=4Uc_vy1xTZMzxy3Komt4up+OAAnioPZdAiO26@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by alsa0.perex.cz (Postfix) with SMTP id B971F244BA
	for <alsa-devel@alsa-project.org>;
	Sun, 26 Sep 2010 12:37:35 +0200 (CEST)
In-Reply-To: <AANLkTi=4Uc_vy1xTZMzxy3Komt4up+OAAnioPZdAiO26@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Am 26.09.2010 01:56, schrieb Raymond Yau:
> 2010/9/25 Sebastian H. <vand2@gmx.de>
> 
>>
>>
>> snd_mixer_selem_is_active() has been ignored so far since I wasn't sure
>> what it really meant.
>>
>> Seems the proper way to handle and *inactive* element is to hide the
>> slider/switch/enum widgets completely.
>> Alternatively they could be greyed out. But showing dead
>> widgets would probably just distract users and waste screen space.
>>
>> Btw. I'm still working on a alsamixer-qt4. There've been just so many
>> changes in the background that it takes some time to stabilize
>> everything again. And there're still open issues (mostly QT stuff).
>> So I would estimate two or three more weeks for a new release.
>>
> 
> Seem I have quoted a wrong example
> 
> Refer to patch_via.c , when "Independent Headphone" switch is on/off,
> In via_independent_hp_put() function call activate_ctl() which set the
> "Headphone Playback volume" and "Headphone Playback switch" controls to
> active/inactive
> 
> This mean that the controls are only temporary inactive and can become
> active again
> the driver also call snd_ctl_notify(codec->bus->card,
> SNDRV_CTL_EVENT_MASK_VALUE, &ctl->id)
> 
> Does it mean that the mixer application receive an event about the change of
> the active/inactive state of the control ?

The quick answer is likely yes.
Although the active/inactive evaluation part
it is not implemented, yet. But this shouldn't be too difficult with
the new dynamic design which roughly looks like this.

Buffer A - Offline buffer in in the background.
           Contains snd_mixer_t and snd_mixer_elem_t structs.
           Gets created once during mixer loading (or reloading).

Buffer B - Online buffer. Corresponds to the widgets.
           The layout (also means widgets visibility) can be changed
           on demand.


The value update flow then goes somewhat like this

- Socket event on the snd_mixer_t!
- Read the whole mixer state from the snd_* functions into Buffer A
- Value evaluation in Buffer A.
  On demand:
  - Adjust Buffer B to separate sliders with unequal channel values
  - Adjust Buffer B to hide/reveal inactive/active sliders (to be done)
- Copy the state from Buffer A into Buffer B updating the GUI widgets.

The slider separation already works (and is pretty neat :).
Though there still is an issue with channel values changing
one by one and not all together. This makes the Buffer A evaluator
think the sliders should be separated just to become equal again
directly after. I already thought about introducing a delay of a
second or so for slider separation (to be done).

The active/inactive state evaluation will be another check in the Buffer
A evaluation step. The check then can adjust Buffer B to
show/hide the respective GUI widget (to be done).
