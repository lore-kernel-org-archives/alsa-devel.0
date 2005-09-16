From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Subject: Re: au88x0 modem
Date: Fri, 16 Sep 2005 16:42:47 +0200
Message-ID: <20050916144247.GA2425@titan.lahn.de>
References: <4327DA14.3040205@netvigator.com> <20050914205608.GD14657@sashak.softier1.local> <20050915091158.GA7314@titan.lahn.de> <20050915092155.GA7328@titan.lahn.de> <20050915143533.GB23218@sashak.softier1.local> <20050915204345.GC27700@sashak.softier1.local> <20050916084653.GB524@titan.lahn.de> <432A8887.4020808@netvigator.com> <20050916103604.GA3168@titan.lahn.de> <432AB4B1.1050808@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <432AB4B1.1050808@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Raymond <rayau@netvigator.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello!

On Fri, Sep 16, 2005 at 08:04:01PM +0800, Raymond wrote:
> Add printk to dump the ac97 read/write to system log

I had to hand-play with the previosu patches, so for reference, this is
ALSA from linux-2.6.13.1 with
http://corellon.svs.informatik.uni-oldenburg.de/~pmhahn/au8810-modem.patch
applied. Looks like I lost the normal ac97#1-1* files in
/proc/asound/card0/codec97#0:
	$ ls /proc/asound/card0/codec97#0/
	mc97#1-1  mc97#1-1+regs

ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
Vortex: init.... <6>VORTEX_CTRL : 00303260
ALSA sound/core/control.c:324: control 3:0:0:Playback PCM advanced processing:0 is already present
done.
vortex_codec_read  0 7c :8384
vortex_codec_read  0 7e :7605
vortex_codec_write 0 00 :0000
vortex_codec_read  0 00 :6940
vortex_codec_read  0 7c :8384
vortex_codec_read  0 7e :7605
vortex_codec_write 0 1c :8a05
vortex_codec_read  0 1c :8a05
vortex_codec_read  0 7c :8384
vortex_codec_read  0 7e :7605
vortex_codec_write 0 1c :8a06
vortex_codec_read  0 1c :8a06
vortex_codec_read  0 00 :6940
vortex_codec_read  0 28 :0000
vortex_codec_write 0 26 :0000
vortex_codec_write 0 00 :0000
vortex_codec_write 0 26 :0000
vortex_codec_write 0 20 :0000
vortex_codec_read  0 26 :000f
vortex_codec_read  0 02 :8000
vortex_codec_read  0 02 :8000
vortex_codec_write 0 02 :0000
vortex_codec_read  0 02 :0000
vortex_codec_write 0 02 :8000
vortex_codec_read  0 02 :8000
vortex_codec_write 0 02 :8000
vortex_codec_write 0 02 :a0a0
vortex_codec_read  0 02 :9f9f
vortex_codec_read  0 02 :9f1f
vortex_codec_write 0 02 :9090
vortex_codec_read  0 02 :9090
vortex_codec_read  0 02 :9010
vortex_codec_read  0 02 :9010
vortex_codec_write 0 02 :9f1f
vortex_codec_read  0 06 :9f00
vortex_codec_read  0 06 :8000
vortex_codec_write 0 06 :0000
vortex_codec_read  0 06 :0000
vortex_codec_write 0 06 :8000
vortex_codec_read  0 06 :8000
vortex_codec_write 0 06 :8000
vortex_codec_write 0 06 :a0a0
vortex_codec_read  0 06 :a09f
vortex_codec_read  0 06 :801f
vortex_codec_write 0 06 :9090
vortex_codec_read  0 06 :9090
vortex_codec_read  0 06 :8010
vortex_codec_write 0 06 :8181
vortex_codec_read  0 06 :8181
vortex_codec_read  0 06 :8001
vortex_codec_read  0 06 :8001
vortex_codec_write 0 06 :801f
vortex_codec_read  0 0a :0000
vortex_codec_write 0 0a :8000
vortex_codec_read  0 0a :8000
vortex_codec_read  0 0a :8000
vortex_codec_write 0 0a :801e
vortex_codec_read  0 0c :8008
vortex_codec_read  0 0c :8008
vortex_codec_write 0 0c :0008
vortex_codec_read  0 0c :0008
vortex_codec_write 0 0c :8008
vortex_codec_read  0 0c :8008
vortex_codec_write 0 0c :8008
vortex_codec_write 0 0c :a0a0
vortex_codec_read  0 0c :8000
vortex_codec_read  0 0c :8000
vortex_codec_write 0 0c :9090
vortex_codec_read  0 0c :8010
vortex_codec_read  0 0c :8010
vortex_codec_write 0 0c :8181
vortex_codec_read  0 0c :8001
vortex_codec_read  0 0c :8001
vortex_codec_read  0 0c :8001
vortex_codec_write 0 0c :801f
vortex_codec_read  0 0e :8008
vortex_codec_read  0 0e :8008
vortex_codec_write 0 0e :0008
vortex_codec_read  0 0e :0008
vortex_codec_write 0 0e :8008
vortex_codec_read  0 0e :8008
vortex_codec_write 0 0e :8008
vortex_codec_write 0 0e :a0a0
vortex_codec_read  0 0e :a0a0
vortex_codec_read  0 0e :8000
vortex_codec_write 0 0e :9090
vortex_codec_read  0 0e :9090
vortex_codec_read  0 0e :8010
vortex_codec_write 0 0e :8181
vortex_codec_read  0 0e :8181
vortex_codec_read  0 0e :8001
vortex_codec_read  0 0e :8001
vortex_codec_write 0 0e :801f
vortex_codec_read  0 10 :8808
vortex_codec_read  0 10 :8808
vortex_codec_write 0 10 :0808
vortex_codec_read  0 10 :0808
vortex_codec_write 0 10 :8808
vortex_codec_read  0 10 :8808
vortex_codec_write 0 10 :8808
vortex_codec_write 0 10 :a0a0
vortex_codec_read  0 10 :a0a0
vortex_codec_read  0 10 :8000
vortex_codec_write 0 10 :9090
vortex_codec_read  0 10 :9090
vortex_codec_read  0 10 :9010
vortex_codec_read  0 10 :9010
vortex_codec_write 0 10 :9f1f
vortex_codec_read  0 12 :8808
vortex_codec_read  0 12 :8808
vortex_codec_write 0 12 :0808
vortex_codec_read  0 12 :0808
vortex_codec_write 0 12 :8808
vortex_codec_read  0 12 :8808
vortex_codec_write 0 12 :8808
vortex_codec_write 0 12 :a0a0
vortex_codec_read  0 12 :a0a0
vortex_codec_read  0 12 :8000
vortex_codec_write 0 12 :9090
vortex_codec_read  0 12 :9090
vortex_codec_read  0 12 :9010
vortex_codec_read  0 12 :9010
vortex_codec_write 0 12 :9f1f
vortex_codec_read  0 14 :8808
vortex_codec_read  0 14 :8808
vortex_codec_write 0 14 :0808
vortex_codec_read  0 14 :0808
vortex_codec_write 0 14 :8808
vortex_codec_read  0 14 :8808
vortex_codec_write 0 14 :8808
vortex_codec_write 0 14 :a0a0
vortex_codec_read  0 14 :a0a0
vortex_codec_read  0 14 :8000
vortex_codec_write 0 14 :9090
vortex_codec_read  0 14 :9090
vortex_codec_read  0 14 :9010
vortex_codec_read  0 14 :9010
vortex_codec_write 0 14 :9f1f
vortex_codec_read  0 16 :8808
vortex_codec_read  0 16 :8808
vortex_codec_write 0 16 :0808
vortex_codec_read  0 16 :0808
vortex_codec_write 0 16 :8808
vortex_codec_read  0 16 :8808
vortex_codec_write 0 16 :8808
vortex_codec_write 0 16 :a0a0
vortex_codec_read  0 16 :a0a0
vortex_codec_read  0 16 :8000
vortex_codec_write 0 16 :9090
vortex_codec_read  0 16 :9090
vortex_codec_read  0 16 :9010
vortex_codec_read  0 16 :9010
vortex_codec_write 0 16 :9f1f
vortex_codec_read  0 18 :8808
vortex_codec_write 0 18 :0808
vortex_codec_read  0 18 :0808
vortex_codec_write 0 18 :8808
vortex_codec_read  0 18 :8808
vortex_codec_write 0 18 :8808
vortex_codec_write 0 18 :a0a0
vortex_codec_read  0 18 :a0a0
vortex_codec_read  0 18 :8000
vortex_codec_write 0 18 :9090
vortex_codec_read  0 18 :9090
vortex_codec_read  0 18 :9010
vortex_codec_read  0 18 :9010
vortex_codec_write 0 18 :9f1f
vortex_codec_read  0 1c :9010
vortex_codec_write 0 1c :1010
vortex_codec_read  0 1c :1010
vortex_codec_write 0 1c :9010
vortex_codec_read  0 1c :9010
vortex_codec_write 0 1c :9010
vortex_codec_write 0 1a :0000
vortex_codec_write 0 1c :0000
vortex_codec_read  0 20 :0000
vortex_codec_write 0 20 :8000
vortex_codec_read  0 20 :8000
vortex_codec_write 0 20 :0000
vortex_codec_read  0 20 :0000
vortex_codec_write 0 20 :2000
vortex_codec_read  0 20 :2000
vortex_codec_write 0 20 :0000
vortex_codec_read  0 20 :0000
vortex_codec_write 0 20 :0200
vortex_codec_read  0 20 :0200
vortex_codec_write 0 20 :0000
vortex_codec_read  0 20 :0000
vortex_codec_write 0 20 :0100
vortex_codec_read  0 20 :0100
vortex_codec_write 0 20 :0000
vortex_codec_read  0 22 :0000
vortex_codec_write 0 22 :0707
vortex_codec_read  0 22 :0707
vortex_codec_write 0 22 :0000
vortex_codec_read  0 26 :000f
vortex_codec_write 0 26 :800f
vortex_codec_read  0 26 :800f
vortex_codec_write 0 26 :000f
vortex_codec_read  0 2a :ffff
vortex_codec_write 0 2a :ffff
vortex: IRQ reg error
vortex_codec_write 0 02 :1f1f
vortex_codec_write 0 02 :0303
vortex_codec_write 0 18 :1f1f
vortex_codec_write 0 18 :0707
vortex_codec_write 0 22 :0800
vortex_codec_write 0 22 :0808
vortex: IRQ reg error
vortex: IRQ reg error

One "IRQ reg error" appears always on load, the sound-card still works.

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
