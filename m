From: Thomas Charbonnel <thomas@undata.org>
Subject: Rawmidi and CONFIG_DEBUG_SPINLOCK_SLEEP
Date: Thu, 29 Jan 2004 21:27:07 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40196C9B.3050901@undata.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from satellite.undata.org (brln-d5148640.pool.mediaWays.net [213.20.134.64])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA00729
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2004 21:43:38 +0100
Received: from localhost ([127.0.0.1] helo=undata.org)
	by satellite.undata.org with esmtp (Exim 4.21)
	id 1AmJ0F-0000mh-Db
	for alsa-devel@alsa-project.org; Thu, 29 Jan 2004 21:43:07 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I noticed this problem today using midi on my setup (alsa 1.0.1, kernel 
2.6.1 with CONFIG_DEBUG_SPINLOCK_SLEEP) :

Debug: sleeping function called from invalid context at 
include/asm/uaccess.h:473
in_atomic():1, irqs_disabled():1
Call Trace:
  [<c012139c>] __might_sleep+0xac/0xe0
  [<c010b170>] handle_signal+0xd0/0x140
  [<c03955ef>] snd_rawmidi_kernel_read1+0x10f/0x170
  [<c03957e7>] snd_rawmidi_read+0x147/0x1b0
  [<c01131cf>] restore_i387_fxsave+0x8f/0xa0
  [<c015b2f3>] vfs_read+0xd3/0x140
  [<c015b59f>] sys_read+0x3f/0x60
  [<c010b4bb>] syscall_call+0x7/0xb

I'm sorry I didn't check if this was fixed in 1.0.2, but though it was 
worth mentioning. This caused regular (~ 1/second) dropouts in pd while 
using midi.

Thomas




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
