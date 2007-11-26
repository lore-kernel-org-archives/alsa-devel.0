From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: POSIX clocks and ALSA
Date: Mon, 26 Nov 2007 15:44:33 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0711261534480.23163@tm8103.perex-int.cz>
References: <474A763E.7090001@cs.helsinki.fi>
	<Pine.LNX.4.61.0711260848180.7571@tm8103.perex-int.cz>
	<474A7CE1.7080904@cs.helsinki.fi> <s5h63zpph0s.wl%tiwai@suse.de>
	<474A8706.1070102@cs.helsinki.fi>
	<Pine.LNX.4.61.0711261356480.9577@tm8103.perex-int.cz>
	<s5hoddhqfpc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D773247F7
	for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2007 15:44:35 +0100 (CET)
In-Reply-To: <s5hoddhqfpc.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>, Heikki Lindholm <holindho@cs.helsinki.fi>, Mauro Carvalho Chehab <mchehab@infradead.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 26 Nov 2007, Takashi Iwai wrote:

> > > Additionally, it might be nice to be able to add audio clocks as system 
> > > wide clocks, so, that for example I could tell v4l to use timestamps 
> > > from an audio clock instead of the system clock.
> > 
> > It's something I don't like. If you have multiple soundcards, it might be 
> > problematic to select a proper audio device for sync.
> 
> But, OTOH, the audio-video-sync is more popular demand than multiple
> card sync.  This might be a good working example for timestamping.
> 
> I remember I discussed about it a bit with Mauro.   Nnow Cc'ed, in
> case he has more comments on V4L/sound sync issue.
> 
> 
> One possible problem is that the current ALSA timestamp API provides
> only volatile reads, i.e. the timestamp is being constantly updated
> and not logged/streamed coupled with the data.

I'm not sure, if it's a real problem. Applications may handle this 
internally. The accurate system time might be computed from last sample 
position (or two last positions or last position and start timestamp) and 
assigned timestamp from master system clock and sample rate (linear 
relationship). Of course, it's question, if it will be accurate enough. 
But it's rather problem with lack of hardware doing timestamping itself 
than the audio driver subsystem which can only get time as fast as stream 
position is updated from hardware.

> That's the reason I suggested to consider the API again.  We should
> check the use case at first...

Yes, it's good to define goals.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project
