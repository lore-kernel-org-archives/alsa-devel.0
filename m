From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Monotonic timestamps
Date: Mon, 21 Apr 2008 12:47:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0804111606330.13990@tm8103.perex-int.cz>
References: <20080409213602.GA2589@tango.0pointer.de>
	<Pine.LNX.4.61.0804100929390.13990@tm8103.perex-int.cz>
	<20080410142645.GB5852@tango.0pointer.de>
	<Pine.LNX.4.61.0804111411180.13990@tm8103.perex-int.cz>
	<20080411125602.GA32006@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 402122435D
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Apr 2008 12:47:49 +0200 (CEST)
In-Reply-To: <20080411125602.GA32006@tango.0pointer.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 11 Apr 2008, Lennart Poettering wrote:

> > +int snd_pcm_hw_params_can_forward(const snd_pcm_hw_params_t *params);
> > +int snd_pcm_hw_params_can_rewind(const snd_pcm_hw_params_t
> > *params);
> 
> Hmm, I am not sure if this function this way is really such a good
> idea. For example, for the PA backend for libasound/ioplug there might
> be part of the delay buffer that can be rewound and part of the buffer
> that cannot. Just think of an RTP output device. The part of the
> buffer that is maintained on the sending side might be rewindable. But
> as soon as the audio data entered the network, it might not be
> rewindable anymore, although that network "buffer" will still
> contribute to the latency.
> 
> I'd prefer some API that can tell me how much of the data actually is
> rewindable. For hw devices this would return the same size as the
> buffer size. For others it might return something smaller, and 0 for
> devices that do not support rewinding at all.

Ok, I got the idea. I've added snd_pcm_rewindable() and 
snd_pcm_forwardable() functions to alsa-lib.

> > Also note, that forward/rewind returns always 1 for current alsa-lib, 
> > because rewind was implemented in the dmix plugin. But I can imagine, that 
> > this check can be required for some compressed streams.
> 
> I assume for most of ioplug it will not return 1, right?

The rewind/forward implementation in ioplug is actually broken, because it 
moves only internal pointer without notification to real external plugin. 

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
