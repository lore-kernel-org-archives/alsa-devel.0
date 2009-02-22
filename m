From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Timer instability
Date: Sun, 22 Feb 2009 04:14:53 +0100
Message-ID: <20090222031453.GA24365@tango.0pointer.de>
References: <20090219024611.GA7930@tango.0pointer.de>
	<s5hy6w2hqap.wl%tiwai@suse.de>
	<20090220012220.GA11526@tango.0pointer.de>
	<s5h1vtty3f8.wl%tiwai@suse.de>
	<20090220203417.GA19093@tango.0pointer.de>
	<s5hhc2nu4qy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id AAB5C1037EA
	for <alsa-devel@alsa-project.org>; Sun, 22 Feb 2009 04:14:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hhc2nu4qy.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, 21.02.09 17:36, Takashi Iwai (tiwai@suse.de) wrote:

> 
> At Fri, 20 Feb 2009 21:34:17 +0100,
> Lennart Poettering wrote:
> > 
> > On Fri, 20.02.09 08:26, Takashi Iwai (tiwai@suse.de) wrote:
> > 
> > > > Yes, I am. But ignore that part for now. I have now commented the use
> > > > of that call. Now I certainly get more POLLOUTs as expected, but the
> > > > real problem stays: after a few minutes _avail() will suddenly jump
> > > > from next to zero to more then the hwbuf size in less than 1ms without
> > > > any further inteference and with a buffer size of 350ms! There is
> > > > something really wrong with the behaviour of _avail().
> > > > 
> > > > I can reproduce this only on ens1371 for now.
> > > 
> > > The ens1371 driver itself is damn simple.  The pointer callback just
> > > returns the read value.  So, it implies that it's basically a hardware
> > > issue.
> > > 
> > > Does the patch below have any influence?
> > 
> > No. It doesn't appear to have any effect whatsoever. Still, from time
> > to time the value returned by _avail() is off by once the buffer size,
> > sometimes upwards, sometimes downwards.
> > 
> > Moreover I can now reproduce the same issue on snd-intel8x0, albeit it
> > takes more than a couple of minutes to make snd_pcm_avail() return
> > bogus data.
> > 
> > Somehow I get the feeling the problem is not so much the inaccuracy of
> > the pointer the kernel reports but in what alsa-libs does ith it.
> 
> Hrm... both cases the pointer calculation is relatively simple,
> and for "hw" PCM, the avail calculation is also very straightforward.
> So, my first suspect is about the pointer calculation.  But, of course
> we should check all possibilities.
> 
> Can you give a small testcase?

Ok, here's a little test case:

http://git.0pointer.de/?p=pulseaudio.git;a=blob_plain;f=src/tests/alsa-time-test.c

I wrote this little test to track down all kinds of timer issues: it
opens and sets up a sound device. Then it will constantly query
_avail(), _delay() and _htstamp() in a busy loop writing a single
sample at a time. The three values are then printed along with a
system timestamp. The data generated like this can be opened in
gnumeric and a nice graph be drawn.

So much about the original purpose of this tool.

The issue in question can be triggered by simply running this tool and
passing the device name as argv[0]. i.e. "alsa-time-test hw:AudioPCI".

The assert at the end of the file (line 189) is triggered when
_avail() starts to become unreliable and jumps around. 

For me to reproduce this issue all I have to do is run:

  $ alsa-time-test hw:AudioPCI > log

and then wait for a minute or two. The assert is hit the tool aborted.

When that happens one can check the end of 'log' and will see something like this:

<snip>
...
45974071        45974067        45937596        3882    528     4       1       3
45974088        45974084        45937596        3881    529     4       1       3
45974106        45974101        45937596        3880    530     4       1       3
45974122        45974118        45937596        3879    531     4       1       3
45974140        45974136        45937777        3886    524     4       1       3
46025249        45974154        45937777        3885    525     4       1       3
46025279        46025274        45988752        6132    -1722   4       1       3
</snip>

The first column is clock_gettime(CLOCK_MONOTONIC) in us. Second
column in the timestamp stored in the snd_pcm_state_t. The third is
the calculated playback time (i.e. write count - delay).  The fourth
column is avail, the fifth is delay.

In the last two lines (i.e. right when the assert aborted us) it
becomes interesting. Suddenly in 30 us, the buffer jumped from an
avail of 3885 to 6132 (buffer size is 4410). 

I debugged a little bit through alsa-lib. Apparently in contrast to
what I guessed before this issue seems indeed to be caused by a kernel
bug: the hw_ptr right after the SNDRV_PCM_IOCTL_HWSYNC is already
bogus.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
