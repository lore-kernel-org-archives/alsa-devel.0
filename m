From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 2/5] ALSA: snd-usb: implement new endpoint
	streaming model
Date: Thu, 22 Dec 2011 20:04:36 +0100
Message-ID: <4EF37F44.5070107@gmail.com>
References: <1324424088-5705-1-git-send-email-zonque@gmail.com>
	<1324424088-5705-3-git-send-email-zonque@gmail.com>
	<CAE-xCyM-RZxQHbXUH4aswQS_xraEM-vMVynfDiSsj5ZUyq5Gkw@mail.gmail.com>
	<4EF20A81.9070307@gmail.com>
	<CAE-xCyNV0u1PBiHt_tXQT5dqgGE=LhLYyTEfuoAKxO1TvqOXyQ@mail.gmail.com>
	<4EF214E6.8050405@gmail.com>
	<CAE-xCyOsFj_uXhAbQr_j8e0gW6UyefQZnzkY7UTXdnEMvCshEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D25152439E
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 20:04:40 +0100 (CET)
Received: by eekb57 with SMTP id b57so8268327eek.38
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 11:04:40 -0800 (PST)
In-Reply-To: <CAE-xCyOsFj_uXhAbQr_j8e0gW6UyefQZnzkY7UTXdnEMvCshEw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, gdiffey@gmail.com, linuxaudio@showlabor.de
List-Id: alsa-devel@alsa-project.org

On 12/22/2011 06:55 PM, Aur=E9lien Leblond wrote:
>> Which hardware is connected? Did you try that with both? Did you try
>> with anything else than jack? I'd need more information about your setup
>> to get an idea.
> =

> Ok, here is a bit more info: I'm running a 64bit Ubuntu Oneiric.
> Kernel is the 3.2 rc6.
> =

> With the M-Audio Fast Track Ultra:
> - Alsa is working ok. That is, I can read a mp3 with mplayer without
> any problem for example.
> - As soon as I start Jackd2, my whole system freezes.
> - 3.2 rc4 and the previous version of your patch, all was working ok
> with the FTU.
> =

> With the Edirol UA25-Ex:
> - It was working with 3.2 rc and the previous version of your patch.
> - With the current version, the soundcard doesn't work at all. The
> following trace appears in dmesg:
> =

> [   33.724071] BUG: unable to handle kernel NULL pointer dereference

Ok, thanks. I'll breed on this a little and let you know when I have
s.th. to share.

Thanks for the feedback!

Daniel
