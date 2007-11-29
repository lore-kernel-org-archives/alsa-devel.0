From: "David Hubbard" <david.c.hubbard@gmail.com>
Subject: Re: Edirol UA-4FX
Date: Wed, 28 Nov 2007 23:20:45 -0700
Message-ID: <4dfa50520711282220t1443214fg6a84dd0619dfbfba@mail.gmail.com>
References: <4dfa50520711281050v4a710af5q11644b0cf7dd10c1@mail.gmail.com>
	<4dfa50520711281123o4ea74babra50f0a09330bb359@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.231])
	by alsa0.perex.cz (Postfix) with ESMTP id A29342417E
	for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2007 07:20:47 +0100 (CET)
Received: by nz-out-0506.google.com with SMTP id m22so1240027nzf
	for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2007 22:20:46 -0800 (PST)
In-Reply-To: <4dfa50520711281123o4ea74babra50f0a09330bb359@mail.gmail.com>
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
To: Takashi Iwai <tiwai@suse.de>, Alsa Devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi and everyone,

Luis just got back to me, and he's not the right person to talk to
about the snd_usb_audio.
http://alsa.opensrc.org/index.php/Usb-audio#Notes suggests I contact
Takashi Iwai. Quoted below is the message now available at
http://mailman.alsa-project.org/pipermail/alsa-devel/2007-November/004552.html
(you can get the patch there, or on the wiki).

I'm just new to alsa-devel, so I'm trying to connect with the right maintainer.

Cheers,
David

On Nov 28, 2007 12:23 PM, David Hubbard <david.c.hubbard@gmail.com> wrote:
> Hello Luis, and Alsa list,
>
>
> I recently got an Edirol UA-4FX. It works just fine as a generic USB
> Audio device. I've written up all the details at
> http://alsa.opensrc.org/index.php/Edirol_UA-4FX (shamelessly stolen
> from the Edirol_UA-25 page).
>
> The the UA-4FX needs a patch to usbaudio.c create_ua700_ua25_quirk()
> and usbquirks.h, and then it has full support. (MIDI I/O, sample rates
> up to 96 kHz) I've made an attempt, mostly to get it working on my
> machine. Can you review it?
>
> Thanks,
> David
>
