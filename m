From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 0/1] HDSPM: ioctl_compat
Date: Thu,  8 Mar 2012 15:38:03 +0100
Message-ID: <1331217484-4206-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi!

There is a one-line patch in my patch-queue that enables 32bit
applications that access RME specific ioctls to be run on 64bit kernels.

I only had a little test program that worked flawlessly (it solely
tested SNDRV_HDSPM_IOCTL_GET_PEAK_RMS), but the IOSONO guys said they've
tried the patch and it solves their problem (initial bug report was also
from IOSONO).


Cheers

Adrian Knoth (1):
  ALSA: hdspm - Provide ioctl_compat

 sound/pci/rme9652/hdspm.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

-- 
1.7.9.1
