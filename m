From: Frank van de Pol <fvdpol@home.nl>
Subject: Re: Re: [linux-audio-dev] midi events in jack callback / ALSA Sequencer
Date: Thu, 22 Aug 2002 01:48:11 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020821234823.GA18447@idefix.fvdpol.home.nl>
References: <Pine.LNX.4.21.0208191748480.673-100000@summer.quitte> <002001c247ac$2259e960$0400a8c0@martijn> <20020820205028.GA2657@idefix.fvdpol.home.nl> <005701c248af$94d09710$0400a8c0@martijn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail5-sh.home.nl (mail5.home.nl [213.51.128.18])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id BAA07504
	for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2002 01:48:02 +0200
Content-Disposition: inline
In-Reply-To: <005701c248af$94d09710$0400a8c0@martijn>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Martijn Sipkema <msipkema@sipkema-digital.com>
Cc: Frank van de Pol <fvdpol@home.nl>, linux-audio-dev@music.columbia.edu, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Wed, Aug 21, 2002 at 02:10:35AM +0100, Martijn Sipkema wrote:
> [...]
> > Within ALSA we have two priority queues, one for tick (bar,beat) scheduled
> > events, and one for clock (ns) scheduled events.
> 
> As MIDI uses MIDI tick messages for time based sync and MIDI clock messages
> for tempo based sync I kind of feel the ALSA sequencer naming is a little
> confusing :)

I understand. OTOH the problem might also be introduced back in the 80's
when MIDI 1.0 spec was introduced. The "MIDI Clock" (0xf8) message was
introduced with only beat sync in mind. I believe the phrase 'tick' to
specify song position came from the standard midi file (SMF 1.0)
specification.

In fact the definitions in seq_event.h are less confusing:

/** Real-time data record */
typedef struct snd_seq_real_time {
        unsigned int tv_sec;            /**< seconds */
        unsigned int tv_nsec;           /**< nanoseconds */
} snd_seq_real_time_t;

/** (MIDI) Tick-time data record */
typedef unsigned int snd_seq_tick_time_t;

/** unioned time stamp */
typedef union snd_seq_timestamp {
        snd_seq_tick_time_t tick;       /**< tick-time */
        struct snd_seq_real_time time;  /**< real-time */
} snd_seq_timestamp_t;


> 
> I don't want to support tempo (MIDI clock) scheduling in my MIDI API. This
> could be better handled in the application itself. Also, when slaved to MIDI
> clock
> it is no longer possible to send messages ahead of time, and not supporting
> this
> in the API makes that clear to the application programmer.

The concept of the public available alsa timing queues allow outboard
applications to schedule events in a tempo locked fashion. Think of
applications like drum machines, appegiators, tempo delay etc. Of course you
might be using one big monolithic (cubase?) sequencer application which does
do everything you need....

Compare it to an external (outboard) drum machine you're using since
programming a pattern in it so user friendly (hence you end up being more
creative), and sync that from your favorite sequencer which has the tempo
map for your song.

Of course all of this could be done without a queue which supports tempo
scheduling, but then you'll need to emit MIDI Clock events and rely on
immediate processing. In case a soft synth (or other potentially high
latency device) is triggered from the MIDI Clock you loose the ability to
correct for this.

[...] 
> > Since especially for soft synths (but also for some -undocumented!- USB
> midi
> > interfaces, like Emagic AMT)
> 
> Yes, I've repeatedly asked Emagic for documentation on their AMT protocol
> without success. :(

let them burn in peace.... 

[...]
> > When using events instead of midi bytes the merging is a no brainer
> 
> I was planning on doing that, but even then there are issues with for
> example
> (N)RPNs.
> 
> > leaves room for events not defined in midi spec).
> 
> ...I'm not sure that is a good idea. What kind of events?

eg.

- system events like announcements of topology changes
- (N)RPNs as a 14 bit value instead of 2x 7bit
- SMF like meta data
- controls for current sequencer queue: tempo, position, etc.

to name a few

Cheers,
Frank.

-- 
+---- --- -- -  -   -    - 
| Frank van de Pol                  -o)    A-L-S-A
| FvdPol@home.nl                    /\\  Sounds good!
| http://www.alsa-project.org      _\_v
| Linux - Why use Windows if we have doors available?


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
