From: Oliver Freyd <Oliver.Freyd@gmx.de>
Subject: trident (Hoontech 4d Wave NX) dropouts with small buffersize.
Date: Tue, 5 Oct 2004 22:13:52 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041005201351.GA25577@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

I use snd-trident with OSS emulation to access my soundcard.
Music plays nicely, xmms and the like, but after alsa-0.90
or so the linux games began sounding distorted (like tuxracer,
frozen-bubbles, mirrormagic, all SDL-games that my step-son likes...). 
Now I done some more tests to find out where it comes from:

The games use /dev/dsp, and /proc/asound/card0/pcm0p/sub0/hw_params says:
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 22050 (22050/1)
period_size: 512
buffer_size: 1024
tick_time: 10000

well, you hear drop outs, or even bits of sound repeated, sounds weird
( this doesn't happen with the standard OSS trident driver, BTW)
I guess the game people want the buffer size small for low latency...
Seems it is loosing some interrupts or so...

With xmms, buffer_size is 16384, and all is well...

Well, maybe anyone here on this list has an idea what has happened
in the alsa drivers after 0.90 to trigger this bug.

I'm running debian testing, 
alsa-source-1.0.5a-3
kernel 2.4.26
on a dual celeron 300.

Well, maybe this report can be helpful in further development 
of ALSA...

best regards,

    Oliver Freyd



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
