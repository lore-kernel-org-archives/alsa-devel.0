From: "Dmitry Baikov" <dsbaikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: alsaseq reorders my events
Date: Thu, 1 Mar 2007 16:35:02 +0300
Message-ID: <70a871c80703010535p512ebabfke3c57d441a7fe2fb@mail.gmail.com>
Reply-To: The Linux Audio Developers' Mailing List <linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=unsubscribe>
List-Archive: <http://music.columbia.edu/pipermail/linux-audio-dev>
List-Post: <mailto:linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
List-Help: <mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=help>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=subscribe>
Sender: linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Errors-To: linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
To: alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Jack Dev List <jackit-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi!

I nearly finished alsaseq driver for jackmidi, but have a problem.
Alsaseq reorders events in fast sequences, so note-on/note-off pairs got mixed.

The algorithm of sending is simple:

 		snd_seq_ev_schedule_real(&alsa_event, output_que, 1, &timestamp);
		frame_time = jack_frame_time(self->jack);
		frame_offset = event.time - frame_time;

		offset = ((long long)frame_offset) * 1000000000 / rate;
		timestamp.tv_sec = (long) (offset / 1000000000);
		timestamp.tv_nsec = (long) (offset % 1000000000);
 		snd_seq_event_output(self->seq, &alsa_event);


Here are the traces of what is going on:

jackmidi_alsaseq reads events from external midi interface and send
them to another midi interface.

Log shows what is being sent to alsaseq and when. Output format is:
[event] at [event.time] ([frame_time] + [frame_offset]) (+[offset]ns)

c0ff@ace ~/src/jack/alsamidi $ ./jackmidi_alsaseq
port created: in (20:0)  MIDI 1
port created: out (20:0)  MIDI 1
port created: in (24:0) USB Trigger Finger MIDI 1
port created: out (24:0) USB Trigger Finger MIDI 1
port_event: ADD 130:0
port created: out (130:0) aseqdump
90 4e 7f  at 86646526 (86622198 + 24328) (+506833333ns)
80 4e 40  at 86649830 (86622200 + 27630) (+575625000ns)
90 4e 7f  at 86654006 (86622201 + 31805) (+662604166ns)
80 4e 40  at 86656795 (86638582 + 18213) (+379437500ns)
90 4e 7f  at 86660562 (86638584 + 21978) (+457875000ns)
80 4e 40  at 86663502 (86638584 + 24918) (+519125000ns)
90 4e 7f  at 86666819 (86638585 + 28234) (+588208333ns)
80 4e 40  at 86669453 (86638585 + 30868) (+643083333ns)
90 4e 7f  at 86673078 (86654965 + 18113) (+377354166ns)
80 4e 40  at 86676430 (86654966 + 21464) (+447166666ns)
90 4e 6f  at 86678638 (86654967 + 23671) (+493145833ns)
80 4e 40  at 86680654 (86654968 + 25686) (+535125000ns)

We can see that all events go strictly in order (their frame_time is
monotonically increasing). Frame offsets are so big, because it runs
under jackd -d dummy -p 16384.

At the same time, aseqdump is hooked to jackmidi_alsaseq output port:

c0ff@ace ~ $ aseqdump
Waiting for data at port 130:0. Press Ctrl+C to end.
Source_ Event_________________ Ch _Data__
  0:1   Port subscribed           128:5 -> 130:0
  0:1   Port subscribed           128:2 -> 130:0
128:2   Note on                 0  78 127
128:2   Note off                0  78  64
128:2   Note off                0  78  64
128:2   Note on                 0  78 127
128:2   Note on                 0  78 127
128:2   Note on                 0  78 127
128:2   Note off                0  78  64
128:2   Note on                 0  78 127
128:2   Note off                0  78  64
128:2   Note off                0  78  64
128:2   Note on                 0  78 111
128:2   Note off                0  78  64

We see, Note on/Note off events are mixed.
Your suggestions, please.

Regards,
Dmitry.

P.S. Not wanting to start a flame war, but it is exactly the case, why
it's better for jackmidi driver to use as lower-level interface as
possible - less problems, more control.

P.P.S. alsa-devels, if you reply, please CC me, i'm not subscribed.
