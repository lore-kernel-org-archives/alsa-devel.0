From: Sasha Khapyorsky <sashak@smlink.com>
Subject: Re: Re: au88x0 modem
Date: Thu, 22 Sep 2005 01:03:05 +0300
Message-ID: <20050921220305.GA22110@sashak.softier1.local>
References: <20050913174930.GA5816@titan.lahn.de>
 <4327DA14.3040205@netvigator.com>
 <20050914205608.GD14657@sashak.softier1.local>
 <20050915091158.GA7314@titan.lahn.de> <20050915092155.GA7328@titan.lahn.de>
 <20050915143533.GB23218@sashak.softier1.local>
 <20050915204345.GC27700@sashak.softier1.local>
 <20050916084653.GB524@titan.lahn.de> <20050916182524.GE17864@tecr>
 <20050919150025.GA3058@titan.lahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20050919150025.GA3058@titan.lahn.de>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Cc: alsa-devel@lists.sourceforge.net, Raymond <rayau@netvigator.com>, openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org

On 17:00 Mon 19 Sep     , Philipp Matthias Hahn wrote:
> Hello!
> 
> On Fri, Sep 16, 2005 at 09:25:24PM +0300, Sasha Khapyorsky wrote:
> > On 10:46 Fri 16 Sep     , Philipp Matthias Hahn wrote:
> > > > 2. GPIO
> > > >
> > > > Probably we are lucky and au88x0 implements it in AC97 way, try to write
> > > > mc97 registers via /proc (for this you need build drivers in debug mode,
> > > > '--with-debug=detect' is ok):
> > > >  # echo 42 ffff > /proc/asound/card0/codec97#0/mc97#1-1+regs
> > > >  # echo 42 0 > /proc/asound/card0/codec97#0/mc97#1-1+regs
> > > >  # echo 54 1 > /proc/asound/card0/codec97#0/mc97#1-1+regs
> > >
> > > Sorry, I did echo those values and read mc97#1-1+regs, but no values
> > > changed.
> >
> > Even 0x42 register? Are you with debug version of drivers

Ok, 0x42 and 0x44 are my mistake, sorry (need to look in datasheet from
time to time), Line level register is 0x46.
Try manual initialization (whole codec):

 # echo 3c 0 > /proc/asound/card0/codec97#0/mc97#1-1+regs
 # echo 40 1f40 > /proc/asound/card0/codec97#0/mc97#1-1+regs
 # echo 3e 0 > /proc/asound/card0/codec97#0/mc97#1-1+regs
 # echo 46 0 > /proc/asound/card0/codec97#0/mc97#1-1+regs

, then try to change 0x46 register (look at dmesg):

 # echo 46 ffff > /proc/asound/card0/codec97#0/mc97#1-1+regs
 # echo 46 0 > /proc/asound/card0/codec97#0/mc97#1-1+regs

if it will not work than we have very strange behaviour there.
If it works try to change 0x54 register (this may work or not).

> > ( ./configure --with-debug=detect )?
> 
> Sorry, yes. The is ALSA from linux-2.6.13.2 with CONFIG_SND_DEBUG=y,
> which is equivalent to --with-debug=detect.

I think that CONFIG_SND_DEBUG_DETECT=y is equivalent, but registers
should writeble via proc with CONFIG_SND_DEBUG=y too.

Sasha.

