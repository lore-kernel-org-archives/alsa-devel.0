From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Re: The obsolence of OSS, Was: big smile
Date: Wed, 25 Feb 2004 13:42:05 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <403CA62D.2030004@superbug.demon.co.uk>
References: <Pine.LNX.4.58.0402241536450.1883@pnote.perex-int.cz> <403BC832.4080404@gardena.net> <20040225112021.GE8820@sunrise.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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

Adam Tla/lka wrote:
> 
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
> freezes completly and sometimes you can rebufer by pressing pause/play
> buttons. Is it nice and accepted?? While useing java app under aoss
> it gopes to hell if buffer underrun occures.
> 

To be fair, xmms's alsa support is rather poor.
If you get the same problems with an application like xine 
(xine.sf.net), then we would need to look into the problem. xine has 
better alsa support than xmms.

Summary: -
Make the test fair. :-)

Cheers
James


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
