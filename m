From: Vedran Rodic <vedran@quark.fsb.hr>
Subject: trouble with dosemu and alsa oss emulation (and a fix for alsa)
Date: Sat, 6 Sep 2003 22:09:43 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030906200943.GA5128@quark.fsb.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Cc: linux-msdos@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi. 

I'm having trouble with latest ALSA and oss emulation. I'm using dosemu to
play some DOS games and I've noticed that sound in DOS apps stops playing 
after short time (depending on the app). 


I'm regulary updating both alsa and dosemu, I suspected dosemu first, since
I had no problems whatsoever with alsa oss emulation. 

It turned out that this was not dosemu problem, but alsa oss emulation problem.
I've tracked it down to a change in  alsa-kernel/core/oss/pcm_oss.c. 
The change is here:
http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/alsa/alsa-kernel/core/oss/pcm_oss.c.diff?r1=1.40&r2=1.41

I'm currently using the latest pcm_oss.c but without this patch and it
works great again. 

I think that dosemu code - src/arch/linux/dosext/sound/linux_sound.c is
correct. 

Anyway, here's a couple of lines from dosemu sound log, starting arround 
where IOCTL error appears:

SB:[Linux] Get Free Fragments (16, 0)
SB:[Linux] Get Free Fragments (16, 0)
SB: Read 0x7f from DSP Write Buffer Status Register
SB: Going to write 128 bytes
SB:[Linux] Get Free Fragments (16, 0)
SB:[Linux] Get Free Fragments (16, 0)
SB: DSP command 0xd0 accepted
SB: Pausing DMA transfer, 256 bytes left
SB: Read 0x7e from DSP Write Buffer Status Register
SB: DSP command 0xd4 accepted
SB: Going to write 128 bytes
SB:[Linux] Get Free Fragments IOCTL error (Broken pipe)
SB:[Linux] Get Free Fragments IOCTL error (Broken pipe)
SB: Going to write 128 bytes
SB:[Linux] Get Free Fragments IOCTL error (Broken pipe)
SB:[Linux] Get Free Fragments IOCTL error (Broken pipe)
SB: Going to write 128 bytes


Vedran


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
