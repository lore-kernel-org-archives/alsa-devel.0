From: Ivica Ico Bukvic <ico@fuse.net>
Subject: More issues with hdsp and 1.0.7 and 1.0.8 drivers
Date: Thu, 13 Jan 2005 22:16:56 -0500
Message-ID: <200501132216.57044.ico@fuse.net>
Reply-To: ico@fuse.net
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
Cc: alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

Ever since I finally got to solve my pcmcia cardbus problem, I've been using 
the 1.0.5 driver for a while and hdsp+multiface worked more or less fine.

By more or less, I mean that one problem persisted: the hdspmixer's levels 
were way off and it exhibited the following problems:

1) the monitoring of analog inputs only worked for the first 7 inputs which 
accurately showed signal levels below -105 dB, which should be as expected.
2) the middle row, bottom row, as well as main outs showed some levels but the 
peaks were extremely latent and often hung below the actual levels which 
obviously made no sense. Furthermore, the green level bars were also very 
inert and bottom row almost never showed them at all

Recently I read somewhere discussion that some of these problems have been 
addressed so I resorted to installing the latest drivers and here are the 
problems I found:

1.0.8 driver install completely from scratch using sources has the following 
problem:

1) hdsp card gets detected and everything goes fine until the firmware needs 
to be loaded.
2) at that point if I run hdsploader I get the following undocumented error:

hdsploader - firmware loader for RME Hammerfall DSP cards
Looking for HDSP + Multiface or Digiface cards :
Card 0 : VIA 8235 with ALC250 at 0x1000, irq 22
Card 1 : RME Hammerfall DSP at 0x20000000, irq 17
Upload firmware for card hw:1
Hwdep ioctl error on card hw:1 : Invalid argument.
Card 2 : Virtual MIDI Card 1

No other errors are noted in syslog or /var/log/messages

I tried recompiling twice and I also made sure that no stale rpm's were around 
or old sources. I am using 2.6.7 custom kernel (slightly modified sds version 
linked to from the thac's rpms site http://rpm.nyvalls.se -- modifications 
should have nothing to do with audio though).

==========================

Then I tried installing 1.0.7 from scratch and that one went fine and 
hdsploader worked just fine. However, when I started hdspmixer, it had 
exhibited the following behavior:

1) only first 7 inputs (instead of 8) were still monitored but all of them 
were at -6dB meaning most of the bars were showing continuous levels of input 
even though there was nothing coming into the card which leads me to believe 
that their values were simply offset since the 1.0.5 version.
2) middle row now had very active peaks which were accurately reflecting level 
peaks but the levels were somewhat messed up (on the screenshot I am sending 
you link below you'll notice that the 2nd channels shows nothing even though 
a stereo file is being played and there are obvious peaks present, while the 
1st channel flickered a lot, it was way greater than it's supposed level, and 
it took it a long time to dissipate once the signal ceased)
3) bottom rows apparently worked ok

I am also including a link to the screenshot for your convenience:
http://meowing.ccm.uc.edu/~ico/Linux/hdsp.jpg

NB:

1) soundcard works ok in Windows so hw is not the issue.
2) sound used for the screenshot is dc-offset-free normalized sound that 
should not clip
3) system worked fine as pointed before on 1.0.5 except for similar issues 
with hdspmixer

==========================

Just for fun I also tried to figure out where the source of the problem  was 
regarding the first issue (hdsploader failing), so I did some tests (please 
note that each of the situations were tested both with sources and rpm's 
where available):

1) when I installed all 1.0.7 packages everything worked ok (except hdspmixer 
as described above)
2) when I installed all 1.0.8 packages hdsploader failed
3) when I installed all 1.0.7 drivers with *only* alsa-lib being 1.0.8, 
everything was still fine.
4) when I installed all 1.0.7 drivers with *only* alsa-lib and hdsploader 
being 1.0.8, everything was still fine
5) when I installed 1.0.8 drivers in addition to 1.0.8 libs (everything else, 
tools, oss, utils 'n' stuff remained 1.0.7) the hdsploader failed.

This leads me to believe that the problem associated with hdsploader failing 
on 1.0.8 has to do specifically with the hdsp driver as that is the only 
thing that changed between points 3, 4, and 5 (ok, obviously my other sound 
driver for the built-in card also changed, as well as the driver for virmidi 
that I use but I seriously doubt that they had anything to do with it).

For the record, I use heavily updated mdk 10.0 community, aforementioned 2.6.7 
kernel with patches, Xorg 6.7 on a mobile  AMD64 notebook running 32-bit 
version of Linux, and here's my (ugly) /etc/modprobe.conf:

alias eth0 via-rhine
alias wlan0 ndiswrapper
alias char-major-116-* snd
alias char-major-14-* soundcore
alias snd-card-0 snd-via82xx
options snd-via82xx index=0
#alias snd-card-1 snd-hdsp
options snd-hdsp index=1
alias snd-card-2 snd-virmidi
options snd-virmidi index=2
alias sound-slot-0 snd-card-0
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss
#alias sound-slot-1 snd-hdsp
#alias sound-service-1-0 snd-mixer-oss
#alias sound-service-1-1 snd-seq-oss
#alias sound-service-1-3 snd-pcm-oss
#alias sound-service-1-8 snd-seq-oss
#alias sound-service-1-12 snd-pcm-oss
alias sound-slot-2 snd-card-2
alias sound-service-1-1 snd-seq-oss
alias sound-service-1-8 snd-seq-oss
install processor /sbin/modprobe powernow-k8; /sbin/modprobe --ignore-install 
processor
remove processor /sbin/modprobe -r --ignore-remove processor && /sbin/modprobe 
-r powernow-k8
install scsi_hostadapter /sbin/modprobe imm; /sbin/modprobe ppa; /bin/true
#install snd-hdsp /sbin/modprobe --first-time --ignore-install snd-hdsp && 
{ /sbin/modprobe snd-pcm-oss; /bin/true; }
install snd-via82xx /sbin/modprobe --first-time --ignore-install snd-via82xx 
&& { /sbin/modprobe snd-pcm-oss; /bin/true; }
install snd-hdsp /sbin/modprobe --ignore-install snd-hdsp && 
{ /usr/bin/autohdsploader; }
install usb-interface /sbin/modprobe usb-uhci; /sbin/modprobe 
ehci-hcd; /bin/true
remove snd-hdsp { /sbin/modprobe -r snd-pcm-oss; } ; /sbin/modprobe -r 
--first-time --ignore-remove snd-hdsp
remove snd-via82xx { /sbin/modprobe -r snd-pcm-oss; } ; /sbin/modprobe -r 
--first-time --ignore-remove snd-via82xx

(I know that the aliases are not any more necessary, but I've been too lazy to 
deal with that part as of yet).

Any help in this matter would be greatly appreciated!

Best wishes,

Ico


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
