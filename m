From: "Paul E. Erkkila" <pee@erkkila.org>
Subject: possibly bug, sb audigy 2.5.61 and ac3 passthrough
Date: Sun, 16 Feb 2003 23:39:42 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E50213E.4080109@erkkila.org>
Reply-To: pee@erkkila.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Greetings,

   I'm trying to get ac3 passthrough working on my media pc.  However
when i try and open /dev/snd/pcmC0D3p i receive a no such device error.
I noticed a few not really resolved answers in the archives so i figured
I'd post again. The devices exist in /dev/snd and /proc/asound/dev and
playback and recording function correctly now (even sound via the
optical connection to the receiver). I've read through all the online
help i could find and am still stumped =/

It looks like it's comming from the -ENODEV return in emufx.c,
but i don't know enough about alsa internals to figure it out yet.

setup is  an sb audigy, connecting via the external optical connector
  to a denon dolby/dts/*  receiver.

As part of trying to figure this out, i used mplayer with the oss
api isntead of alsa9,  (mplayer -aid 128 -ao oss:iec958:AES0=0x87 -ac hwac3 -fs -dvd 1)
this produces an incredibly LOUD clicking/screaching noise from the
receiver.


root # cat /dev/snd/pcmC0D3p
cat: /dev/snd/pcmC0D3p: No such device

boobtoob root # ac3dec -C
Using PCM device 'iec958:AES0=0x2,AES1=0x82,AES2=0x0,AES3=0x2'
ALSA lib pcm_hw.c:866:(snd_pcm_hw_open) open /dev/snd/pcmC0D3p failed: No such device
snd_pcm_open: No such device
Output open failed

It certainly seems like something should be on minor 19..

root# more /proc/asound/devices
   0: [0- 0]: ctl
   4: [0- 0]: hardware dependent
   9: [0- 1]: raw midi
   8: [0- 0]: raw midi
  19: [0- 3]: digital audio playback
  26: [0- 2]: digital audio capture
  25: [0- 1]: digital audio capture
  16: [0- 0]: digital audio playback
  24: [0- 0]: digital audio capture
  33:       : timer

modprobe stuff:
options snd cards_limit=1
options snd-card-0 extin=0x3fff extout=0x1fff
options snd-emu10k1 extin=0x3fff extout=0x1fff


any help would be appreciated,

thanks,

-pee




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
