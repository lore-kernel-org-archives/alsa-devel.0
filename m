From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Timer instability
Date: Tue, 24 Feb 2009 19:46:05 +0100
Message-ID: <20090224184604.GA2253@tango.0pointer.de>
References: <20090219024611.GA7930@tango.0pointer.de>
	<s5hy6w2hqap.wl%tiwai@suse.de>
	<20090220012220.GA11526@tango.0pointer.de>
	<s5h1vtty3f8.wl%tiwai@suse.de>
	<20090220203417.GA19093@tango.0pointer.de>
	<s5hhc2nu4qy.wl%tiwai@suse.de>
	<20090222031453.GA24365@tango.0pointer.de>
	<s5h8wnvreab.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 68F161037F6
	for <alsa-devel@alsa-project.org>; Tue, 24 Feb 2009 19:46:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h8wnvreab.wl%tiwai@suse.de>
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

On Tue, 24.02.09 17:27, Takashi Iwai (tiwai@suse.de) wrote:

> > > > Moreover I can now reproduce the same issue on snd-intel8x0, albeit it
> > > > takes more than a couple of minutes to make snd_pcm_avail() return
> > > > bogus data.
> > > > 
> > > > Somehow I get the feeling the problem is not so much the inaccuracy of
> > > > the pointer the kernel reports but in what alsa-libs does ith it.
> > > 
> > > Hrm... both cases the pointer calculation is relatively simple,
> > > and for "hw" PCM, the avail calculation is also very straightforward.
> > > So, my first suspect is about the pointer calculation.  But, of course
> > > we should check all possibilities.
> > > 
> > > Can you give a small testcase?
> > 
> > Ok, here's a little test case:
> > 
> > http://git.0pointer.de/?p=pulseaudio.git;a=blob_plain;f=src/tests/alsa-time-test.c
> 
> Finally have time to go back to this issue again now.
> 
> With your test case, indeed I get abort(), too.  However, checking
> through the code, you set stop_threshold to the boundary size like:
> 
>     r = snd_pcm_sw_params_get_boundary(swparams, &boundary);
>     r = snd_pcm_sw_params_set_stop_threshold(pcm, swparams, boundary);
> 
> This means essentially you are disabling the XRUN detection in the
> driver and keep it free-running.  So, no wonder avail gets over
> buffer_size.  It's actually an XRUN condition, but just ignored due to
> this setup.  (Usually, stop_threshould == buffer_size.)

Yes, threshold is set to boundary. But that's intended. Remember that
the original purpose of the tool is to graph _avail() and _delay()
against the time. For that I want to make sure the that timing stays
stable no matter what.

In reality this setting should not matter at all, because most machines
should be fast enough to keep the buffer filled even if we write one
sample at a time as it is done in the example.

The problems exposed in all the test data posted here for the various
sound cards are not normal normal buffer underruns.

In summary: just ignore the setting of the stop threshold. It is not
related to the problems exposed here.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
