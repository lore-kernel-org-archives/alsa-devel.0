From: Adam Tla/lka <atlka@pg.gda.pl>
Subject: Re: Re: The obsolence of OSS, Was: big smile
Date: Wed, 25 Feb 2004 12:20:21 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040225112021.GE8820@sunrise.pg.gda.pl>
References: <Pine.LNX.4.58.0402241536450.1883@pnote.perex-int.cz> <403BC832.4080404@gardena.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <403BC832.4080404@gardena.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 24, 2004 at 10:54:58PM +0100, Benno Senoner wrote:
> for those that are too lazy to browse the forums:
> 
> http://www.4front-tech.com/forum/viewtopic.php?t=25
> -----
> .... 
> far more advanced ???
> Ok I'd like see Ardour runnnig with multiple 24bit cards, all the 
> switches for hardware monitoring etc under OSS.
nice but many people just haven't this hardware and want to use
normal PCI sound cards or even matherboard build in codecs
and mix many applications PCM sound together, use MIDI (software
emulated or not) without need of special configuring of aplications.
VirtualMixer, InputMultiplexer and SoftMidi in OSS does things transparently.
Mixing is done in kernel space so there is no delays and clicks
while some disk activity get processor as occurs in ALSA mixing in lib
case. Test xmms with ALSA and dma plugin and try to open big tar.gz
file. We got buffer underrun and app freezes. Sometimes I can only do
kill -9 ;-). It depends on buffer and period sizes. Sometimes app
freezes completly and sometimes you can rebufer by pressing pause/play
buttons. Is it nice and accepted?? While useing java app under aoss
it gopes to hell if buffer underrun occures.
> 
> How about MIDI ? Where is OSS' midi router, is there an ossconnect 
> utility ? (of course this a sarcastic comment :) )
> 
should be done in the future ;-).
> 
> Only a fool would write a new linux audio app that does not use ALSA, 
> especially apps that need MIDI.
> Ok jackd will probably become the "audio interface" of choice, but jackd 
> using ALSA is more powerful than in the OSS case,
> (talking of pure PCM based apps, with PCM/MIDI apps the advantage is 
> even more apparent).
I don't know jackd in details but generally I don't want any additional 
suid daemon running in realtime priority in my system. Maybe if we need 
to pump sound streams through the net we need a daemon.
But normally kernel should manage devices (real or emulated)
so there is a consistent way of accessing and using them.
I have many normal users which want to browse the net, display flash
pages, java applets or use RealPlayer. All of them use OSS ;-).
 
> 
> Not to mention that most distros once they will ship kernel 2.6 they 
> will probably use ALSA as default because users
> are demanding multimedia features like MIDI, support of highend cards, 
OSS supports more cards then ALSA

> jackd support etc.
works with OSS too

> So this will slowly but surely render OSS totally obsolete. I'm sorry 
> but that's the truth that you cannot escape from.
Maybe but now functionalty of ALSA and just ease of use is not
so good to satisfy us. Mixing in lib is bad in my opinion and works nice
only if we have enough free CPU cycles. But we use many applications at
the same time compiling kernel, transfering data, looking in the
archives, doing backups etc.
 
> Just like Micosoft's share on the desktop will drop considerably over 
> time due to linux being more efficient and cheaper :-)
Not so fast :-(!!

Regards

-- 
Adam Tla/lka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group           ~~~~~~
Computer Center,  Gdansk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
