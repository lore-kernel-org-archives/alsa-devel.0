From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: possible problems with rc6 aplay
Date: Sun, 15 Dec 2002 22:13:45 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18NleD-0004xk-00@sc8-sf-list1.sourceforge.net>
References: <3DFCFB5A.9B34D27C@earthlink.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Sun, 15 Dec 2002 15:59:54 CST."
             <3DFCFB5A.9B34D27C@earthlink.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: patrick reardon <swpatrick@earthlink.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Latency: 4096 samples (2 periods of 16384 bytes)
>Hardware pointer (frames): 0
>Passthru: no
>Clock mode: autosync
>Pref. sync source: ADAT1
>
>IEC958 input: Coaxial
>IEC958 output: Coaxial only
>IEC958 quality: Consumer
>IEC958 emphasis: off
>IEC958 Dolby: off
>IEC958 sample rate: error flag set
>
>ADAT Sample rate: 44100Hz

if you're hammerfall is configured as shown above (and no, the name
change makes no difference), then the SR that it uses will be
determined by your external converter connected to the first ADAT
port. nothing that ALSA does (or any program using ALSA does) will
alter the SR. thats because you are synced to ADAT1, not the card's
internal clock, thus the SR is determined by the clock signal arriving
at ADAT1, which presumably comes from a converter somewhere back up
the ADAT chain.

its been on my to-do list for some time to make "master" the default
clock mode on the hammerfall, which avoids any ambiguity about the
sample rate used by the card. i've held back because its really not
the right option for most studio-ish users, who have external
converters that probably have rate switches on them and they expect
the hammerfall to follow the switch setting.

does any of this make it any clearer? its really a bit of problem that
the rate setting code doesn't do a full 100% check on all this
stuff. an app can set the rate to 44100, and appear to have succeeded,
but it will have no difference on the actual rate if the sync source
is not the clock's internal clock. this is true, btw, for most digital
cards. if you tried to record at 44100, but your external converters
were running at 48kHz (as you suggest they have been), then the
recordings will be at 48kHz with the sync source set as shown above.

--p




-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
