From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Timer instability
Date: Tue, 24 Feb 2009 22:16:21 +0100
Message-ID: <20090224211621.GA25412@tango.0pointer.de>
References: <s5hy6w2hqap.wl%tiwai@suse.de>
	<20090220012220.GA11526@tango.0pointer.de>
	<s5h1vtty3f8.wl%tiwai@suse.de>
	<20090220203417.GA19093@tango.0pointer.de>
	<s5hhc2nu4qy.wl%tiwai@suse.de>
	<20090222031453.GA24365@tango.0pointer.de>
	<s5h8wnvreab.wl%tiwai@suse.de>
	<20090224184604.GA2253@tango.0pointer.de>
	<s5hocwr64pz.wl%tiwai@suse.de>
	<20090224192611.GC2253@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 272E61037F6
	for <alsa-devel@alsa-project.org>; Tue, 24 Feb 2009 22:16:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090224192611.GC2253@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 24.02.09 20:26, Lennart Poettering (mznyfn@0pointer.de) wrote:

> Oh, and one thing I didn't actually notice earlier: Most drivers return
> a negative snd_pcm_delay() if a real underrun happens. According to
> the definition of snd_pcm_delay() that we agreed on a couple of
> months ago and that is now docuemented in doxygen this makes no
> sense. The definition of snd_pcm_delay() goes like this:
> 
> "For playback the delay is defined as the time that a frame that is
> written to the PCM stream shortly after this call will take to be
> actually audible. It is as such the overall latency from the write
> call to the final DAC." (from the doxygen docs)
> 
> I.e. because on the this world it is impossible to hear a sample that
> hasn't even been written yet, _delay() should only return positive
> values. However many drivers do return negative values on underrun.

I take this back.

I think the correct way to handle an underrun when stop_threshold is
set to boundary is that if a write happens after an underrun the
appropriate amount of data is simply dropped. I think enabling this
mode is primarily useful to guarantee timer stability even in case of
underrun. That means snd_pcm_delay() should very well return negative
values meaning "what you write next is past the playback pointer, it
will not be heard".

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
