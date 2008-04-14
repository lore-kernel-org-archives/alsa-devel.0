From: "Aldrin Martoq" <amartoq@dcc.uchile.cl>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Mon, 14 Apr 2008 18:08:37 -0400
Message-ID: <17eedd8a0804141508s67c815bfw969e0c21b2b1298c@mail.gmail.com>
References: <20080411204610.GA32413@tango.0pointer.de>
	<480099C6.3040708@superbug.co.uk>
	<20080412133536.GC32491@tango.0pointer.de>
	<48010E62.2020404@keyaccess.nl>
	<20080414170022.GH22115@tango.0pointer.de>
	<480392F3.9030701@keyaccess.nl>
	<20080414172839.GA26513@tango.0pointer.de>
	<4803C78A.3020109@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E3B4245F7
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Apr 2008 00:08:40 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 25so2414025wfa.23
	for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2008 15:08:37 -0700 (PDT)
In-Reply-To: <4803C78A.3020109@superbug.co.uk>
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
To: Lennart Poettering <mznyfn@0pointer.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 14, 2008 at 5:07 PM, James Courtier-Dutton
<James@superbug.co.uk> wrote:
> Lennart Poettering wrote:
>  > Yes, but what I am asking for is to define the dB values of the master
>  > control relative to the some ref level on this line-out. What happens
>  > after the line-out doesn't matter at all.

Lennart: while I definitely agree on what you try to achieve, I
strongly disagree the way it's being solved.

Initial volume setup is an *installation* issue, not a *boot or daemon
startup* issue. When you buy a notebook with linux pre-installed, it's
the manufacturer who must make sure the notebook has the appropiate
volume levels, factory default. When you install Fedora, it's the
fedora install program who must make sure the appropiate volume
levels. Both ways, when the user starts its new shiny linux, it just
works.

Once the system is installed it has to remember its previous settings,
which I think has been done on most distros (mine in
/etc/init.d/alsa-utils).

That's all, end of story! If you put code that tries to guess what the
appropiate volume should be for any case, it will become an infinite
problem of what is right and what is wrong, not counting the annoying
user experience this will bring. You can't guess what is right for
every people, so a sane mute (in case of no other source of
information) is clearly the only good choice.

So please, please: don't try to guess this in your daemon, it will
make more harm than actually helping users. The manufacturer or
installer *are the right places* to solve the issue. They both know
the hardware or can ask the user to check if it's right for them.

>  Now, we have tried to get this right by looking at datasheets of sound
>  cards, but it might not be right for all sound cards yet. It is at least
>  a task we may be able to actually achieve.
>  When the datasheets are wrong, the only available method to get it right
>  is actually to measure the analog signals. Can anyone provide a simple
>  reliable test for this? E.g. Using this sample .wav file and a cheapo
>  digital volt meter, this is the output you should get. I am not even
>  sure that a simple digital volt meter can do the task as a volt meter is
>  only expecting 50-60Hz, and not all sound cards work at all well at that
>  frequency.

Well, this kind of problem must be solved too. I think contacting the
hardware manufacturers or asking users. But NOT guessing...

-- 
Aldrin Martoq
Episodio 002 (Lunes 24 Marzo)!
http://aldrinvideopodcast.podshow.com/
