From: jesse fillion <jessefillion24@hotmail.com>
Subject: Ubuntu sound problem -
 http://ubuntuforums.org/showthread.php?t=1073090
Date: Thu, 9 Apr 2009 10:19:42 -0600
Message-ID: <BLU132-W46435E073082F30B96BF12C4830@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from blu0-omc3-s18.blu0.hotmail.com (blu0-omc3-s18.blu0.hotmail.com
	[65.55.116.93]) by alsa0.perex.cz (Postfix) with ESMTP id E003E2412E
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Apr 2009 18:20:15 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Good afternoon,
 
My name is Jesse. Forgive me if this is not the correct address to be sending this type of request to, but I am looking for support in getting the Alsa drivers to work correctly with HP DV4 laptops. The DV4 1228ca has a Azalia RS780 soundcard. I have the ability to hear music through the headphone jack, but not the internal speakers (please see ubuntu forum for additional information). 
I would truly appreciate any information you could provide. Thank you.
 
-Jesse
 

 
Hi, I'm relatively new to Ubuntu and would be thrilled for any assistance anyone can provide me with this problem. I have an HP DV4 1228ca. Just like everyone, I did have sound through my front audio jack and could listen to with headphones. Unfortunately after trying all of your helpful suggestions, I don't even have audio in my front jack anymore. If I go into my sound properties, it doesnt seem to recognize my sound card anymore. I beleive this has to do with the entry in the alsa base file. 
Here are my results:

"[code]#> ./configure --enable-dynamic-minors
#> make"

winblows@ubuntu:~/Desktop/AlsaDriver/alsa-driver$ make
make dep
make[1]: Entering directory `/home/winblows/Desktop/AlsaDriver/alsa-driver'
make[2]: Entering directory `/home/winblows/Desktop/AlsaDriver/alsa-driver/acore'
copying file alsa-kernel/core/info.c
/home/winblows/Desktop/AlsaDriver/alsa-driver/utils/patch-alsa: 24: patch: not found
make[2]: *** [info.c] Error 1
make[2]: Leaving directory `/home/winblows/Desktop/AlsaDriver/alsa-driver/acore'
make[1]: *** [dep] Error 1
make[1]: Leaving directory `/home/winblows/Desktop/AlsaDriver/alsa-driver'
make: *** [include/sndversions.h] Error 2

#> sudo make install-modules

This is where my noobishness may shine through. I wasn't quite sure what to take from the make process above so I continued...
winblows@ubuntu:~/Desktop/AlsaDriver/alsa-driver$ sudo make install-modules
[sudo] password for winblows: 
find /lib/modules/2.6.27-11-generic/kernel/sound -name 'snd*.*o' | xargs rm -f
find /lib/modules/2.6.27-11-generic/kernel/sound -name 'snd*.*o.gz' | xargs rm -f
find /lib/modules/2.6.27-11-generic/kernel/sound -name 'ac97_bus.*o' | xargs rm -f
find /lib/modules/2.6.27-11-generic/kernel/sound -name 'ac97_bus.*o.gz' | xargs rm -f
make[1]: Entering directory `/home/winblows/Desktop/AlsaDriver/alsa-driver/acore'
mkdir -p /lib/modules/2.6.27-11-generic/kernel/sound/acore
cp snd-hrtimer.ko snd-hwdep.ko snd-page-alloc.ko snd-pcm.ko snd-rawmidi.ko snd-timer.ko snd.ko /lib/modules/2.6.27-11-generic/kernel/sound/acore
cp: cannot stat `snd-hrtimer.ko': No such file or directory
cp: cannot stat `snd-hwdep.ko': No such file or directory
cp: cannot stat `snd-page-alloc.ko': No such file or directory
cp: cannot stat `snd-pcm.ko': No such file or directory
cp: cannot stat `snd-rawmidi.ko': No such file or directory
cp: cannot stat `snd-timer.ko': No such file or directory
cp: cannot stat `snd.ko': No such file or directory
make[1]: *** [modules_install] Error 1
make[1]: Leaving directory `/home/winblows/Desktop/AlsaDriver/alsa-driver/acore'
make: *** [install-modules] Error 1


#> sudo vim /etc/modprobe.d/alsa-base
[add 'options snd_hda_intel model=hp-dv5' sans quotes to the bottom of the file, even if you have a dv4, etc.]


I have tried each of the following, rebooting in between them:

options snd_hda_intel model=hp-dv5

options snd_hda_intel model=hp-dv4

# Keep snd-pcsp from beeing loaded as first soundcard
options snd-pcsp index=-2
alias snd-card-0 snd-hda-intel
alias sound-slot-0 snd-hda-intel
options snd-hda-intel model=dell-m4-1 
options snd-hda-intel enable_msi=1

# Keep snd-pcsp from beeing loaded as first soundcard
options snd-pcsp index=-2
alias snd-card-0 snd-hda-intel
alias sound-slot-0 snd-hda-intel
options snd-hda-intel model=hp=dv4 
options snd-hda-intel enable_msi=1

I have also tried using the 3.4 compiler and "unstable" alsa snapshot package recommended by uticamarco.

If anyone has any suggestions, I would be most grateful. Thank you very much.
 
 
 Jesse
_________________________________________________________________
Internet Explorer 8 helps keep your personal info safe.
http://go.microsoft.com/?linkid=9655581
