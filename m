From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB Audio/Midiman - partial success
Date: Mon, 16 Sep 2002 09:05:27 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0209160853230.11671-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.31.0209132140320.13642-200000@lorien.wv.mentorg.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <Pine.LNX.4.31.0209132140320.13642-200000@lorien.wv.mentorg.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Pikus, Fedor" <fedor_pikus@mentorg.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Fedor G. Pikus wrote:
> Latest TOT drivers from CVS, compiled, installed, rebooted WITH DUO OFF.
> Ran /etc/init.d/alsasound start, turned Duo on.
> Check /proc/asound/card1/stream0 - everything is there (I attached the file)
>
> Do /etc/init.d/alsasound stop, then /etc/init.d/alsasound start - only 2
> interfaces are present. Ok, let's see what /etc/init.d/alsasound stop
> does not unload... 2 modules, audio and soundcore. Do stop, unload those,
> do start - all 5 interfaces are there. Now I see what's the problem with
> booting while Duo is on: as soon as USB controller is initialized, hotplug
> kicks in and loads audio module.

"audio" is the OSS driver from the kernel. As you've seen, having two
drivers compete for one device isn't desirable. Usually, the OSS drivers
should be disabled when using ALSA.

Either
- deactivate the OSS drivers and recompile the kernel, or
- delete audio.o, or
- add audio to the blacklist file in /etc/hotplug.

> Now, can someone tell me why this fails:
> arecord -f S16_LE -r 96000 -c 2 -D hw:1,0 /tmp/test.wav
> Recording WAVE '/tmp/test.wav' : Signed 16 bit Little Endian, Rate 96000 Hz, Stereo
> arecord: pcm_read:1049: read error: Input/output error
> (after several seconds).

Anything in /var/log/mesages?
Does it happen with 24 bits, too?
Is the data in the file correct (as far as is has been recorded)?


HTH
Clemens



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
