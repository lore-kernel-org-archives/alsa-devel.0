From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: 2.6.19-rc1 boot failure--ops in mpu401_init?
Date: Fri, 6 Oct 2006 16:43:58 -0400
Message-ID: <20061006204358.GB18026@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from pickle.fieldses.org (mail.fieldses.org [66.93.2.214])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 33F8418D
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Oct 2006 22:44:01 +0200 (MEST)
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

A machine that booted fine under 2.6.18-rc6 is failing to boot with
2.6.19-rc1.  After commenting out infinite loop of "Spurious ACK"
messages from atkbd.c that were hiding the original OOPS, I see the an
oops at klist_del+0xd/0x50 with a stack like:

bus_remove_device+0x9f/0xc0
device_del+0x17a/0x1b0
platform_device_del+0x69/0x80
platform_device_unregister+0xd/0x20
alsa_card_mpu401_init+0x7a/0x90
init+0x7f/0x260
kernel_thread_helper+0x7/0x10

Unfortunately I can't actually see the top of the OOPS.  (And haven't
had any luck getting a serial console to work yet...)

I also probably won't have time to try a git-bisect in the next few
days, though I could try it eventually if it'd help.

Let me know of any other details that would be helpful.

--b.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
