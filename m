From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: alsa-lib: snd_mixer_selem_is_active changes -
	which event?
Date: Sat, 16 Apr 2011 10:02:10 +0800
Message-ID: <BANLkTimkDFUybYQK+AzDpq_n0LDH86oYGQ@mail.gmail.com>
References: <4D5ACED8.5030707@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 361161037F3
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Apr 2011 04:02:13 +0200 (CEST)
Received: by fxm5 with SMTP id 5so2593199fxm.38
	for <alsa-devel@alsa-project.org>; Fri, 15 Apr 2011 19:02:10 -0700 (PDT)
In-Reply-To: <4D5ACED8.5030707@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Sebastian H." <vand2@gmx.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/2/16 Sebastian H. <vand2@gmx.de>

> Hello
>
> I wonder which event mask notifies an application that
> snd_mixer_selem_is_active() may have changed.
>
> SND_CTL_EVENT_MASK_VALUE
> or
> SND_CTL_EVENT_MASK_INFO
>
> or something else?
>
> I'd be glad for any insights?
>
>
qasmixer display the following message when play audio through front device
of emu10k1

alsa_callback_hctl_elem: Unknown mask ( 3 )
[EE] snd_hctl_handle_events : Operation not permitted


which event mask "SND_CTL_EVENT_MASK_VALUE" or "SND_CTL_EVENT_MASK_VALUE "
should the mixer application handle first ?

e.g. it is possible that the driver may change access of  the control

 & ~SNDRV_CTL_ELEM_ACCESS_READ
