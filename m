From: linuxconsole@free.fr
Subject: alsa and 2.6.25.4 kernel
Date: Fri, 13 Jun 2008 19:02:40 +0200
Message-ID: <1213376560.4852a830e906b@imp.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wmproxy1-g27.free.fr (wmproxy1-g27.free.fr [212.27.42.91])
	by alsa0.perex.cz (Postfix) with ESMTP id 683BC24495
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 19:04:29 +0200 (CEST)
Received: from imp7-g19.priv.proxad.net (imp7-g19.priv.proxad.net
	[172.20.243.49])
	by wmproxy1-g27.free.fr (Postfix) with ESMTP id 9BD8E2A03F
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 19:04:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I can't play sound or use mixer with alsa on 2.6.25.4 kernel.

I tried all alsa-libs (1.16, 1.17rc1, hg) without success.

the file /proc/asound/cards is :

cat /proc/asound/cards
 0 [NVidia         ]: HDA-Intel - HDA NVidia
                      HDA NVidia at 0xf0100000 irq 18

 strace -e open amixer :

...
open("/dev/snd/controlC0", O_RDONLY)    = -1 ENODEV (No such device)
open("/dev/aloadC0", O_RDONLY)          = -1 ENODEV (No such device)

ls -l /dev/snd/controlC0
crw-rwxrw- 1 root users 116, 0 Aug 23  2004 /dev/snd/controlC0


what happens ???

Regards.

Yann.
