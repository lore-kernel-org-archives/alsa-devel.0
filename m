From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: [BUG] buggy ali5451 driver
Date: Mon, 04 Nov 2002 12:47:52 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m24raxpndj.fsf@vador.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Matt Wu <Matt_Wu@acersoftech.com.cn>, alsa-devel@lists.sourceforge.net, olivier.ricordeau@wanadoo.fr
List-Id: alsa-devel@alsa-project.org

regarding ali5451 problems that show up on kml, i just had access to
oliver's laptop which has the infamous ali5451.

both oss' trident and alsa's snd-ali5451 cannot 

# modprobe snd-ali5451
PCI: Found IRQ 4 for device 00:08:0
URQ routing conflict for 00:08:0, have irq 5, want irq 4

then kernel cries:
hda: status timeout: status=0x80 { Busy }
hda: DMA disabled
hda: drive not ready for command.

disks cannot anymore be accessed. the system is still fine (no oops,
no freeze).
the vfs & ext3 then ended in I/O error since the disks answered
themselves busy to the eide controller.


the bugs ali5451 chips suffer may be related to :

- either the poor ressources allocation on laptios, which is poorer &
  poorer since acpi "invade" laptops

- or driver misconception regarding irq sharing


the cars is "M5451 PCI South Bridge Audio" manufactured by Acer
Laboratories Inc. [ALi] (with pci ids : 0x10b9 0x5451)


irq 5 has been allocated to ali snd card, pcmcia cardbus controller
(managed by yenta_socket).


olivier <olivier.ricordeau@wanadoo.fr> is the owner of that fscking
chip.

this is a compaq laptop.

i have access to another compaq laptop that works well with oss
trident.  this is a compaq laptop too.



kernel is 2.4.18 based and alsa was tested with 0.9.0rc3 & rc5



-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
