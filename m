From: "Giovanni Maruzzelli" <gmaruzz.lists@gmail.com>
Subject: Re: No sound from usb on Motorola C350 cellphone
Date: Mon, 12 Nov 2007 19:49:20 +0100
Message-ID: <7c5010d60711121049q3ed60354me3c7dd492163043a@mail.gmail.com>
References: <7c5010d60711120528u16bef715ua48f440c49d962d1@mail.gmail.com>
	<7c5010d60711120534l13376fc9gc71228ca84322ddc@mail.gmail.com>
	<47385A14.4000301@gmail.com>
	<7c5010d60711120555r28363e3ax8bb1efa33209cc8c@mail.gmail.com>
	<7c5010d60711120557yed3e6cdn357553022d11788c@mail.gmail.com>
	<47385FAE.9070408@gmail.com> <20071112103947.0e3afc4b@jutz-gnto64>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.227])
	by alsa0.perex.cz (Postfix) with ESMTP id 59FF7243F5
	for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2007 19:56:40 +0100 (CET)
Received: by wr-out-0506.google.com with SMTP id 58so940295wri
	for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2007 10:56:38 -0800 (PST)
In-Reply-To: <20071112103947.0e3afc4b@jutz-gnto64>
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
To: John Utz <john.utz@dmx.com>
Cc: alsa-devel@alsa-project.org, "Alexander E. Patrakov" <patrakov@gmail.com>
List-Id: alsa-devel@alsa-project.org

Johnu,

device string, and all the "usual" kind of detailed informations are
in the files contained by the compressed archive you can download at:
http://www.celliax.org/c350_usb_sound.tgz (lsusb -vv before and after,
stream0, etc etc).

maybe there is need for a quirk in snd_usb_audio ?

the problem is that the device appear to works, but do not captures or
plays samples.

On Nov 12, 2007 7:39 PM, John Utz <john.utz@dmx.com> wrote:
> Hi All;
>
> I think this is a totally fascinating thing and i hope it will be
> possible to make it work.....
>
> onto the specifics
>
> On Mon, 12 Nov 2007 19:14:06 +0500
> "Alexander E. Patrakov" <patrakov@gmail.com> wrote:
>
>
> > Giovanni Maruzzelli wrote:
> > > Needs more info, tests?
> >
> > If you can make the audio functionality work under Windows 2000 or XP
> > with the new (non-standard) driver, snoopy logs will be interesting.
> > Snoopy is available from http://www.wingmanteam.com/usbsnoopy/ or
> > (different version) http://sourceforge.net/projects/usbsnoop/
> >
>
> i am not staring at the USB code right now (it's on a different box),
> but i would think that one of the first things that you might need to
> uncover is the USB device string. It may be offered up as part of the
> device probe when it's attached (check in dmesg) or you may find it in
> a registry or .inf file on the windows file system after you install
> the drivers.
>
> if it's a class compliant device, then it may just work once alsa get's
> taught about it (dont hold me to that, i am not looking at code)
>
> however, as one of you alluded to, there may be an AT command that
> needs to get tickled to turn it on.
>
> the other annoying thing to consider is that it may actually be probe
> and connected, but you havent yet figured out how to turn up the
> volume :-( (yes, that happens)
>
> i'll be really curious about this, so please continue to share with
> the list....
>
> tnx!
>
> johnu
>
>
