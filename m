From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Timer instability
Date: Tue, 24 Feb 2009 20:26:11 +0100
Message-ID: <20090224192611.GC2253@tango.0pointer.de>
References: <20090219024611.GA7930@tango.0pointer.de>
	<s5hy6w2hqap.wl%tiwai@suse.de>
	<20090220012220.GA11526@tango.0pointer.de>
	<s5h1vtty3f8.wl%tiwai@suse.de>
	<20090220203417.GA19093@tango.0pointer.de>
	<s5hhc2nu4qy.wl%tiwai@suse.de>
	<20090222031453.GA24365@tango.0pointer.de>
	<s5h8wnvreab.wl%tiwai@suse.de>
	<20090224184604.GA2253@tango.0pointer.de>
	<s5hocwr64pz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id E3FB71037F6
	for <alsa-devel@alsa-project.org>; Tue, 24 Feb 2009 20:26:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hocwr64pz.wl%tiwai@suse.de>
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

On Tue, 24.02.09 19:59, Takashi Iwai (tiwai@suse.de) wrote:

> > Yes, threshold is set to boundary. But that's intended. Remember that
> > the original purpose of the tool is to graph _avail() and _delay()
> > against the time. For that I want to make sure the that timing stays
> > stable no matter what.
> > 
> > In reality this setting should not matter at all, because most machines
> > should be fast enough to keep the buffer filled even if we write one
> > sample at a time as it is done in the example.
> 
> Not really.  If you feed the output to a terminal, it's damn slow.
> That's why I got XRUN.

Oh, of course, I should have mentioned that.

The tool generates a *lot* of data, given that it queries _avail() and
_delay() in a busy loop.

To run it either redirect the output to disk (which of course might
create gaps in the output if we write faster than the disk can take it
but this is easily detected by looking on the first column). Or
pipe it directly to something like "tail -n 50".

> > In summary: just ignore the setting of the stop threshold. It is not
> > related to the problems exposed here.
> 
> FWIW, when I run the program and feed the output to /dev/null, I don't
> get abort() after minutes.  It happened soon only when it runs on a
> terminal.  So, the condition appears very likely as an XRUN.

The outputs I posted earlier are *not* due to normal underruns. Please
have a look at the actual data!

> So, try to set stop_threshold to buffer_size once, and check whether
> you get any different result.  Let's check another possibility if it
> really isn't the case.

In those test cases no normal XRUN ever happens unless you pipe the
output to a terminal: please, just actaully look at the data
generated!

The effective difference for this tool that it makes to set
stop_threshold to boundary or not is simply this:

    if stop_threshold is set to boundary underruns will be caught by the
    mentioned assert.

    if stop_threshold is not set to boundary underruns result in an EPIPE
    which is then caught by a different assert in the code.

So again: how stop_threshold is set is *irrelevant* for the test case!
It simply would cause a different assert() to be triggered! That is
all. And again, unless you machine is very slow or otherwise busy
_avail() should never come near the buffer size except very early
afetr startup.

stop_threshold is completely irrelevant to the problems discussed
here.

Oh, and one thing I didn't actually notice earlier: Most drivers return
a negative snd_pcm_delay() if a real underrun happens. According to
the definition of snd_pcm_delay() that we agreed on a couple of
months ago and that is now docuemented in doxygen this makes no
sense. The definition of snd_pcm_delay() goes like this:

"For playback the delay is defined as the time that a frame that is
written to the PCM stream shortly after this call will take to be
actually audible. It is as such the overall latency from the write
call to the final DAC." (from the doxygen docs)

I.e. because on the this world it is impossible to hear a sample that
hasn't even been written yet, _delay() should only return positive
values. However many drivers do return negative values on underrun.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
