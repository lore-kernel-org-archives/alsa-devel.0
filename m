From: Nishanth Menon <nm@ti.com>
Subject: Regression: make clean (was linux-next: Tree for May 8:)
Date: Thu, 8 May 2014 11:14:16 -0500
Message-ID: <CAGo_u6q8_nh00wrnPvGpVLDpt3uT8f8BfH7kczaLpopQAs1QKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: Mark Brown <broonie@linaro.org>, Vinod Koul <vinod.koul@intel.com>
Cc: linux-next@vger.kernel.org, alsa-devel@alsa-project.org, lkml <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Mark, Vinod,

On Thu, May 8, 2014 at 1:11 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> This tree still fails (more than usual) the powerpc allyesconfig build
> and also the celleb_defconfig.
>
> Changes since 20140507:
>
> The powerpc tree still had its build failure.
>
> Non-merge commits (relative to Linus' tree): 4132
>  3871 files changed, 137526 insertions(+), 86247 deletions(-)
>

linux-2.6$ git branch -v|grep "^*"
* (no branch)                                   05f62d7 Add linux-next
specific files for 20140508
linux-2.6$ git describe
next-20140508
linux-2.6$ git clean -fdx;git reset --hard
HEAD is now at 05f62d7 Add linux-next specific files for 20140508
linux-2.6$ git status
# Not currently on any branch.
nothing to commit (working directory clean)
linux-2.6$ ls sound/soc/intel/
byt-rt5640.c  Kconfig   mfld_machine.c  sst-baytrail-dsp.c
sst-baytrail-ipc.h  sst-dsp.c  sst-dsp-priv.h  sst-haswell-dsp.c
sst-haswell-ipc.h  sst-mfld-dsp.h                sst-mfld-platform.h
haswell.c     Makefile  sst-acpi.c      sst-baytrail-ipc.c
sst-baytrail-pcm.c  sst-dsp.h  sst-firmware.c  sst-haswell-ipc.c
sst-haswell-pcm.c  sst-mfld-platform-compress.c
sst-mfld-platform-pcm.c

linux-2.6$ make -j1 CROSS_COMPILE=arm-linux-gnueabi- ARCH=arm distclean V=1
<snip>
make -f scripts/Makefile.clean obj=sound/soc/fsl
make -f scripts/Makefile.clean obj=sound/soc/generic
make -f scripts/Makefile.clean obj=sound/soc/intel
make -f scripts/Makefile.clean obj=sound/soc/intel/board
scripts/Makefile.clean:17:
/home/nmenon/Src/opensource/linux-2.6/sound/soc/intel/board/Makefile:
No such file or directory
make[4]: *** No rule to make target
`/home/nmenon/Src/opensource/linux-2.6/sound/soc/intel/board/Makefile'.
 Stop.
make[3]: *** [sound/soc/intel/board] Error 2
make[2]: *** [sound/soc/intel] Error 2
make[1]: *** [sound/soc] Error 2
make: *** [_clean_sound] Error 2

Seems to have been introduced by
commit 1eee978f4258e702adf4a666ee9d81981c3846b5 (ASoC: Intel: split
the pcm and compress to different files)
introduced:
 obj-$(CONFIG_SND_SST_MACHINE) += board/

with no board directory in sound/soc/intel/.

This regression seems to have been introduced in next-20140507 tag.

Regards,
Nishanth Menon
