From: "Olivier Kaloudoff" <kalou@jose-paredes.com>
Subject: unable to use any output nor spdif out with cs46xx
Date: Sun, 20 Oct 2002 15:36:21 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <51510.193.249.73.108.1035120981.squirrel@www.jose-paredes.com>
References: <E183G6v-0007Vb-00@usw-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E183G6v-0007Vb-00@usw-sf-list1.sourceforge.net>
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


 Hi,


        I am using the following kernel, with CVS alsa from October 14,
2002... But I am unable to get no sound at all, after unmutting,
and putting the volumes to max with all outputs tried.

        I bought this card to get SPDIF in/out, too, because it was
reported to work in the Alsa Soundcard matrix ... but unfortunatelly it
does not.

        Any help ?
(following is the description of my hardware and kernel)

 Best Regards,
 Olivier Kaloudoff
 Saint Raphael, France
 French Riviera

cat /proc/pci

  Bus  0, device  15, function  0:
    Multimedia audio controller: Cirrus Logic CS 4614/22/24 [CrystalClear
SoundFusion Audio Accelerator] (rev 1).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=4.Max Lat=24.
      Non-prefetchable 32 bit memory at 0xfebfe000 [0xfebfefff].
      Non-prefetchable 32 bit memory at 0xfea00000 [0xfeafffff].


 [kalou@kalou kalou]$ uname -a
 Linux kalou.kalou.net 2.4.19-7mdkcustom #1 dim sep 29 21:34:47 CEST 2002
 i686 un
 known unknown GNU/Linux
 [kalou@kalou kalou]$ /sbin/lsmod
 Module                  Size  Used by    Not tainted
 nls_iso8859-1           2844   1 (autoclean)
 isofs                  25652   1 (autoclean)
 inflate_fs             17892   0 (autoclean) [isofs]
 cs46xx                 55600   0
 soundcore               3684   0 [cs46xx]
 ac97_codec              9928   0 [cs46xx]
 ppp_deflate            41024   1 (autoclean)
 bsd_comp                4344   0 (autoclean)
 binfmt_misc             5696   1
 nfsd                   66448   0 (autoclean)
 lockd                  46480   0 (autoclean) [nfsd]
 sunrpc                 60188   0 (autoclean) [nfsd lockd]
 ppp_async               7456   1
 ppp_generic            20032   3 [ppp_deflate bsd_comp ppp_async]
 slhc                    5072   1 [ppp_generic]
 af_packet              13000   0 (autoclean)
 ip_vs                  62008   0 (autoclean)
 ipchains               39656   0 (unused)
 ide-cd                 28648   0
 ide-scsi                8084   0
 keybdev                 1888   0 (unused)
 mousedev                4116   0 (unused)
 hid                    18244   0 (unused)
 usbmouse                2004   0 (unused)
 evdev                   4480   2
 wacom                   6132   0 (unused)
 usb-uhci               21676   0 (unused)
 usbcore                57952   1 [hid usbmouse wacom usb-uhci]
 rtc                     6560   0 (autoclean)
 [kalou@kalou kalou]$






-------------------------------------------------------
This sf.net email is sponsored by:
Access Your PC Securely with GoToMyPC. Try Free Now
https://www.gotomypc.com/s/OSND/DD
