From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: amixer shows capability "penum" on every Simple
 mixer control
Date: Wed, 14 Mar 2012 20:35:33 +0800
Message-ID: <CAN8cciaC2vGjs0Ain4Pa1E54YDj31xdhk0JHZwKS1xFPr87WkQ@mail.gmail.com>
References: <2e03711055eba5b923f1983b3e7d6f1a@barbarenland.de>
	<s5h1uown7ze.wl%tiwai@suse.de> <s5h1uow39ul.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id DA869104507
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 13:35:33 +0100 (CET)
Received: by wibhn6 with SMTP id hn6so1949592wib.2
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 05:35:33 -0700 (PDT)
In-Reply-To: <s5h1uow39ul.wl%tiwai@suse.de>
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
Cc: "Christian Esken (KDE)" <esken@kde.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2012/3/13, Takashi Iwai <tiwai@suse.de>:
> At Tue, 13 Mar 2012 10:52:21 +0100,
> Takashi Iwai wrote:
>>
>> At Mon, 12 Mar 2012 22:09:35 +0100,
>> Christian Esken (KDE) wrote:
>> >
>> >  Hello,
>> >
>> >  when I run amixer it shows the capability "penum" on nearly every
>> >  Simple mixer control.
>> >  I posted the bug report
>> >  https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5496 , but
>> >  Raymond asked me to report it on this mailing list ("as it is related
>> > to
>> >  this patch 6d511eefa05878abee9f8b9145697230de605200 Implements support
>> >  for capture/playback enums.").
>> >
>> >  I posted  details for the following two examples in
>> >  https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5496 :
>> >
>> >  1) "Creative X-Fi" does not have any Enum's. alsamixer does not show
>> >  Enums's. amixer lists "penum" for ALL Simple mixer controls.
>> >
>> >  2) "HDA ATI SB" has no penum's, only 3 cenum's. alsamixer shows it
>> >  correctly, but amixer disagrees and shows penum for NEARLY ALL Simple
>> >  mixer controls (except for those with cpability "cenum").
>> >
>> >
>> >  I found this as I received several bug reports for KMix with "absurd"
>> >  amixer output. I could perceive from those bug report that the bug is
>> >  affecting a lot (or all?) sound cards.
>>
>> Looks like a bug in alsa mixer abstraction, indeed.
>> Will take a look at it later.
>
> I committed the fix to git tree now.  The fix patch is below.
>
>
> Takashi
>
> ---
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] mixer: Remove redundant CHECK_ENUM() from
> snd_mixer_selem_is_enum*()
>
> The functions to check whether the element is an enum don't need the
> extra check of the type.  It should return simply 0 or 1 without error.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  src/mixer/simple.c |    2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/src/mixer/simple.c b/src/mixer/simple.c
> index 8079fe7..ec22a9c 100644
> --- a/src/mixer/simple.c
> +++ b/src/mixer/simple.c
> @@ -889,7 +889,6 @@ int snd_mixer_selem_is_enumerated(snd_mixer_elem_t
> *elem)
>  int snd_mixer_selem_is_enum_playback(snd_mixer_elem_t *elem)
>  {
>  	CHECK_BASIC(elem);
> -	CHECK_ENUM(elem);
>  	return sm_selem_ops(elem)->is(elem, SM_PLAY, SM_OPS_IS_ENUMERATED, 1);
>  }
>
> @@ -901,7 +900,6 @@ int snd_mixer_selem_is_enum_playback(snd_mixer_elem_t
> *elem)
>  int snd_mixer_selem_is_enum_capture(snd_mixer_elem_t *elem)
>  {
>  	CHECK_BASIC(elem);
> -	CHECK_ENUM(elem);
>  	return sm_selem_ops(elem)->is(elem, SM_CAPT, SM_OPS_IS_ENUMERATED, 1);
>  }
>
> --
> 1.7.9.2
>

The patch changed some penum to enum

(e.g. "Independent HP"  or "Channel Mode" )


Simple mixer control 'Independent HP',0
  Capabilities: enum
  Items: 'OFF' 'ON'
  Item0: 'ON'
