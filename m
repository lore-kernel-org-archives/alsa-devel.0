From: Orm Finnendahl <finnendahl@folkwang-hochschule.de>
Subject: installing alsa
Date: Tue, 3 Dec 2002 11:11:18 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021203101118.GA979@finnendahl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

trying to install last CVS of alsa on a new Athlon with Debian
(standard 2.4.18-bf2.4 kernel) and a RME hdsp makes the drivers load
and initialize o.k. but starting alsamixer gives the following error:

alsamixer: function snd_ctl_open failed for default: No such file or directory

Unloading and reloading of snd-hdsp doesn't help.

lsmod yields:

Module                  Size  Used by    Tainted: P  
snd-hdsp              214692   0  (unused)
snd-hammerfall-mem      1760   2  [snd-hdsp]
snd-pcm                50848   0  [snd-hdsp]
snd-timer               9952   0  [snd-pcm]
snd-rawmidi            11680   0  [snd-hdsp]
snd-seq-device          3632   0  [snd-rawmidi]
snd                    23528   0  [snd-hdsp snd-pcm snd-timer snd-rawmidi snd-se
q-device]
soundcore               3236   4  [snd]
agpgart                29824   3  (autoclean)
NVdriver             1065408  10  (autoclean)
appletalk              18988  13  (autoclean)
ppp_deflate            38944   0  (autoclean)
bsd_comp                3936   0  (autoclean)
ppp_async               6464   1  (autoclean)
ppp_generic            18728   3  (autoclean) [ppp_deflate bsd_comp ppp_async]
slhc                    4432   0  (autoclean) [ppp_generic]
ipt_MASQUERADE          1216   2  (autoclean)
iptable_nat            12660   1  (autoclean) [ipt_MASQUERADE]
ip_conntrack           12684   1  (autoclean) [ipt_MASQUERADE iptable_nat]
ip_tables              10432   4  [ipt_MASQUERADE iptable_nat]
keybdev                 1664   0  (unused)
usbkbd                  2848   0  (unused)
input                   3072   0  [keybdev usbkbd]
usb-ohci               17472   0  (unused)
usbcore                48032   0  [usbkbd usb-ohci]

Do I have to create any symlinks in /dev/ or what am I missing?

--
Orm



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
