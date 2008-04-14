From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Tue, 15 Apr 2008 01:43:58 +0200
Message-ID: <20080414234358.GA19108@tango.0pointer.de>
References: <20080411204610.GA32413@tango.0pointer.de>
	<480099C6.3040708@superbug.co.uk>
	<20080412133536.GC32491@tango.0pointer.de>
	<48010E62.2020404@keyaccess.nl>
	<20080414170022.GH22115@tango.0pointer.de>
	<480392F3.9030701@keyaccess.nl>
	<20080414172839.GA26513@tango.0pointer.de>
	<4803C78A.3020109@superbug.co.uk>
	<17eedd8a0804141508s67c815bfw969e0c21b2b1298c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 7ABCB2462B
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Apr 2008 01:43:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <17eedd8a0804141508s67c815bfw969e0c21b2b1298c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Aldrin Martoq <amartoq@dcc.uchile.cl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 14.04.08 18:08, Aldrin Martoq (amartoq@dcc.uchile.cl) wrote:

> >  > Yes, but what I am asking for is to define the dB values of the master
> >  > control relative to the some ref level on this line-out. What happens
> >  > after the line-out doesn't matter at all.
> 
> Lennart: while I definitely agree on what you try to achieve, I
> strongly disagree the way it's being solved.

Uh? Nothing is solved. We have this discussion on this ML because it
needs to be solved.

> Initial volume setup is an *installation* issue, not a *boot or daemon
> startup* issue. When you buy a notebook with linux pre-installed, it's
> the manufacturer who must make sure the notebook has the appropiate
> volume levels, factory default. When you install Fedora, it's the
> fedora install program who must make sure the appropiate volume
> levels. Both ways, when the user starts its new shiny linux, it just
> works.

It's not installation issue. It's a "seeing for the first time"
issue. For hotplug devices this might be much later than on installation.

In one of the first emails of this thread I already explained that I'd
like to see a new command for alsactl called "reset" or suchlike which
implements the logic to initialize the dB scales properly. We'd then
call this program from the udev rules if "alsactl restore" fails
because the device was unknown before and has no configuration file
yet.

Right now we have this really awful program in Fedora called "salsa"
and "alsaunmute" which implements this logic, but is really really bad
in doing so, because it just initializes everything to 70% for unknown
devices. Also, while it is able to restore the volume settings, it is
not capable to save them on hot-unplug. Which makes the whole thing
pretty pointless.

But anyway, isn't this exactly what you are looking for? I am not sure
what you are asking for more than this?

However, having "alsctl reset" is nice. But it is still not sufficient
for the actual problems I need to solve in PA. See below.

> That's all, end of story! If you put code that tries to guess what the
> appropiate volume should be for any case, it will become an infinite
> problem of what is right and what is wrong, not counting the annoying
> user experience this will bring. You can't guess what is right for
> every people, so a sane mute (in case of no other source of
> information) is clearly the only good choice.

The problem is a bit more complex. Think of multiple sessions and
stuff. If ConsoleKit informs PA about a session switch we need to be
able to provide every user hs own set of mixer settings.

Dude, it's pretty easy to define a common refernce of the dB
values. In fact, James (who afaik did the dB scale work initially)
already agreed to this and even suggested measuring the voltage on the
output jack.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
