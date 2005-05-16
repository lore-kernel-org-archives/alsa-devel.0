From: "John O'Donnell" <johnod@covad.net>
Subject: made the jump from 0.9.0rc1 (2.4.29) to 1.0.8 (2.6.11.9)
Date: Mon, 16 May 2005 01:59:45 -0400
Message-ID: <428836D1.6060603@covad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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

OK I had a good working 0.9.0rc1 (2.4.29) for years.

I have moved on because of some software requirements.

I have no sound now.

Clean 2.6.11.9 with Slackware 10.1+

modules load

root@mrlinux:~# lsmod
Module                  Size  Used by
nvidia               3916220  12
snd_pcm_oss            48832  0
snd_mixer_oss          17600  1 snd_pcm_oss
snd_via82xx            22688  0
snd_trident            39204  0
snd_ac97_codec         73440  2 snd_via82xx,snd_trident
snd_pcm                82760  4 
snd_pcm_oss,snd_via82xx,snd_trident,snd_ac97_codec
snd_timer              22020  1 snd_pcm
snd_page_alloc          7652  3 snd_via82xx,snd_trident,snd_pcm
snd_util_mem            3296  1 snd_trident
snd_mpu401_uart         6496  2 snd_via82xx,snd_trident
snd_rawmidi            20544  1 snd_mpu401_uart
snd_seq_device          7148  2 snd_trident,snd_rawmidi
snd                    46756  10 
snd_pcm_oss,snd_mixer_oss,snd_via82xx,snd_trident,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore               7552  1 snd
agpgart                28808  1 nvidia
vmnet                  27460  12
vmmon                 104108  0
root@mrlinux:~#

no kernel warnings in dmesg

root@mrlinux:~# cat /proc/interrupts
            CPU0
   0:     473743          XT-PIC  timer
   1:        952          XT-PIC  i8042
   2:          0          XT-PIC  cascade
   4:          7          XT-PIC  serial
   7:          0          XT-PIC  parport0
   8:          1          XT-PIC  rtc
   9:          0          XT-PIC  Trident Audio
  10:       3785          XT-PIC  ide2, ide3, uhci_hcd, uhci_hcd
  11:      48523          XT-PIC  aic7xxx, eth0, VIA686A, nvidia
  12:      25161          XT-PIC  i8042
  14:         13          XT-PIC  ide0
  15:       9679          XT-PIC  ide1
NMI:          0
ERR:          0
root@mrlinux:~#


root@mrlinux:~# alsamixer

alsamixer: function snd_ctl_open failed for default: No such file or 
directory
root@mrlinux:~#

I have compiled up all the 1.0.8 drivers, libs, oss, utils

tell me what im doing wrong please....

root@mrlinux:~# alsamixer --help
alsamixer: invalid option -- -
AlsaMixer v1.0.8
Usage: alsamixer [-h] [-c <card: 0...7>] [-D <mixer device>] [-g] [-s] 
[-V <view>]


-- 
=== Never ask a geek why, just nod your head and slowly back away.===
+================================+==================================+
|  John O'Donnell                |                                  |
|  (Sr. Systems Engineer,        |     http://juanisan.homeip.net   |
|  Net Admin, Webmaster, etc.)   |     E-Mail: johnod@covad.net     |
+================================+==================================+


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
