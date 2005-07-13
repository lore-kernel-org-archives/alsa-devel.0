From: Smery <luca_ing@libero.it>
Subject: USB Audio - Silence
Date: Wed, 13 Jul 2005 00:19:54 +0000
Message-ID: <200507130019.56200.luca_ing@libero.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
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
        I have an USB device with one Audio Class interface.
snd_usb_audio detects it and register the corresponding card:

#amixer -c 3
Simple mixer control 'PCM',0
  Capabilities: cvolume cswitch cswitch-joined
  Capture channels: Mono
  Limits: Capture 0 - 3
  Mono: Capture 3 [100%] [on]

Also recording sems to work fine:
$ arecord -f dat -d 10 -D hw:3,0 foobar.wav
Recording WAVE 'foobar.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
$ ls -l foobar.wav
-rw-r--r--  1 foo foo 1920044 13 lug 00:16 foobar.wav

The problem is that I obtain a file does not contain anything other than a
sequence of "40 00" (hex) bytes.

Any idea on what happens?

Best regards


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
