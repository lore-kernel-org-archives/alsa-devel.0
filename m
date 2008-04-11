From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Monotonic timestamps
Date: Fri, 11 Apr 2008 14:56:02 +0200
Message-ID: <20080411125602.GA32006@tango.0pointer.de>
References: <20080409213602.GA2589@tango.0pointer.de>
	<Pine.LNX.4.61.0804100929390.13990@tm8103.perex-int.cz>
	<20080410142645.GB5852@tango.0pointer.de>
	<Pine.LNX.4.61.0804111411180.13990@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A51A243B4
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Apr 2008 14:56:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0804111411180.13990@tm8103.perex-int.cz>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 11.04.08 14:16, Jaroslav Kysela (perex@perex.cz) wrote:

> > value returned by clock_gettime() represents the amount of time (in
> > seconds and nanoseconds) since an unspecified point in the past (for
> > example, system start-up time, or the Epoch). This point does not
> > change after system start-up time.
> > </snip>
> 
> Thanks for this link. But in 2.6 linux kernel, there is only system 
> start-up time initializer for CLOCK_MONOTONIC, so the check is not so 
> heuristics. 

Uh, but they might change this at any time in accordance with the specs.

> Anyway, I added these functions to ALSA API, so you can remove 
> timestamp / rewind notes from your list:
> 
> +int snd_pcm_hw_params_is_monotonic(const snd_pcm_hw_params_t *params);

Awesome, just what I need. /me crosses another item of the list.

> +int snd_pcm_hw_params_can_forward(const snd_pcm_hw_params_t *params);
> +int snd_pcm_hw_params_can_rewind(const snd_pcm_hw_params_t
> *params);

Hmm, I am not sure if this function this way is really such a good
idea. For example, for the PA backend for libasound/ioplug there might
be part of the delay buffer that can be rewound and part of the buffer
that cannot. Just think of an RTP output device. The part of the
buffer that is maintained on the sending side might be rewindable. But
as soon as the audio data entered the network, it might not be
rewindable anymore, although that network "buffer" will still
contribute to the latency.

I'd prefer some API that can tell me how much of the data actually is
rewindable. For hw devices this would return the same size as the
buffer size. For others it might return something smaller, and 0 for
devices that do not support rewinding at all.

Since PA mostly will only run on hw devices _can_forward() is probably
good enough for my purposes, though.

> Also note, that forward/rewind returns always 1 for current alsa-lib, 
> because rewind was implemented in the dmix plugin. But I can imagine, that 
> this check can be required for some compressed streams.

I assume for most of ioplug it will not return 1, right?

Thanks a lot,

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
