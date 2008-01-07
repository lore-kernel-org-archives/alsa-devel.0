From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: snd_pcm_status_get_tstamp()
Date: Mon, 7 Jan 2008 16:57:50 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0801071657160.22730@tm8103.perex-int.cz>
References: <20071231165340.GA17734@tango.0pointer.de>
	<s5hejctao28.wl%tiwai@suse.de>
	<20080107152155.GC14386@tango.0pointer.de>
	<s5habnh8xmh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B8662461E
	for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2008 16:57:51 +0100 (CET)
In-Reply-To: <s5habnh8xmh.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

On Mon, 7 Jan 2008, Takashi Iwai wrote:

> At Mon, 7 Jan 2008 16:21:55 +0100,
> Lennart Poettering wrote:
> > 
> > On Mon, 07.01.08 12:10, Takashi Iwai (tiwai@suse.de) wrote:
> > 
> > > > The documentation for snd_pcm_status_get_tstamp() is not really
> > > > enlightening. After a call to snd_pcm_status() what data does the
> > > > tstamp field actually carry? Some kind of system clock timestamp when
> > > > the data in the status struct was valid, or some kind of sound card
> > > > clock timestamp that is relative to the point in time where the device
> > > > was opened/started?
> > > 
> > > In the normal mode, it's the timestamp at the moment snd_pcm_status()
> > > is processed.  OTOH, the trigger_tstamp is the time that the trigger
> > > callback was called (e.g. the stream starts / stops).
> > > The time is the system-wide time, equivalent with the normal
> > > gettimeofday().
> > 
> > So I figure this is always CLOCK_REALTIME?
> > 
> > I am currently using CLOCK_MONOTONIC for most timekeeping in
> > PulseAudio. Would it be possible to add an API to ALSA to allow
> > getting those timestamps in CLOCK_MONOTONIC instead of CLOCK_REALTIME?
> 
> CLOCK_MONOTONIC is already available in the newer version of
> ALSA-driver.  But, the corresponding alsa-lib API isn't implemented
> yet.

Right. I will do this.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
