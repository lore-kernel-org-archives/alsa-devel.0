From: Ovidiu Bivolaru <obivolaru@gmail.com>
Subject: jetway card snd-bt87x
Date: Tue, 12 Dec 2006 02:37:04 +0200
Message-ID: <457DF9B0.8030403@gmail.com>
Reply-To: obivolaru@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

 I'm using a Jetway tuner card (aka Wayjet WT-951TF/BK). It has a 
TPI8PSB02P tuner chipset and Conexant 878a chipset for audio capture 
(bttv module options: card=78 tuner=28).
lspci output:
00:0c.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
Capture (rev 11)
00:0c.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture 
(rev 11)

 For module snd-bt87x, I'm using the following options:
alias snd-card-1 snd-bt87x
alias sound-slot-1 snd-bt87x
alias sound-service-1-0 snd-mixer-oss
alias sound-service-1-1 snd-seq-oss
alias sound-service-1-3 snd-pcm-oss
alias sound-service-1-8 snd-seq-oss
alias sound-service-1-12 snd-pcm-oss
options snd-card-1 load_all=1 enable=1 index=1
options snd-card-0 index=0 # for snd-via82xx
 
The module would load successfully, but I have no volume for Capture 
device (only mute/unmute) when using: alsamixer -c 1.
dmesg:
unknown card 0x878-0x00:0x00, using default rate 32000
please mail id, board name, and, if it works, the correct digital_rate 
option to <alsa-devel@lists.sf.net>

ls -la /dev/sound/
total 0
drwxr-xr-x  2 root root     220 Dec 12 02:00 .
drwxr-xr-x 17 root root   13440 Dec 12 02:01 ..
crw-rw----  1 root audio 14, 28 Dec 12 02:00 adsp1
crw-rw----  1 root audio 14,  4 Dec 12 02:00 audio
crw-rw----  1 root audio 14, 20 Dec 12 02:00 audio1
crw-rw----  1 root audio 14,  3 Dec 12 02:00 dsp
crw-rw----  1 root audio 14, 19 Dec 12 02:00 dsp1
crw-rw----  1 root audio 14,  0 Dec 12 02:00 mixer
crw-rw----  1 root audio 14, 16 Dec 12 02:00 mixer1
crw-rw----  1 root audio 14,  1 Dec 12 02:00 sequencer
crw-rw----  1 root audio 14,  8 Dec 12 02:00 sequencer2

cat /proc/asound/cards
 0 [rev50          ]: VIA686A - VIA 82C686A/B rev50
                      VIA 82C686A/B rev50 with ICE1232 at 0xcc00, irq 11
 1 [Bt878          ]: Bt87x - Brooktree Bt878
                      Brooktree Bt878 at 0xd8002000, irq 5


Btw, I'm using Gentoo Linux, kernel 2.6.17.13.

I'm trying to get digital sound capture working for mythtv audio capture 
and my guess is that snd-bt87x is not working correctly with my card.
I have tried for Audio Capture device: /dev/dsp1 and /dev/adsp1 and I 
only hear some beeps while playing with mythfrontend (using /dev/dsp).
For tvtime, I can hear sound fine through: /dev/mixer:line.

Can someone help me with this problem ? Thank you!


Regards,
Ovidiu

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
