From: Edouard Gomez <ed.gomez@free.fr>
Subject: Cannot mmap /dev/dsp error in alsa 0.9.7 and 0.9.8
Date: Sat, 15 Nov 2003 02:31:37 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031115013137.GF832@leeloo>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4jXrM3lyYWu4nBt5"
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


--4jXrM3lyYWu4nBt5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I'm having troubles with recent alsa releases (newer than 0.9.6). I
first suffered the bugs explained later on 2.6 test kernels, so i
thought it was smply a 2.6 bug. Tonight the 0.9.8 alsa packages made
their paths into debian SID so i compiled the kernel part for my usual
2.4.22 kernel and i experience the same problems.

Symptoms:
- OSS device mapping fails with a EACCES errno. See attachment for
  triggering the bug.
- mplayer AV sync is too fast by ~20% (men sound like ladies ;-) when
  using the alsa9 output, but syncs well when using the compat oss layer

Configuration:
- 2.4.22-ck2 or 2.4.22 or 2.6.0-test8 or 2.6.0-test9 or
  2.6.0-test9+latest alsa cvs
- alsa 0.9.7 or 0.9.8 or current CVS for the kernel modules and 0.9.8
  for all client shared libs (but shared libs aren't a problem as the
  OSS bug is only related to the module part)
- VIA 8235 (module snd-via82xx)

Known working combinations:
- 2.4.22 + alsa 0.9.6 kmodules + 0.9.8 libs
- 2.4.22-ck2 + alsa 0.9.6 kmodules + 0.9.8 libs

Changing the modules to a 0.9.8 makes the bug appearing.

When playing with 2.6, i tried 0.9.7 and 0.9.8 on top of the test9
version, all show the bug, sorry, i forgot trying 0.9.6 and i erased
the 2.6 tree.

Hope this bug report is enough. See attachment for the OSS bug. The
mmap function call will always return -1 with 0.9.7 or 0.9.8.

PS: the code in the attached file is exactly the same as found in all
    quake engines. That's an Id game (quake3) that triggered the bug first so
    i've copied the quake1 sound init sequence in order to approximate
    the quake3 engine sound initialization... this worked.

-- 
Edouard Gomez

--4jXrM3lyYWu4nBt5
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="mmap-bug-oss.c"

#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/shm.h>
#include <sys/wait.h>
#include <linux/soundcard.h>
#include <stdio.h>

int main()
{
	int dsp;
	char *dma_buffer;
	struct audio_buf_info info;
	int caps;

	/* Open the dsp device */
	if ((dsp = open("/dev/dsp", O_RDWR)) == -1) {
		perror("error opening /dev/dsp");
		return(-1);
	}

	/* Reset the dsp */
	if (ioctl(dsp, SNDCTL_DSP_RESET, 0) == -1) {
		perror("Could not reset DSP");
		close(dsp);
		return(-2);
	}

	if (ioctl(dsp, SNDCTL_DSP_GETCAPS, &caps) == -1) {
		perror("error getting DSP capabilities");
		close(dsp);
		return(-3);
	}

	if (!(caps & DSP_CAP_TRIGGER) || !(caps & DSP_CAP_MMAP)) {
		fprintf(stderr, "error mmap capability unavailable\n");
		close(dsp);
		return(-4); 
	}

	if (ioctl(dsp, SNDCTL_DSP_GETOSPACE, &info) == -1) {   
		perror("error GETOSPACE unavailable");
		close(dsp);
		return(-5);
	}

	/* memory map the dma buffer */
	dma_buffer = mmap(NULL, info.fragstotal*info.fragsize, PROT_WRITE, MAP_FILE|MAP_SHARED, dsp, 0);
	if (!dma_buffer || dma_buffer == (char *)-1) {
		perror("Could not mmap /dev/dsp");
		close(dsp);
		return(-6);
	}

	/* never reached */
	munmap(dma_buffer, info.fragstotal*info.fragsize);
	close(dsp);

	return(0);
}

--4jXrM3lyYWu4nBt5--


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
