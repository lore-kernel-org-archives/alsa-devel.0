From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: The obsolence of OSS, Was: big smile
Date: Wed, 25 Feb 2004 14:09:43 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0402251401030.10484@pnote.perex-int.cz>
References: <Pine.LNX.4.58.0402241536450.1883@pnote.perex-int.cz>
 <403BC832.4080404@gardena.net> <20040225112021.GE8820@sunrise.pg.gda.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040225112021.GE8820@sunrise.pg.gda.pl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adam Tla/lka <atlka@pg.gda.pl>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 25 Feb 2004, Adam Tla/lka wrote:

> On Tue, Feb 24, 2004 at 10:54:58PM +0100, Benno Senoner wrote:
> > for those that are too lazy to browse the forums:
> > 
> > http://www.4front-tech.com/forum/viewtopic.php?t=25
> > -----
> > .... 
> > far more advanced ???
> > Ok I'd like see Ardour runnnig with multiple 24bit cards, all the 
> > switches for hardware monitoring etc under OSS.
> nice but many people just haven't this hardware and want to use
> normal PCI sound cards or even matherboard build in codecs
> and mix many applications PCM sound together, use MIDI (software
> emulated or not) without need of special configuring of aplications.
> VirtualMixer, InputMultiplexer and SoftMidi in OSS does things transparently.
> Mixing is done in kernel space so there is no delays and clicks
> while some disk activity get processor as occurs in ALSA mixing in lib
> case. Test xmms with ALSA and dma plugin and try to open big tar.gz
> file. We got buffer underrun and app freezes. Sometimes I can only do
> kill -9 ;-). It depends on buffer and period sizes. Sometimes app

It has nothing to do if the code is in user space or in kernel space.
You have a limited amount of CPU time. You cannot go beyond and we 
continuously fix and improve our code. Doing mixing in interrupt is
very bad. The latency used with our lock-free algorithm is same as
with mixing in interrupt.

Personally, I am very satisfied with the dmix performance with recent 
fixes. We need only a nice GUI tool to mantain the .asoundrc configuration 
files so users can benefit with using of all extended functions.

> > Not to mention that most distros once they will ship kernel 2.6 they 
> > will probably use ALSA as default because users
> > are demanding multimedia features like MIDI, support of highend cards, 
> OSS supports more cards then ALSA

It's comparable and what we can do, if vendors does not co-operate with us 
(no datasheets, information)? We are open world.

> so good to satisfy us. Mixing in lib is bad in my opinion and works nice
> only if we have enough free CPU cycles. But we use many applications at
> the same time compiling kernel, transfering data, looking in the
> archives, doing backups etc.

Nope. It has nothing to do with all above. With well-tuned system, you 
will have same performance with both implementations.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
