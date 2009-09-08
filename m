From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Is there a way to figure out if the clocks of
	two	snd_pcm_t's deviate? (snd_pcm_info_get_sync?)
Date: Wed, 9 Sep 2009 01:18:53 +0200
Message-ID: <20090908231853.GC32605@tango.0pointer.de>
References: <20090903230351.GA7493@tango.0pointer.de>
	<6160a5130909040552k34548733o3d2fc71e1a7362c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id C01FA24364
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Sep 2009 01:19:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <6160a5130909040552k34548733o3d2fc71e1a7362c8@mail.gmail.com>
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

On Fri, 04.09.09 07:52, pl bossart (bossart.nospam@gmail.com) wrote:

> 
> > I am looking for a way to find out whether the clocks of two
> > snd_pcm_t's are perfectly in sync and don't deviate (or only deviate
> > by a constant phase).
> 
> short answer:no
> You would need hardware that would count the bit clock transitions and
> provide the delta. Few devices provide this in the consumer space, and
> when they do they actually perform an asynchronous sample-rate
> conversion on the fly (cf. Freescale DSP563xx). Analog Devices also
> provides dedicated sample-rate converters that perform this comparison
> and resampling; they are typically used when multiple masters are
> present.
> All this nice hardware wouldn't work anyway for USB where audio is
> transmitted in packets every ms; it's hard to guess what the real
> audio speed is.

But that should already be good enough for my purposes. I mostly care
that over a longer period of time the deviation between input and
output (or two outputs) is bounded. That means, if there is a fixed
time deviation between recording and playback and I know only that it
is fixed but don't know exactly what it is I am already a happier man.

> That's the reason why I introduced the resampling enable/disable in
> the PA module-loopback code, only the user/system designer will know
> if you have one master or more, and whether you should enable
> variable-rate interpolation.

but why shouldn't this information be queriable from the drivers?
Drivers do know a lot about the hardware they drive, so they should
now about clocks, too.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
