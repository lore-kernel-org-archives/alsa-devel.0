From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH - [hdspm] 0/3] Support for RME RayDAT and AIO
Date: Tue, 18 Jan 2011 15:12:16 +0100
Message-ID: <1295359939-14673-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

As announced a few days ago, I've integrated the offspring hdspm driver
by Florian Faber. The new code now also supports the 36in/36out RME
RayDAT cards and RME AIOs.

I tried to follow the kernel's coding style as much as possible,
however, there are still a few overlong lines left. For example, I
didn't want to break "if read_reg(...) & 0x3f" at "& 0x3f", as it
worsens readability. If it's required to comply, feel free to add the
missing line breaks.

Right now, RayDATs and AIOs can only operate on a single period size
of 1024 samples, because these cards always use a fixed 16k buffer per
channel and only vary interrupt frequency. I'm going to try to fix this
after I've learned more about the PCM interface. ;) Any suggestions
welcome.

Cheers

Adrian Knoth (3):
  Add headers for RayDAT and AIO support.
  Enable RME RayDAT and AIO
  Add RayDAT and AIO strings to Kconfig

 include/hdspm.h     |  442 +++++-
 pci/Kconfig         |    6 +-
 pci/rme9652/hdspm.c | 4135 +++++++++++++++++++++++++++++++++++++--------------
 3 files changed, 3442 insertions(+), 1141 deletions(-)

-- 
1.7.2.3
