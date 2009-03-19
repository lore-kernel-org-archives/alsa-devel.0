From: Joonyoung Shim <dofmind@gmail.com>
Subject: Re: [PATCH] ASoC: twl4030 - Add VDL path support
Date: Thu, 19 Mar 2009 14:44:23 +0900
Message-ID: <4e1455be0903182244i26ce5e4dt6b3bdab3bedfded1@mail.gmail.com>
References: <49BF5F40.3020000@samsung.com>
	<200903171122.22136.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.168])
	by alsa0.perex.cz (Postfix) with ESMTP id 356551037FD
	for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2009 06:44:25 +0100 (CET)
Received: by wf-out-1314.google.com with SMTP id 24so453705wfg.23
	for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2009 22:44:24 -0700 (PDT)
In-Reply-To: <200903171122.22136.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>, =?EUC-KR?B?udqw5rnO?= <kyungmin.park@samsung.com>, =?EUC-KR?B?uc66tMij?= <bhmin@samsung.com>, ext Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: alsa-devel@alsa-project.org

Hi, my thunderbird progrem breaked down, so i send from gmail

>
> The reason to have the VALUE_ENUM for the audio path selection is that
> according to the TRM only one of the paths can be enabled at the time.

It's not true. I tested playback about Predrive Right audio path(My target
is not connected with Predriver Left)
The AudioL2 and AudioR2 was enabled and i played audio wav file of three
type following;
    1. wav file recorded only left channel
    2. wav file recorded only right channel
    3. wav file recorded left and right channel
The result is that all was sounded. If the controller is mux, the case of 1
or 2 haven't to sound.

> While the voice path can be mixed with one of the audio paths (at least that
> is my understanding).
> So:
> AudioL*/AudioR* (DACL*/DACR*) = Mux
> Voice, AudioL/R* (DACL/R*) = Mix
>
> I think it would be better to leave the current VALUE_ENUMS for the audio path
> and add a switch for the Voice enable/disable for the outputs and route them
> through a mixer to the output.

The mixer DAPM is suitable the structure of control registers(0x21, 0x22,
0x25, 0x26, 0x27, 0x28) of path except Handsfree path because each bit for
path is switchable.
If we use the mixer DAPM, the switch DAPM for voice path doesn't need.

> Probably than it makes sense to rename the "Earpice Mux" and friends to
> something like "Earpiece aduio Mux"...
> So we would have two controls per outputs:
> "Earpiece aduio Mux" (Off, DACL1, DACL2, DACR1)
> "Earpiece voice Switch" (on, off)
> and internally we can have "Earpiece output mixer", which mixes them together.
>


-- 
- Joonyoung Shim
