From: "Giovanni Maruzzelli" <gmaruzz.lists@gmail.com>
Subject: Re: No sound from usb on Motorola C350 cellphone
Date: Mon, 12 Nov 2007 14:57:34 +0100
Message-ID: <7c5010d60711120557yed3e6cdn357553022d11788c@mail.gmail.com>
References: <7c5010d60711120528u16bef715ua48f440c49d962d1@mail.gmail.com>
	<7c5010d60711120534l13376fc9gc71228ca84322ddc@mail.gmail.com>
	<47385A14.4000301@gmail.com>
	<7c5010d60711120555r28363e3ax8bb1efa33209cc8c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.224])
	by alsa0.perex.cz (Postfix) with ESMTP id 53E1024451
	for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2007 14:57:36 +0100 (CET)
Received: by wr-out-0506.google.com with SMTP id 58so861417wri
	for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2007 05:57:34 -0800 (PST)
In-Reply-To: <7c5010d60711120555r28363e3ax8bb1efa33209cc8c@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

With an old copy of motorola driver, the usb sound device was
recognized by windows XP, with mixer elements only for the playback. I
was  not able to record from it, playing give no errors, but no sound
either

With the last copy of driver from motorola developer devsite, on XP a
whole new "Motorola Device" is created, with the audio interface
listed on it in the usb control panel, but no audio device is
available for normal usage.

Needs more info, tests?



On Nov 12, 2007 2:50 PM, Alexander E. Patrakov <patrakov@gmail.com> wrote:
> Giovanni Maruzzelli wrote:
> > Maybe there is a way to not using soundcards, that would be *so* much
> > better: I found that Motorola c350 phones after receiving an AT+MODE=8
> > command via USB, make available an usb sound device.
>
> Confirmed with my Motorola C350 cellphone. It appears to accept S16_LE, MU_LAW
> and A_LAW formats, 8 kHz sample rate, but actually records no data and plays no
> sounds (even if a cal is in progress).
>
> One question: what playback and recording functionality is available on this
> cellphone under Windows?
>
> --
> Alexander E. Patrakov
>
