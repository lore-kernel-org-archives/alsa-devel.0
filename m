From: jfm3 <jfm3@ouroboros-complex.org>
Subject: pcmcia hdsp problems
Date: 08 May 2003 12:25:34 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1052411146.1361.54.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA Developer List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I'm running the latest Planet CCRMA on Redhat 8. This is alsa 9.2 and
kernel 2.4.20 with the usual audio patches. I've taken the plunge and
acquired a hdsp Multiface. I'm using it with a PCMCIA interface.

I put 'modprobe snd-hammerfall-mem enable=1' as the first thing that
happens in /etc/rc.sysinit. It doesn't seem to allocate any memory. When
the machine first boots with the PCMCIA card in, it lists it as this: 

$ lspci
...
01:00.0 Class ffff: Illegal Vendor ID: Unknown device ffff (rev ff)

If I remove the card with cardctl eject and put it back in, it shows up.

$ lspci
...
01:00.0 Multimedia audio controller: Xilinx, Inc. RME Hammerfall DSP
(rev 0b)

At this point I can reload snd-hammerfall-mem and snd-hdsp and they
don't complain. The bright red HOST light is still on though. Of course,
at this point, it is probably too late for snd-hammerfall-mem to have
been loaded correctly.

Does the enable argument to snd-hammerfall-mem do anything anymore? Any
other ideas?

-- 
(jfm3  2838 BCBA 93BA 3058 ED95  A42C 37DB 66D1 B43C 9FD0)



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
