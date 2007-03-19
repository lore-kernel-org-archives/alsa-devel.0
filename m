From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [RFC][RFT] Adding support for Jazz16 based sound
 cards
Date: Mon, 19 Mar 2007 01:32:15 +0100
Message-ID: <45FDDA0F.7050503@gmail.com>
References: <20070311232436.GB9778@sygehus.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20070311232436.GB9778@sygehus.dk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Rask Ingemann Lambertsen <rask@sygehus.dk>
Cc: Adam Belay <ambx1@neo.rr.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 03/12/2007 12:24 AM, Rask Ingemann Lambertsen wrote:

> Below is a patch against linux-2.6.20 to add support for Jazz16 sound
> cards. It consists of changes to ALSA's SoundBlaster support and a
> new PnP protocol for detecting the card, setting resources and such.
> Before submitting a patch for inclusion into Linux, I would like to
> have a few comments and perhaps a test report from someone else.

I just now tested this on a standalone Jazz16 and it seems to be working 
fine for me. I once had ogg123 segfault on me at the end of playback but 
was unsuccesful in reproducing -- may have been a fluke.

As to the comments...

The changes to the SB code to support the Jazz16 I ofcourse agree with. 
Supporting a new card is great. I am however not a huge fan of the new 
PnP protocol. It's cute, but I feel it's a little over-engineered and 
could just as well live directly in snd-jazz16.

Currently you have jazz16 specific code in drivers/pnp. It's not code 
that can be more generally used so snd-jazz16 is the correct place for 
it I feel. Right now you've essentially just split one driver into two 
pieces and placed the pieces in different corners of the tree.

In snd-jazz16, you'd take port= as a parameter (or autoprobe 220-260 as 
you do now; not a fan of autoprobing but that's not the issue now) same 
as other alsa drivers do and take irq/dma8/dma16 parameters as requests 
to use those specified resources and program the card for it. sgalaxy 
does this as well for irq and dma for example.

This setup also shares that same problem with the BIOS generally not 
having reserved/routed the resources -- on a general PCI/ISA system the 
user needs to go into the BIOS setup and reserve the resources the card 
is (or will be, in this case) set to. So now the user really needs to 
know what resources are going to be assigned, destroying the plug and 
play idea...

A while ago when I was doing the isa_bus thing I also looked into 
integrating plain old ISA with PnP and ran into those same issues. 
Basically, there are no practical advantages, and a few disadvantages 
(user needing to have reserved the resources, not being able to keep all 
code specific to one piece of hardware in one place, needing to invent 
PnP IDs).

Yes, the setup is sort of nice conceptually, so I hope you don't too 
much mind me not liking it in practice.

Rene.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
