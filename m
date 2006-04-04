From: "Leif Harald Lied" <l@hlied.com>
Subject: snd-bt78x
Date: Tue, 4 Apr 2006 15:45:48 +0200
Message-ID: <65501ea70604040645t67276d6fy26efebc2d6f64d00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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
To: alsa-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

As the alsa manual, and the Bt87x.txt in kernel 2.6.16.1 says, I send
this as the manual says I should do.

I have a Pinnacle PCTV Studio PRO (pal, europeian version), witch
don't get installed with the snd-bt87x module unless I specify the
load_all=3D1 option. The driver loads ok with load_all=3D1, but so far I
have not succeded getting some audio out of the card with this module,
but it looks like I can record, but there is no sound coming out. A
closer look at the card reveals that the Conexant Fusion 878A chip at
pin 100, 98 and 94 (TV sound input from TV tuner, FM sound input from
FM tuner and MIC/line input) are not connected. So the card has to be
modified to use the snd-bt87x module.

I have not yet tried to modify the board, but will in near future try
that. Hope that my future modifications will make the snd-bt87x work
at the end.

If I succeed with my modification, and there is someone wanting to
know how I did it, I will write a article of the modification.

>From kernel this is what I get without specifying load_all=3D1:
bt878_probe: card id=3D[0x1211bd], Unknown card.

lspci -v:
01:0a.1 Multimedia controller: Brooktree Corporation Bt878 Audio
Capture (rev 11)
        Subsystem: Pinnacle Systems Inc. PCTV pro (TV + FM stereo
receiver, audio section)
        Flags: medium devsel, IRQ 18
        Memory at d4001000 (32-bit, prefetchable) [size=3D4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2

lspci -vn:
01:0a.1 Class 0480: 109e:0878 (rev 11)
        Subsystem: 11bd:0012
        Flags: medium devsel, IRQ 18
        Memory at d4001000 (32-bit, prefetchable) [size=3D4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2


best regard
Leif Harald Lied


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
