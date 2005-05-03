From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to tell how many frames gone to PCM
Date: Tue, 3 May 2005 10:05:00 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0505030942520.19889-100000@studcom.urz.uni-halle.de>
References: <42766BB4.2070500@pianodisc.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42766BB4.2070500@pianodisc.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Steve deRosier <derosier@pianodisc.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Steve deRosier wrote:
> So, even though I tied the MIDI timer source to the pcm timer, if
> I use real-time events, those events will use the system clock?
> I figured the MIDI timer would just be used and the time just
> calculated via whatever the MIDI timer was doing.

Only the 'tick' time is calculated based on timer ticks.  The 'real'
time uses the system clock.

> I notice in /proc/asound/card0/pcm0p/sub0/hw_params gives a
> tick_time of 1000.  Would that affect anything since I'm
> triggering the queue time off the pcm?

No, this is not related to the PCM timer.  Interrupts happen at every
period boundary ...

> # cat hw_params
> rate: 44100 (44100/1)
> period_size: 2048

... at about 21.5 Hz (44100/2048).

You might want to use smaller periods to reduce the MIDI jitter.

> The MIDI plays WAY too slow.  I don't get it.  I can speed it up
> clearly by using a larger PPQ or smaller tempo, but I can't seem
> to do it in any manner that will get my MIDI to line up with my
> audio.
>
> queue 4: [Queue-4]
> timer PPQ          : 44100
> current tempo      : 1000000
> current BPM        : 60
> current time       : 2.141090884 s
> current tick       : 94425

If we assume that the system clock and the PCM clocks are almost in
sync, the theoretical tick time should be 2.141090884 * 44100 = 94422.
The value above looks OK.

There will be some (more or less constant) delay between the MIDI
events and the corresponding PCM samples, depending of the delays in
both devices, but I cannot see how MIDI events could have the wrong
tempo.


Regards,
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
