From: "D. Sen" <dsen@homemail.com>
Subject: RME Hdsp PCMCIA problems
Date: Mon, 27 Sep 2004 21:00:13 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4157F2BD.7000804@homemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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

I am wondering if someone knows how to fix this problem.

When I insert the RME hdsp pcmcia card (interfaced to a multiface box) 
and type 'modprobe snd-hdsp', I get the following on /var/log/messages:

Sep 27 20:50:57 localhost kernel: __alloc_pages: 9-order allocation 
failed (gfp=0x20/0)
Sep 27 20:50:57 localhost kernel: __alloc_pages: 9-order allocation 
failed (gfp=0x21/0)
Sep 27 20:50:57 localhost kernel: __alloc_pages: 9-order allocation 
failed (gfp=0x20/0)
Sep 27 20:50:57 localhost kernel: __alloc_pages: 9-order allocation 
failed (gfp=0x21/0)
Sep 27 20:50:57 localhost kernel: RME Hammerfall DSP: no buffers available
Sep 27 20:50:57 localhost kernel: RME Hammerfall-DSP: no cards found


lspci shows the RME card:
03:00.0 Multimedia audio controller: Xilinx Corporation RME Hammerfall 
DSP (rev 0a)

/etc/pcmcia/config.opts has:
include port 0x100-0x4ff, port 0xc00-0xcff
include memory 0xc0000-0xfffff
include memory 0xa0000000-0xa0ffffff, memory 0x60000000-0x60ffffff
include port 0xa00-0xaff
exclude irq 4
exclude irq 7


Any help will be much appreciated.

Thanks,
DS



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
