From: "Sebastian H." <vand2@gmx.de>
Subject: Re: alsa-lib: snd_mixer_selem_is_active changes
 -	which event?
Date: Sun, 17 Apr 2011 14:06:17 +0200
Message-ID: <4DAAD7B9.1010205@gmx.de>
References: <4D5ACED8.5030707@gmx.de>
	<BANLkTimkDFUybYQK+AzDpq_n0LDH86oYGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by alsa0.perex.cz (Postfix) with SMTP id 250831037F9
	for <alsa-devel@alsa-project.org>;
	Sun, 17 Apr 2011 14:06:26 +0200 (CEST)
In-Reply-To: <BANLkTimkDFUybYQK+AzDpq_n0LDH86oYGQ@mail.gmail.com>
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

>> I wonder which event mask notifies an application that
>> snd_mixer_selem_is_active() may have changed.
>>
>> SND_CTL_EVENT_MASK_VALUE
>> or
>> SND_CTL_EVENT_MASK_INFO
>>
>> or something else?
>>
>> I'd be glad for any insights?
>>
>>
> qasmixer display the following message when play audio through front device
> of emu10k1
> 
> alsa_callback_hctl_elem: Unknown mask ( 3 )
> [EE] snd_hctl_handle_events : Operation not permitted

This is actually a bug in qasmixer.
Up to now it could not handle multi event masks.

Mask 3 seems to be
SND_CTL_EVENT_MASK_VALUE & SND_CTL_EVENT_MASK_INFO ( 1 & 2 )
but qasmixer checks for
( mask == SND_CTL_EVENT_MASK_VALUE ) ||
( mask == SND_CTL_EVENT_MASK_INFO )
which fails as ( 3 == 1 ) || ( 3 == 2 ) == false;

That should be fixed now.
A new version should be around next week.
You could also try the development version in the sourceforge mercurial
repo.

> which event mask "SND_CTL_EVENT_MASK_VALUE" or "SND_CTL_EVENT_MASK_VALUE "
> should the mixer application handle first ?

IMO the order doesn't matter as long as both events are handled properly
and the displayed mixer state equals the system mixer state
afterwards.

> e.g. it is possible that the driver may change access of  the control
> 
>  & ~SNDRV_CTL_ELEM_ACCESS_READ

If that triggers a SND_CTL_EVENT_MASK_INFO event it shouldn't be a
problem in the coming version 0.11.0.

Sebastian H.
