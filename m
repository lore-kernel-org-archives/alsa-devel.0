From: Giuliano Pochini <pochini@shiny.it>
Subject: Badness in remove_proc_entry
Date: Sat, 27 Mar 2004 21:52:38 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040327215238.6e3f0762.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


I'm not sure if this is alsa's fault. It happens when I unload the module.
Yup, snd_gina24 is the driver I'm developing, but it also happens with
snd-powermac and when I try to load a module for a card I don't have.

Linux Jay 2.6.5-rc2-ben0 #1 SMP Sat Mar 27 09:10:55 CET 2004 ppc unknown


Badness in remove_proc_entry at fs/proc/generic.c:660
Call trace:
 [c000bbe4] dump_stack+0x18/0x28
 [c00089f4] check_bug_trap+0x84/0xac
 [c0008b4c] ProgramCheckException+0x130/0x170
 [c00080b4] ret_from_except_full+0x0/0x4c
 [c00973a4] remove_proc_entry+0x100/0x154
 [e668c64c] snd_remove_proc_entry+0x24/0x34 [snd]
 [e668df28] snd_info_unregister+0xb0/0x128 [snd]
 [e668d668] snd_info_card_free+0x74/0xa4 [snd]
 [e668afd8] snd_card_free+0xf8/0x2a0 [snd]
 [e671d63c] snd_Echo_remove+0x80/0x84 [snd_gina24]
 [c00ec21c] pci_device_remove+0x60/0x64
 [c012ab80] device_release_driver+0x84/0x88
 [c012abb0] driver_detach+0x2c/0x50
 [c012aee0] bus_remove_driver+0x54/0xb8
 [c012b2dc] driver_unregister+0x18/0x88

--
Giuliano.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
