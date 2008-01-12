From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Disabling buffer fill level preprocessing by ALSA
Date: Sat, 12 Jan 2008 19:06:31 +0100
Message-ID: <20080112180631.GA5994@tango.0pointer.de>
References: <20071231171226.GA17953@tango.0pointer.de>
	<s5hfxx9ao8b.wl%tiwai@suse.de>
	<20080107160706.GE14386@tango.0pointer.de>
	<Pine.LNX.4.61.0801071916450.22730@tm8103.perex-int.cz>
	<20080107223850.GA12262@tango.0pointer.de>
	<Pine.LNX.4.61.0801080833090.22730@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 4384B247DA
	for <alsa-devel@alsa-project.org>; Sat, 12 Jan 2008 19:06:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0801080833090.22730@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 08.01.08 09:00, Jaroslav Kysela (perex@perex.cz) wrote:

> > So, depending on what clients are connected, we dynamically change the
> > wakeups. Now, on ALSA (and with a lot of sound hw, as I understood
> > Takashi) you cannot reconfigure the period sizes dynamically without
> > interruptions of audio output. That's why I want to disable the whole
> > period/buffer fill level management of ALSA, and do all myself with
> > system timers, which I thankfully now can due to the advent of
> > hrtimers (at least on Linux/x86). System timers nowadays are a lot
> > more flexibe than the PCM timer, because they can be reconfigured all
> > the time without any drawbacks. They are not dependant on period sizes
> > or other stuff which may only be reconfigured by resetting the audio
> > devices. The only drawback is that we need to determinine how the
> > sound card clock and the system clock deviate.
> > 
> > Does that make sense to you?
> 
> Yes, but I don't see any problem to change avail_min dynamically 
> (sw_params can be changed at any time), so each interrupt can be catched 
> via poll(). But I really think that one timing source (system timers) is 
> enough.

OK. I wasn't really aware that you could change sw params
dynamically. I will do this now. This should be sufficient for my needs.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
