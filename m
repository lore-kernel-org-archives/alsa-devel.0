From: Christoph Burger-Scheidlin <andersin@freenet.de>
Subject: sis 7012 kernel oops in 2.6.8.1
Date: Sun, 05 Sep 2004 02:16:37 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1094343397.10505.5.camel@hermes.burgerhome.de>
Mime-Version: 1.0
Content-Type: text/plain
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

using a stock 2.6.8.1 kernel with the alsa drivers for the sis 7012 (intel8x0)
drivers compiled fixed into the kernel, I get a kernel oops during startup

unable to register native major device number 116
unable to register timer device (-16)
kobject_register failed for Intel ICH (-17)
 [<c0295d87>] kobject_register+0x57/0x60
 [<c02e3020>] bus_add_driver+0x50/0xb0
 [<c02e361f>] driver_register+0x2f/0x40
 [<c02a079c>] pci_register_driver+0x5c/0x90
 [<cca36015>] alsa_card_intel8x0_init+0x15/0x43 [snd_intel8x0]
 [<c0127e15>] sys_init_module+0x105/0x1d0
 [<c0103e8b>] syscall_call+0x7/0xb

incidentally, when compiling the same driver code as a module, I do not experience
the oops.

Please let me know if there is any information I can provide you with that would help you.

Thanks for your time.

Christoph Burger-Scheidlin



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
