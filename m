From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Timer instability
Date: Wed, 25 Feb 2009 11:44:21 +0100
Message-ID: <20090225104420.GA19277@tango.0pointer.de>
References: <s5h1vtty3f8.wl%tiwai@suse.de>
	<20090220203417.GA19093@tango.0pointer.de>
	<s5hhc2nu4qy.wl%tiwai@suse.de>
	<20090222031453.GA24365@tango.0pointer.de>
	<s5h8wnvreab.wl%tiwai@suse.de>
	<20090224184604.GA2253@tango.0pointer.de>
	<s5hocwr64pz.wl%tiwai@suse.de>
	<20090224192611.GC2253@tango.0pointer.de>
	<s5hvdqz7erj.wl%tiwai@suse.de> <s5hiqmyq159.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id D0C1B24434
	for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2009 11:44:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hiqmyq159.wl%tiwai@suse.de>
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

On Wed, 25.02.09 11:08, Takashi Iwai (tiwai@suse.de) wrote:

> 
> At Tue, 24 Feb 2009 21:37:20 +0100,
> I wrote:
> > 
> > > stop_threshold is completely irrelevant to the problems discussed
> > > here.
> > 
> > OK, but let me continue that tomorrow or later.
> 
> Running it with five sound cards (two HD-audio, emu10k1, CMI8738, and
> envy24HT) overnight with tail -500, but nothing appears on my
> machines.
> 
> All outputs look OK: the first three columns are almost same values,
> avail is a few (< 10), delay is about the buffer size.
> 
> How can you trigger the problem so easily?

Hmm, that's a good question. It's not just me btw who can reproduce
this that easily. I have put up a page (see bottom of
http://pulseaudio.org/wiki/BrokenSoundDrivers) for this tool during
the WE and got about 20 reports back (some of this I actually
mentioned on the ML already), for different cards on different distros
(from all of Fedora, OpenSUSE, Mandriva, Ubuntu and Debian).

Most of this issues can be reproduced in 5 mins or so. For the
intel8x0 issues it was a little bit harder, took 30min to be triggered.

Most of my own tests was one SMP btw, not sure if that matters. The
excpetion is the intl8x0 stuff which I tested in a machine with a
single CPU.

Since a few PA versions back I write into syslog when snd_pcm_avail()
returns apparently overflown values. Our bugzilla is now full of
reports of messages like this. Here are a two of them as examples:

https://bugzilla.redhat.com/show_bug.cgi?id=485734
https://bugzilla.redhat.com/show_bug.cgi?id=483559

(Look for the snd_pcm_avail_update() log messages in those reports)

BTW, any update on the issue that calling poll() on an ALSA device
returns POLLOUT however a subsequent snd_pcm_avail() returns 0 or some
other value < min_avail? I reported that a while back on the ML. And a
*lot* of drivers are suffering by this. This causes the PA IO loop
to spin quite often for no reason.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
