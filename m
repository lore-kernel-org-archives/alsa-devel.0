From: Duncan Sands <baldrick@wanadoo.fr>
Subject: 2.5.50: sleeping function called from illegal context
Date: Tue, 3 Dec 2002 04:07:52 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200212030407.53337.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Got this with today 2.5 BK tree:

Debug: sleeping function called from illegal context at include/asm/semaphore.h:119
Call Trace:
 [<c0113f1a>] __might_sleep+0x52/0x58
 [<c024291a>] snd_cs46xx_iec958_put+0x36/0xf8
 [<c0217f28>] snd_ctl_elem_write+0xe0/0x1a4
 [<c0218360>] snd_ctl_ioctl+0x184/0x2c8
 [<c01462e6>] sys_ioctl+0x1fa/0x244
 [<c01088f7>] syscall_call+0x7/0xb


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
