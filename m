From: Seven Corvina <seven.corvina@gmail.com>
Subject: Intel HD Audio Soundcard Problems
Date: Sun, 09 Apr 2006 19:27:40 -0700
Message-ID: <1144636060.6320.8.camel@sparkle>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

I recently was given a Dell Inspiron 9400 by work, and the first thing I
did was drop linux on it. I've had hell-in-a-handbasket getting it
working, but I'm down to my last two problems... and sound is one.

It's the Dell Inspiron 9400/E1705 Laptop... I'm not getting any sound
output through ALSA, using no OSS applications.

lspci -vvv:
http://udevio.us/files/lspcivvv.txt

uname -a:
seven@sparkle:~$ uname -a
Linux sparkle 2.6.16.2 #3 PREEMPT Sun Apr 9 18:53:54 PDT 2006 i686
GNU/Linux

lsmod | grep intel:
seven@sparkle:~$ lsmod |grep intel
snd_hda_intel          17296  2
snd_hda_codec         121984  1 snd_hda_intel
snd_pcm                86152  3 snd_hda_intel,snd_hda_codec,snd_pcm_oss
snd                    52224  10
snd_hda_intel,snd_hda_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
snd_page_alloc         10504  2 snd_hda_intel,snd_pcm
intel_agp              22812  1
agpgart                32476  3 drm,intel_agp

Umm, please tell me if there's anything else you need. I tested using an
Example ogg, as follows:

seven@sparkle:~$ ogg123 -d
alsa09 /home/seven/Examples/kalimoto-miracle-\ lemon.ogg

Audio Device:   Advanced Linux Sound Architecture (ALSA) output

Playing: /home/seven/Examples/kalimoto-miracle- lemon.ogg
Ogg Vorbis stream: 2 channel, 44100 Hz

Done.

It played all the way through, but no sound came out. X.x

Seven

PS. Sorry if I sent this twice; I'm on a really weak network and gmail
is having trouble getting response back to me.



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
