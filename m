From: Erik de Castro Lopo <erikd-alsa@mega-nerd.com>
Subject: Re: Two sound cards, only sound out of one
Date: Fri, 29 Aug 2003 12:18:33 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030829121833.60c7d4e3.erikd-alsa@mega-nerd.com>
References: <20030824121353.06de39c8.erikd-alsa@mega-nerd.com>
	<Pine.HPX.4.33n.0308251310590.14875-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0308251310590.14875-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

Sorry for the delay in responding to this.

On Mon, 25 Aug 2003 13:13:37 +0200 (METDST)
Clemens Ladisch <clemens@ladisch.de> wrote:

> The same happens with "hw:1" instead of "card1"?

Hmm, I think this might be some interesting info:

These two commands work:
    root@sound:~# aplay -vv -D hw:1 a.wav 
    Playing WAVE 'a.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Mono
    Hardware PCM card 1 'Ensoniq AudioPCI' device 0 subdevice 0


    root@sound:~# aplay -vv -D card0 a.wav 
    Playing WAVE 'a.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Mono
    Hardware PCM card 1 'Ensoniq AudioPCI' device 0 subdevice 0

while these two don't:

    root@sound:~# aplay -vv -D hw:0 a.wav 
    Playing WAVE 'a.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Mono
    Hardware PCM card 0 'Ensoniq AudioPCI' device 0 subdevice 0

    root@sound:~# aplay -vv -D card1 a.wav 
    Playing WAVE 'a.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Mono
    Hardware PCM card 0 'Ensoniq AudioPCI' device 0 subdevice 0

So obviously I have my definitions in /etc/asound.conf a little mixed up
but I still have one card working and one not.

> Is the output of "lspci -x" the same for both cards (except port and
> irq settings)?

Slightly different:

    00:0a.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
    00: 74 12 80 58 05 00 10 24 02 00 01 04 00 20 00 00
    10: 01 a4 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    20: 00 00 00 00 00 00 00 00 00 00 00 00 74 12 00 20
    30: 00 00 00 00 dc 00 00 00 00 00 00 00 0a 01 0c 80
    
    00:0d.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 08)
    00: 74 12 71 13 05 00 10 24 08 00 01 04 00 20 00 00
    10: 01 94 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    20: 00 00 00 00 00 00 00 00 00 00 00 00 74 12 71 13
    30: 00 00 00 00 dc 00 00 00 00 00 00 00 05 01 0c 80

> Are the mixer controls really exactly the same (run "alsactl store"
> and look into /etc/asound.state)?

Well I'm actually running two instances of alsamixergui using:

    alsamixergui -c 0 &
    alsamixergui -c 1 &

The devices shown by the two instances are slightly different and the controls
work independantly.

Erik
-- 
+-----------------------------------------------------------+
  Erik de Castro Lopo  nospam@mega-nerd.com (Yes it's valid)
+-----------------------------------------------------------+
"The lusers I know are so clueless, that if they were dipped in clue
 musk and dropped in the middle of pack of horny clues, on clue prom
 night during clue happy hour, they still couldn't get a clue."
--Michael Girdwood, in the monastery


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
