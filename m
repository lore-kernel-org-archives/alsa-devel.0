From: Adrian Bunk <bunk@fs.tum.de>
Subject: ALSA .text.exit compile errors in 2.5.14-dj2
Date: Thu, 9 May 2002 13:26:34 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <acqdom$e2q$2@main.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from hermes.fachschaften.tu-muenchen.de (hermes.fachschaften.tu-muenchen.de [129.187.176.19])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id NAA25070
	for <alsa-devel@alsa-project.org>; Thu, 9 May 2002 13:31:36 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

while trying to compile a non-modular 2.5.14-dj2 kernel I got the
following ALSA-related .text.exit errors at the final linking:


<--  snip  -->

...
sound/sound.o: In function `snd_card_es968_probe':
sound/sound.o(.text.init+0x22222): undefined reference to `local symbols
in discarded section .text.exit'
sound/sound.o: In function `alsa_rme9652_mem_init':
sound/sound.o(.text.init+0x2b78a): undefined reference to `local symbols
in discarded section .text.exit'
sound/sound.o(.data+0x36fd4): undefined reference to `local symbols in
discarded section .text.exit'
...

<--  snip  -->

The problems are

In sound/isa/sb/es968.c:
snd_card_es968_probe isn't __exit (more exactly it's __init) but it calls
snd_card_es968_free that is __exit

In sound/pci/rme9652/rme9652_mem.c:
alsa_rme9652_mem_init isn't __exit (more exactly it's __init) but it calls
rme9652_free_buffers that is __exit


I'm not sure whether removing the __exit is the right solution or whether
there's a better solution.


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
