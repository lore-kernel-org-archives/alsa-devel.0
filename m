From: "Aldrin Martoq" <amartoq@dcc.uchile.cl>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Mon, 14 Apr 2008 22:18:45 -0400
Message-ID: <17eedd8a0804141918s72637cdfh37d2eae679bad692@mail.gmail.com>
References: <20080411204610.GA32413@tango.0pointer.de>
	<480099C6.3040708@superbug.co.uk>
	<20080412133536.GC32491@tango.0pointer.de>
	<48010E62.2020404@keyaccess.nl>
	<20080414170022.GH22115@tango.0pointer.de>
	<480392F3.9030701@keyaccess.nl>
	<20080414172839.GA26513@tango.0pointer.de>
	<4803C78A.3020109@superbug.co.uk>
	<17eedd8a0804141508s67c815bfw969e0c21b2b1298c@mail.gmail.com>
	<20080414234358.GA19108@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.237])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A6412466E
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Apr 2008 04:18:48 +0200 (CEST)
Received: by wx-out-0506.google.com with SMTP id t11so1961812wxc.23
	for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2008 19:18:46 -0700 (PDT)
In-Reply-To: <20080414234358.GA19108@tango.0pointer.de>
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
To: Lennart Poettering <mznyfn@0pointer.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 14, 2008 at 7:43 PM, Lennart Poettering <mznyfn@0pointer.de> wrote:
> On Mon, 14.04.08 18:08, Aldrin Martoq (amartoq@dcc.uchile.cl) wrote:
>  > Lennart: while I definitely agree on what you try to achieve, I
>  > strongly disagree the way it's being solved.
>  Uh? Nothing is solved. We have this discussion on this ML because it
>  needs to be solved.

Yup, I know it's *being* solved.

>  > Initial volume setup is an *installation* issue, not a *boot or daemon
>  > startup* issue. When you buy a notebook with linux pre-installed, it's
>  > the manufacturer who must make sure the notebook has the appropiate
>  > volume levels, factory default. When you install Fedora, it's the
>  > fedora install program who must make sure the appropiate volume
>  > levels. Both ways, when the user starts its new shiny linux, it just
>  > works.
>  It's not installation issue. It's a "seeing for the first time"
>  issue. For hotplug devices this might be much later than on installation.

Hotplug devices should start muted (read below).

>  In one of the first emails of this thread I already explained that I'd
>  like to see a new command for alsactl called "reset" or suchlike which
>  implements the logic to initialize the dB scales properly. We'd then
>  call this program from the udev rules if "alsactl restore" fails
>  because the device was unknown before and has no configuration file
>  yet.
>  Right now we have this really awful program in Fedora called "salsa"
>  and "alsaunmute" which implements this logic, but is really really bad
>  in doing so, because it just initializes everything to 70% for unknown
>  devices. Also, while it is able to restore the volume settings, it is
>  not capable to save them on hot-unplug. Which makes the whole thing
>  pretty pointless.
>  But anyway, isn't this exactly what you are looking for? I am not sure
>  what you are asking for more than this?

No, I am not asking for a solution. Mi distro (ubuntu 7.10) remembers
the state of my (hotplug pc-card) soundblaster audigy2 notebook, so
actually this is not a problem for me.You may check how the
"alsa-utils" package handles hotplug through udev.


What I am suggesting is that the way to handle initial volume is
wrong, it must not be done in PA or other daemon:
1. Initial volume must be configured at install time. Maybe the
manufacturer or the install procedure of your distro.
2. After that, the computer must remember the last change.
3. If I plug a new card, it must start muted unless i want to change that.
4. If I plug the card again, it should remember my last settings.

This is (mostly) how it works here, and it works fine.



>From your first email, you state that
"I started to hack something similar to this as part of PulseAudio: if
PA finds that the PCM slider is not really useful for volume control
(no attenuation to at least -60dB, too few steps, no seperate controls
for all channels, ...) it falls back to software volume control,
however tries to initialize the the slider to 0dB first."

So, I think this is plainly wrong. You could improve this by other
means (maybe the user interface could be clever), but setting an
unwanted level out of the blue it's going to be a serious problem to
many many users. Please don't touch the levels if I don't want that.


>  However, having "alsctl reset" is nice. But it is still not sufficient
>  for the actual problems I need to solve in PA. See below.

>  > That's all, end of story! If you put code that tries to guess what the
>  > appropiate volume should be for any case, it will become an infinite
>  > problem of what is right and what is wrong, not counting the annoying
>  > user experience this will bring. You can't guess what is right for
>  > every people, so a sane mute (in case of no other source of
>  > information) is clearly the only good choice.
>
>  The problem is a bit more complex. Think of multiple sessions and
>  stuff. If ConsoleKit informs PA about a session switch we need to be
>  able to provide every user hs own set of mixer settings.
>  Dude, it's pretty easy to define a common refernce of the dB
>  values. In fact, James (who afaik did the dB scale work initially)
>  already agreed to this and even suggested measuring the voltage on the
>  output jack.

And it's pretty easy to screw it up. -40db (even in the same scale)
WILL be different for every people: I usually plug my soundblaster to
a power amp of 300W. So, if I swith to another user, you are going to
change the volume up to -40db because YOU think that's what I want????


It's OK to calibrate all cards to behave the same, I agree with that.
It's NOT OK that your software treats you as a dumb and do things you
didn't ask....

-- 
Aldrin Martoq
Episodio 002 (Lunes 24 Marzo)!
http://aldrinvideopodcast.podshow.com/
