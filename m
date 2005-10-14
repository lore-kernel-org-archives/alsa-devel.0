From: Chuck Anderson <cra@WPI.EDU>
Subject: system hang at maestro3 load
Date: Fri, 14 Oct 2005 10:43:19 -0400
Message-ID: <20051014144319.GA8436@angus.ind.WPI.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I've been debugging a problem with the maestro3 driver hanging the
system at module load which I first reported during Fedora Core 3 Test
1, and still hangs in the newest kernel from Fedora Core development:

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=134507

As described in the bug report, the system only hangs if Windows was
not booted prior to booting Linux.  So it seems that the Windows
driver is poking the hardware in some way that "helps" the Linux
driver, and basically the Linux driver is not initializing the
hardware correctly.

I've since decided to dig into the driver to see where it is hanging
by sprinkling printk's throughout.  In the snd_m3_chip_init function,
the hang always happens after the RUN_ASSP command is sent to the
ASSP_CONTROL_B register:

start snd_m3_chip_init
start pci_read_config_dword PCI_ALLEGRO_CONFIG
done pci_read_config_dword PCI_ALLEGRO_CONFIG = c00000
start pci_write_config_dword PCI_ALLEGRO_CONFIG = a400040
done pci_write_config_dword PCI_ALLEGRO_CONFIG = a400040
start outb RESET_ASSP 0x0
done outb RESET_ASSP 0x0
start pci_read_config_dword PCI_ALLEGRO_CONFIG
done pci_read_config_dword PCI_ALLEGRO_CONFIG = a400040
start pci_write_config_dword PCI_ALLEGRO_CONFIG = a500040
done pci_write_config_dword PCI_ALLEGRO_CONFIG = a500040
start inb ASSP_CONTROL_A
done inb ASSP_CONTROL_A = 0x0
start outb ASSP_CONTROL_A 0x9
done outb ASSP_CONTROL_A 0x9
start outb RUN_ASSP ASSP_CONTROL_B 0x1
d[HANGS HERE]

The last line should print "done outb RUN_ASSP ASSP_CONTROL_B 0x1",
but is cut off after the system hangs.

I compared the chip initialization from the ALSA driver with that from
the OSS driver, and they are pretty much identical, barring a few
things like quirk handling that the ALSA driver does.  I tried
disabling the new stuff like quirk handling so that they two drivers
did essentially the exact same chip initialization, but that didn't
help.

I decided to actually try the OSS driver, so I put the same debugging
stuff into the OSS driver and it hangs at the same point under the
same conditions.  So, it appears that this problem has been around for
a long time. 

At this point I am stuck.  Does anyone have any clues or suggestions 
as to how to proceed with this problem?

I found a bug referenced in the mail archive that sounds like the 
same problem:

http://sourceforge.net/mailarchive/message.php?msg_id=8967024

https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000376

but bugtrack is currently down.  I'll reopen this issue when bugtrack
comes back online.

Thanks.


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
