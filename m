From: Duncan Sands <duncan.sands@math.u-psud.fr>
Subject: 2.5.5-pre1 kernel - compile as modules?
Date: Thu, 14 Feb 2002 16:08:19 +0100
Message-ID: <E16bNUh-0000Ne-00@baldrick>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Received: from mel-rto3.wanadoo.fr (smtp-out-3.wanadoo.fr [193.252.19.233])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA32201
	for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2002 16:09:18 +0100
Received: from duncan by baldrick with local (Exim 3.34 #1 (Debian))
	id 16bNUh-0000Ne-00
	for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2002 16:08:19 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I just gave the 2.5.5-pre1 kernel a whirl.  Just to be different,
I compiled all sound support into the kernel rather than as
modules.  On startup I get:

Feb 14 15:43:55 baldrick kernel: Advanced Linux Sound Architecture Driver Version 0.9.0beta10.
Feb 14 15:43:55 baldrick kernel: kmod: failed to exec /sbin/modprobe -s -k snd-card-0, errno = 2
Feb 14 15:43:55 baldrick last message repeated 7 times
Feb 14 15:43:55 baldrick kernel: kmod: failed to exec /sbin/modprobe -s -k snd-card-1, errno = 2
Feb 14 15:43:55 baldrick last message repeated 7 times
Feb 14 15:43:55 baldrick kernel: kmod: failed to exec /sbin/modprobe -s -k snd-card-2, errno = 2
Feb 14 15:43:55 baldrick last message repeated 7 times
Feb 14 15:43:55 baldrick kernel: kmod: failed to exec /sbin/modprobe -s -k snd-card-3, errno = 2
Feb 14 15:43:55 baldrick last message repeated 7 times
Feb 14 15:43:55 baldrick kernel: kmod: failed to exec /sbin/modprobe -s -k snd-card-4, errno = 2
Feb 14 15:43:55 baldrick last message repeated 7 times
Feb 14 15:43:55 baldrick kernel: kmod: failed to exec /sbin/modprobe -s -k snd-card-5, errno = 2
Feb 14 15:43:55 baldrick last message repeated 7 times
Feb 14 15:43:55 baldrick kernel: kmod: failed to exec /sbin/modprobe -s -k snd-card-6, errno = 2
Feb 14 15:43:55 baldrick last message repeated 7 times
Feb 14 15:43:55 baldrick kernel: kmod: failed to exec /sbin/modprobe -s -k snd-card-7, errno = 2
Feb 14 15:43:55 baldrick last message repeated 7 times
Feb 14 15:43:55 baldrick kernel: PCI: Found IRQ 5 for device 00:0a.0
Feb 14 15:43:55 baldrick kernel: ALSA device list:
Feb 14 15:43:55 baldrick kernel:   #0: Sound Fusion CS46xx at 0xda800000/0xda000000, irq 5

And then later there are all sorts of problems, such as

cat /proc/asound/cards

claims there is no such device.

Must sound support be compiled as modules?

Thanks,

Duncan.

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
