From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: SALSA-library version 0.1.0 released
Date: Fri, 29 Apr 2011 13:28:32 -0500
Message-ID: <BANLkTi=Ny56sxczPwme4bVEaxQLrCW8SFw@mail.gmail.com>
References: <s5hzkn9efi4.wl%tiwai@suse.de>
	<BANLkTi=BV80T3K9bHoNciXt8DjhEnmnNpA@mail.gmail.com>
	<s5hoc3pukpu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 910FB24400
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 20:28:33 +0200 (CEST)
Received: by eyg5 with SMTP id 5so1338058eyg.38
	for <alsa-devel@alsa-project.org>; Fri, 29 Apr 2011 11:28:32 -0700 (PDT)
In-Reply-To: <s5hoc3pukpu.wl%tiwai@suse.de>
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

>> Aren't you missing snd_pcm_hw_params_set_period_wakeup() ?
>> This is required by PulseAudio now.
>
> Right, I fixed and released as v0.1.1 now.

ok, pulled.

>> Also if you had a description of what is supported it'd be great.
>
> =A0From ChangeLog:
> =A0Version 0.1.1:
> =A0 =A0 =A0 =A0* Add missing snd_pcm_hw_params_{get|set}_period_wakeup()

I meant something like the README... I should have looked before asking...
-Pierre
