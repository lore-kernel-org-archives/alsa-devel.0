From: Guillaume Chevaleyre <processevo@gmail.com>
Subject: CA0110 bug report
Date: Sat, 24 Apr 2010 17:36:02 +0200
Message-ID: <g2j1a5208401004240836h1fbde3ar45f26d3640239c58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f220.google.com (mail-bw0-f220.google.com
	[209.85.218.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C62924503
	for <alsa-devel@alsa-project.org>;
	Sat, 24 Apr 2010 17:36:04 +0200 (CEST)
Received: by bwz20 with SMTP id 20so1728814bwz.32
	for <alsa-devel@alsa-project.org>; Sat, 24 Apr 2010 08:36:02 -0700 (PDT)
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

Hello,

I don't know if it's the good procedure, but anyway, maybe this could help
the team.

bash-4.1# lspci
02:00.0 PCI bridge: Creative Labs [SB X-Fi Xtreme Audio] CA0110-IBG PCI to
PCIe Bridge
03:00.0 Audio device: Creative Labs [SB X-Fi Xtreme Audio] CA0110-IBG

bash-4.1# modprobe snd-ctxfi

bash-4.1# cat /proc/asound/modules
 0 snd_hda_intel

Track:
http://www.alsa-project.org/db/?f=5dd8c336ee72b09e158cb32f08749a8db64715d2

Hope it could help.
