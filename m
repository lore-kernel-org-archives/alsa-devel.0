From: Manuel Jander <manuel.jander@usm.cl>
Subject: Re: Some problems with snd-au8830
Date: Mon, 13 Sep 2004 00:43:51 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1095050630.2193.16.camel@localhost>
References: <20040912084204.GA22712@darjeeling.triplehelix.org>
	 <1095015988.2056.9.camel@localhost>
	 <20040912215450.GD12433@triplehelix.org>
Reply-To: mjander@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040912215450.GD12433@triplehelix.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Joshua Kwan <joshk@triplehelix.org>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi

On Sun, 2004-09-12 at 17:54, Joshua Kwan wrote:
> On Sun, Sep 12, 2004 at 03:22:09PM -0400, Manuel Jander wrote:
> > That are hardware error flags. Normally, one "IRQ fifo error" occurrs
> > for the first time playback ocurrs. But more than one message of those
> > plus the others certainly is odd. I Would try to change the PCI slot. By
> > the way, do you mind sending a lspci output, and some general
> > information about your system ?
> 
> Yeah, I always notice the fifo error when I play for the first time.
> There's also usually a large crackle which is kind of bad..

Oops, thats very odd too... Any chance to record that and send me a
sample ? Knowing exactly how it sounds, could give me a clue.

> Well, the card is in my last PCI slot. I'll try moving it though.
> 
> Here's lspci info:
> 
> 0000:00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?) (rev c1)
> 0000:00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev c1)
> 0000:00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev c1)
> 0000:00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev c1)
> 0000:00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev c1)
> 0000:00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev c1)
> 0000:00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
> 0000:00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
> 0000:00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
> 0000:00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
> 0000:00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
> 0000:00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet Controller (rev a1)
> 0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio Controler (MCP) (rev a1)
> 0000:00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev a3)
> 0000:00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
> 0000:00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
> 0000:01:09.0 Multimedia audio controller: Aureal Semiconductor Vortex 2 (rev fa)
> 0000:02:00.0 VGA compatible controller: ATI Technologies Inc Radeon R100 QD [Radeon 7200]

Hmm, is that a 64bit Opteron or something like that ? Kernel version ?
alsa-driver from vanilla kernel or compiled separately ? How can i
reproduce your situation/scenario ?

> > Cool that you actually got jackd working :P, i never got it working on
> > whatever hardware i have tried it (intel8x0, ESS maestro 2e, au8820 and
> > au8830). The aureal driver does support any period size power of 2 upto
> > 4096 bytes; that includes 1024 (4096 if that where 16bit stereo frames
> > instead bytes). Why jackd was unable to set that up ? I guess the error
> > message is somewhat wrong; probably some other parameter could not be
> > met.
> 
> -p512 -P sounds like utter crap, btw. And if I do jackd -d oss, it all
> works very nicely.

Thats a very common case, that happens when programs try setting weird
buffer settings, and don't take into account that the actually settings
are not necessarily exactly those requested (but as close as possible).
There is not much that can be done in the driver to change that.
While using OSS, usually a more sane buffer setting is at use, and the
badly behaving app looses some control (or messing ability).

> Would it matter that my .asoundrc is set up for hardware mixing?

You should not need any .asoundrc settings for hardware mixing. It works
just out of the box.

Best Regards

Manuel Jander




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
