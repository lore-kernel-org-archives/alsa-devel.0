From: Juan Linietsky <coding@reduz.com.ar>
Subject: Re: Forcing an absolute timestamp for every midi event.
Date: Sun, 18 Aug 2002 19:17:01 -0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020818191701.2d3f66ec.coding@reduz.com.ar>
References: <20020818055740.2af8e3e7.coding@reduz.com.ar>
	<20020818124850.GA2929@idefix.fvdpol.home.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from john.anime.com.ar ([64.113.39.216])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id AAA10032
	for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2002 00:15:47 +0200
In-Reply-To: <20020818124850.GA2929@idefix.fvdpol.home.nl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
Cc: Frank van de Pol <fvdpol@home.nl>
List-Id: alsa-devel@alsa-project.org

On Sun, 18 Aug 2002 14:48:49 +0200
Frank van de Pol <fvdpol@home.nl> wrote:

> 
> 
> 
> On Sun, Aug 18, 2002 at 05:57:40AM -0300, Juan Linietsky wrote:
> > Hi! I wanted to ask, how about forcing
> > an absolute timestamp for _every_ midi event?
> 
> It's not 100% clear to me wat you mean. When using the sequencer api
> you already have a timestamp (either tick/clock) for every event
> scheduled. Midi data captured from eg. the midi input port is
> timestamped upon receive IRQ.

Well, thats what i thought too by watching the code, but I check any
received
event, from any source and all variables are all zero. Instead, alsa
promises to deliver events at the right time, which is fine.. but not
enough!

include/alsa/seq_event.h:row 421
This is the struct of any event I receive when polling the device,
on my sequencer client:

typedef struct snd_seq_event {
[..] which includes...
        snd_seq_timestamp_t time;
[..]
} snd_seq_event_t;

this struct has...

typedef union snd_seq_timestamp {
        snd_seq_tick_time_t tick;       /**< tick-time */
        struct snd_seq_real_time time;  /**< real-time */
} snd_seq_timestamp_t;

To which i wonder.. first, why is this an union? why cant both be
there?

well, anyway.. snd_seq_tick_time_t is an int,
and snd_seq_real_time is:

typedef struct snd_seq_real_time {
        unsigned int tv_sec;            /**< seconds */
        unsigned int tv_nsec;           /**< nanoseconds */
} snd_seq_real_time_t;

This should technically give me info about the absolute time in which
the event has to be played,
basically what i need in order to do a certain amount of offline
processing.
This way, my softsynth wont need extremely low audio latency to play
accurate timing.

But! All this struct is zeroed, _allways_ zeroed, no info is ever
proovided to my sequencer client.
I think this is either a design problem, or a serious bug in the api. 


Juan Linietsky


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
