From: Rask Ingemann Lambertsen <rask@sygehus.dk>
Subject: Re: [RFC][RFT] Adding support for Jazz16 based sound
	cards
Date: Mon, 19 Mar 2007 23:46:07 +0100
Message-ID: <20070319224607.GA7889@sygehus.dk>
References: <20070311232436.GB9778@sygehus.dk> <45FDDA0F.7050503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <45FDDA0F.7050503@gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Rene Herman <rene.herman@gmail.com>
Cc: Adam Belay <ambx1@neo.rr.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 19, 2007 at 01:32:15AM +0100, Rene Herman wrote:
> 
> I just now tested this on a standalone Jazz16 and it seems to be working 
> fine for me. I once had ogg123 segfault on me at the end of playback but 
> was unsuccesful in reproducing -- may have been a fluke.

   Thanks. I'll try out ogg123.

> As to the comments...
> 
> The changes to the SB code to support the Jazz16 I ofcourse agree with. 
> Supporting a new card is great. I am however not a huge fan of the new 
> PnP protocol. It's cute, but I feel it's a little over-engineered and 
> could just as well live directly in snd-jazz16.

   See below.

> This setup also shares that same problem with the BIOS generally not 
> having reserved/routed the resources -- on a general PCI/ISA system the 
> user needs to go into the BIOS setup and reserve the resources the card 
> is (or will be, in this case) set to. So now the user really needs to 
> know what resources are going to be assigned, destroying the plug and 
> play idea...

   Not really. A standards compliant PnPBIOS set up with "PnP aware OS =
YES" will use only enough resources to boot the system, which should leave
enough irqs and dmas for the Linux PnP layer to do its work.

   I think there are three good reasons to use the PnP layer:

   1) The PnP layer informs the PCI layer of irqs to try to avoid - please
see pnp_register_irq_resource() in drivers/pnp/resource.c.
   2) The PnP layer knows which resources are used by active devices, even
if they have not been allocated using e.g. request_region(). This
happens in practice. For example:

$ cat /sys/bus/pnp/devices/01\:02.00/resources
state = active
io 0x2a0-0x2af
io 0x390-0x393
io 0x500-0x50f
irq 5
dma 0
dma 1
$ cat /proc/ioports
[...]
0200-0200 : ns558-pnp
0201-0201 : ns558-pnp
0208-020f : ns558-pnp
0213-0213 : ISAPnP
0280-028f : ES18xx
0356-0356 : ide2
0360-0361 : MPU401 UART
0376-0376 : 0000:00:07.1
  0376-0376 : ide1
0390-0391 : OPL2/3 (left)
0392-0393 : OPL2/3 (right)
03c0-03df : vga+
03e8-03ef : serial
03f6-03f6 : 0000:00:07.1
  03f6-03f6 : ide0
03f8-03ff : serial
0500-050f : AD1816A
0800-0807 : ES18xx - CTRL
[...]

Notice that 0x2a0-0x2af is missing from /proc/ioports. The PnP layer will
avoid using that port range because it knows a device is using it.
   3) Knowing which resources a card can utilize, the PnP layer can try to
stay away from those resources when configuring other cards. The PnP layer
doesn't do that yet in a stock kernel, but I've patched it to do so. I'll
try to get those patches into the kernel.

   An advantage of autoprobing in a PnP protocol driver (as opposed to doing
so in a sound card driver) is that it happens before any file systems have
been mounted, so if the autoprobe happens to find one of those #%!$@ NE2000
cards and lock up the system, it won't corrupt your disks.

-- 
Rask Ingemann Lambertsen

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
