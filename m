From: Pavel Roskin <proski@gnu.org>
Subject: Re: integration of via668 and via8233 drivers
Date: Fri, 6 Sep 2002 10:03:07 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0209060956500.2226-100000@portland.hansa.lan>
References: <s5hsn0nwg7d.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hsn0nwg7d.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello!

> i think esd tries to set too small fragment size.
> anyway, could you check the output of
> /proc/asound/card0/pcm0p/sub0/hw_params for each bad case?

Yes, it looks like that.  If the sound is bad, period_size is 1024 or
less.  If the sound is good, period_size is 2048 or more.

> > timidity -Ou -o - ode2joy.mid | aplay -            Bad

That's the simplest case because it doesn't involve OSS emulation.  -Ou 
means using Sun AU format.  The default sampling rate is 8k.  The sound 
becomes good when the sampling rate is more than 12k.  Now let's look at 
this:

timidity -Ou -o - -s 12k ode2joy.mid | aplay -
bad sound
/proc/asound/card0/pcm0p/sub0/hw_params:

access: MMAP_INTERLEAVED
format: S16_LE
subformat: STD
channels: 1
rate: 12000 (12000/1)
period_size: 1024
buffer_size: 6000
tick_time: 10000


timidity -Ou -o - -s 12.5k ode2joy.mid | aplay -
good sound
/proc/asound/card0/pcm0p/sub0/hw_params:

access: MMAP_INTERLEAVED
format: S16_LE
subformat: STD
channels: 1
rate: 12500 (12500/1)
period_size: 2048
buffer_size: 6250
tick_time: 10000


buffer_size changed insignificantly.  period_size jumped from 1024 to 
2048.  There are no other changes.

-- 
Regards,
Pavel Roskin



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
