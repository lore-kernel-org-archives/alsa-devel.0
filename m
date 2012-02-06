From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: HDA irq understanding
Date: Mon, 06 Feb 2012 09:15:11 +0100
Message-ID: <4F2F8C0F.5010901@canonical.com>
References: <CAFU7RzPKtt1-jJTgCWV1XgB+Fk-CA8FGeTCorW7cypBGFNoj7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 987EF1039DA
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 09:15:13 +0100 (CET)
In-Reply-To: <CAFU7RzPKtt1-jJTgCWV1XgB+Fk-CA8FGeTCorW7cypBGFNoj7w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raffaele Recalcati <lamiaposta71@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/06/2012 08:06 AM, Raffaele Recalcati wrote:
> Hi,
> I know my question is quite easy for this ml, but I hope to get a little help.
> I'm an embedded developer and I'm not so good with x86.
> I'm trying to load the system and hear mp3 decoding getting worst, but
> no way on my "Intel(R) Core(TM)2 Duo CPU P8400  @ 2.26GHz"
> very basic system.
> I'm trying to understand why I can't.
> Using trace (the complete one is here
> www.opensurf.it/trace12-02-04-19-14-48.txt_orig.lzma ) I get:
>
> grep HDA trace12-02-04-19-14-48.txt
> ..
>        cpu-100.sh-26486 [000]  9490.976257: irq_handler_entry: irq=21
> handler=HDA Intel
>        cpu-100.sh-26474 [000]  9490.984236: irq_handler_entry: irq=21
> handler=HDA Intel
>        cpu-100.sh-26467 [000]  9490.992220: irq_handler_entry: irq=21
> handler=HDA Intel
>        cpu-100.sh-26502 [000]  9491.088042: irq_handler_entry: irq=21
> handler=HDA Intel
> ..
> almost every 10msec
> pulseaudio reads from /dev/snd/pcmC0D0p,
> mplayer reads from pulseaudio.
>
> How can I create context switch problem in this situation and trace is well ?
> Thanks,
> Raffaele

Sorry, is your problem that you *do* get broken audio when you load the 
system, or that you *don't* get broken audio when you load the system?

Either way, PulseAudio uses RT prio to get higher priority than your 
load scripts, so this is used in PulseAudio <=> ALSA communication, but 
not in mplayer <=> PulseAudio communication.

For the 10 msec frequency, it looks like timer-based scheduling is 
turned off (or possibly mplayer is using very small buffer sizes?). You 
might get help with this in the pulseaudio-discuss mailinglist.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