> I attached a new dmesg with an additional patch, which prints out every
> vortex_{read,write}.
> 
> ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
> PCI: setting IRQ 10 as level-triggered
> ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
> Vortex: init.... <3>ALSA sound/core/control.c:324: control 3:0:0:Playback PCM advanced processing:0 is already present
> done.
> vortex_codec_read  0 7c :8384
> vortex_codec_read  0 7e :7605
> vortex_codec_write 0 00 :0000
> vortex_codec_read  0 00 :6940
> vortex_codec_read  0 7c :8384
> vortex_codec_read  0 7e :7605
> vortex_codec_write 0 1c :8a05
> vortex_codec_read  0 1c :8a05
> vortex_codec_read  0 7c :8384
> vortex_codec_read  0 7e :7605
> vortex_codec_write 0 1c :8a06
> vortex_codec_read  0 1c :8a06
> vortex_codec_read  0 00 :6940
> vortex_codec_read  0 28 :0000
> vortex_codec_write 0 26 :0000
> vortex_codec_write 0 00 :0000
> vortex_codec_write 0 26 :0000
> vortex_codec_write 0 20 :0000
> vortex_codec_read  0 26 :000f
> vortex_codec_read  0 02 :8000
> vortex_codec_read  0 02 :8000
> vortex_codec_write 0 02 :0000
> vortex_codec_read  0 02 :0000
> vortex_codec_write 0 02 :8000
> vortex_codec_read  0 02 :8000
> vortex_codec_write 0 02 :8000
> vortex_codec_write 0 02 :a0a0
> vortex_codec_read  0 02 :9f9f
> vortex_codec_read  0 02 :9f1f
> vortex_codec_write 0 02 :9090
> vortex_codec_read  0 02 :9090
> vortex_codec_read  0 02 :9010
> vortex_codec_read  0 02 :9010
> vortex_codec_write 0 02 :9f1f
> vortex_codec_read  0 06 :9f00
> vortex_codec_read  0 06 :8000
> vortex_codec_write 0 06 :0000
> vortex_codec_read  0 06 :0000
> vortex_codec_write 0 06 :8000
> vortex_codec_read  0 06 :8000
> vortex_codec_write 0 06 :8000
> vortex_codec_write 0 06 :a0a0
> vortex_codec_read  0 06 :a09f
> vortex_codec_read  0 06 :801f
> vortex_codec_write 0 06 :9090
> vortex_codec_read  0 06 :9090
> vortex_codec_read  0 06 :8010
> vortex_codec_write 0 06 :8181
> vortex_codec_read  0 06 :8181
> vortex_codec_read  0 06 :8001
> vortex_codec_read  0 06 :8001
> vortex_codec_write 0 06 :801f
> vortex_codec_read  0 0a :0000
> vortex_codec_write 0 0a :8000
> vortex_codec_read  0 0a :8000
> vortex_codec_read  0 0a :8000
> vortex_codec_write 0 0a :801e
> vortex_codec_read  0 0c :8008
> vortex_codec_read  0 0c :8008
> vortex_codec_write 0 0c :0008
> vortex_codec_read  0 0c :0008
> vortex_codec_write 0 0c :8008
> vortex_codec_read  0 0c :8008
> vortex_codec_write 0 0c :8008
> vortex_codec_write 0 0c :a0a0
> vortex_codec_read  0 0c :8000
> vortex_codec_read  0 0c :8000
> vortex_codec_write 0 0c :9090
> vortex_codec_read  0 0c :8010
> vortex_codec_read  0 0c :8010
> vortex_codec_write 0 0c :8181
> vortex_codec_read  0 0c :8001
> vortex_codec_read  0 0c :8001
> vortex_codec_read  0 0c :8001
> vortex_codec_write 0 0c :801f
> vortex_codec_read  0 0e :8008
> vortex_codec_read  0 0e :8008
> vortex_codec_write 0 0e :0008
> vortex_codec_read  0 0e :0008
> vortex_codec_write 0 0e :8008
> vortex_codec_read  0 0e :8008
> vortex_codec_write 0 0e :8008
> vortex_codec_write 0 0e :a0a0
> vortex_codec_read  0 0e :a0a0
> vortex_codec_read  0 0e :8000
> vortex_codec_write 0 0e :9090
> vortex_codec_read  0 0e :9090
> vortex_codec_read  0 0e :8010
> vortex_codec_write 0 0e :8181
> vortex_codec_read  0 0e :8181
> vortex_codec_read  0 0e :8001
> vortex_codec_read  0 0e :8001
> vortex_codec_write 0 0e :801f
> vortex_codec_read  0 10 :8808
> vortex_codec_read  0 10 :8808
> vortex_codec_write 0 10 :0808
> vortex_codec_read  0 10 :0808
> vortex_codec_write 0 10 :8808
> vortex_codec_read  0 10 :8808
> vortex_codec_write 0 10 :8808
> vortex_codec_write 0 10 :a0a0
> vortex_codec_read  0 10 :a0a0
> vortex_codec_read  0 10 :8000
> vortex_codec_write 0 10 :9090
> vortex_codec_read  0 10 :9090
> vortex_codec_read  0 10 :9010
> vortex_codec_read  0 10 :9010
> vortex_codec_write 0 10 :9f1f
> vortex_codec_read  0 12 :8808
> vortex_codec_read  0 12 :8808
> vortex_codec_write 0 12 :0808
> vortex_codec_read  0 12 :0808
> vortex_codec_write 0 12 :8808
> vortex_codec_read  0 12 :8808
> vortex_codec_write 0 12 :8808
> vortex_codec_write 0 12 :a0a0
> vortex_codec_read  0 12 :a0a0
> vortex_codec_read  0 12 :8000
> vortex_codec_write 0 12 :9090
> vortex_codec_read  0 12 :9090
> vortex_codec_read  0 12 :9010
> vortex_codec_read  0 12 :9010
> vortex_codec_write 0 12 :9f1f
> vortex_codec_read  0 14 :8808
> vortex_codec_read  0 14 :8808
> vortex_codec_write 0 14 :0808
> vortex_codec_read  0 14 :0808
> vortex_codec_write 0 14 :8808
> vortex_codec_read  0 14 :8808
> vortex_codec_write 0 14 :8808
> vortex_codec_write 0 14 :a0a0
> vortex_codec_read  0 14 :a0a0
> vortex_codec_read  0 14 :8000
> vortex_codec_write 0 14 :9090
> vortex_codec_read  0 14 :9090
> vortex_codec_read  0 14 :9010
> vortex_codec_read  0 14 :9010
> vortex_codec_write 0 14 :9f1f
> vortex_codec_read  0 16 :8808
> vortex_codec_read  0 16 :8808
> vortex_codec_write 0 16 :0808
> vortex_codec_read  0 16 :0808
> vortex_codec_write 0 16 :8808
> vortex_codec_read  0 16 :8808
> vortex_codec_write 0 16 :8808
> vortex_codec_write 0 16 :a0a0
> vortex_codec_read  0 16 :a0a0
> vortex_codec_read  0 16 :8000
> vortex_codec_write 0 16 :9090
> vortex_codec_read  0 16 :9090
> vortex_codec_read  0 16 :9010
> vortex_codec_read  0 16 :9010
> vortex_codec_write 0 16 :9f1f
> vortex_codec_read  0 18 :8808
> vortex_codec_write 0 18 :0808
> vortex_codec_read  0 18 :0808
> vortex_codec_write 0 18 :8808
> vortex_codec_read  0 18 :8808
> vortex_codec_write 0 18 :8808
> vortex_codec_write 0 18 :a0a0
> vortex_codec_read  0 18 :a0a0
> vortex_codec_read  0 18 :8000
> vortex_codec_write 0 18 :9090
> vortex_codec_read  0 18 :9090
> vortex_codec_read  0 18 :9010
> vortex_codec_read  0 18 :9010
> vortex_codec_write 0 18 :9f1f
> vortex_codec_read  0 1c :9010
> vortex_codec_write 0 1c :1010
> vortex_codec_read  0 1c :1010
> vortex_codec_write 0 1c :9010
> vortex_codec_read  0 1c :9010
> vortex_codec_write 0 1c :9010
> vortex_codec_write 0 1a :0000
> vortex_codec_write 0 1c :0000
> vortex_codec_read  0 20 :0000
> vortex_codec_write 0 20 :8000
> vortex_codec_read  0 20 :8000
> vortex_codec_write 0 20 :0000
> vortex_codec_read  0 20 :0000
> vortex_codec_write 0 20 :2000
> vortex_codec_read  0 20 :2000
> vortex_codec_write 0 20 :0000
> vortex_codec_read  0 20 :0000
> vortex_codec_write 0 20 :0200
> vortex_codec_read  0 20 :0200
> vortex_codec_write 0 20 :0000
> vortex_codec_read  0 20 :0000
> vortex_codec_write 0 20 :0100
> vortex_codec_read  0 20 :0100
> vortex_codec_write 0 20 :0000
> vortex_codec_read  0 22 :0000
> vortex_codec_write 0 22 :0707
> vortex_codec_read  0 22 :0707
> vortex_codec_write 0 22 :0000
> vortex_codec_read  0 26 :000f
> vortex_codec_write 0 26 :800f
> vortex_codec_read  0 26 :800f
> vortex_codec_write 0 26 :000f
> vortex_codec_read  0 2a :ffff
> vortex_codec_write 0 2a :ffff
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 00 :0000
> vortex_codec_write 1 3c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a05
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 00 :0000
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_read  1 3c :4001
> vortex_codec_read  1 7c :5349
> vortex_codec_read  1 7e :4c26
> vortex_codec_write 1 1c :8a06
> vortex_codec_read  1 1c :0000
> vortex_codec_read  1 3c :4001
> vortex_codec_write 1 40 :1f40
> vortex_codec_write 1 3e :0000
> vortex_codec_write 1 3e :0000
> vortex_codec_read  1 3e :f000
> vortex_codec_read  1 3e :f00f
> vortex_codec_write 1 5c :f210
> vortex_codec_write 1 68 :0000
> vortex_codec_write 1 4c :fffe
> vortex_codec_write 1 4e :fffe
> vortex_codec_write 1 50 :ffff
> vortex_codec_write 1 52 :0000
> vortex_codec_write 1 56 :0000
> vortex_codec_read  1 2a :0000
> vortex_codec_write 1 2a :0000
> vortex: IRQ reg error
> vortex: IRQ reg error
> vortex: IRQ reg error
> vortex_codec_write 0 02 :1f1f
> vortex_codec_write 0 02 :0303
> vortex_codec_write 0 06 :8000
> vortex_codec_write 0 0e :8000
> vortex_codec_write 0 18 :1f1f
> vortex_codec_write 0 18 :0707
> vortex_codec_write 0 22 :0800
> vortex_codec_write 0 22 :0808
> vortex_codec_read  1 54 :0000
> vortex_codec_write 1 54 :0001
> 
> Doing an "echo 44 ff > ...mc97$1-1+regs" prints out the expected
> 	vortex_codec_write 1 44 :ffff
> but the following read returns "0000"
> 
> > > > , if value is changed (we are lucky then), you may connect line and
> > > > isten 'Hook-Off' clicks (when 0x54 is switched between 0 and 1) with
> > > > parallel phone.
> > >
> > > I don't have the line cable with me at the moment and need to find a
> > > analog telephone circuit until I can test that
> >
> > If values are not changed there will nothing, don't try.
> >
> > BTW, stupid question, if you don't have analog telephone line why you
> > need modem?
> 
> I asked for modem support a long time ago. The recent request for modem
> support was from another person. I only entered this thread, after I was
> cc-ed to help with adding modem support on Aurel by a developer.
> 
> I don't need the modem for daily work, but it would still be very nice
> to have modem support under linux, especially when I travel.
> 
> BYtE
> Philipp
> -- 
>   / /  (_)__  __ ____  __ Philipp Hahn
>  / /__/ / _ \/ // /\ \/ /
> /____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de
> 


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
