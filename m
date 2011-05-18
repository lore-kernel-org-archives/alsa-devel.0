From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [PATCH 0/2] ASoC: davinci: ping-pong buffers for mcasp
	on da850evm
Date: Wed, 18 May 2011 09:27:44 -0400
Message-ID: <cover.1305723716.git.bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog101.obsmtp.com (na3sys009aog101.obsmtp.com
	[74.125.149.67]) by alsa0.perex.cz (Postfix) with ESMTP id 9C65F24407
	for <alsa-devel@alsa-project.org>;
	Wed, 18 May 2011 15:27:53 +0200 (CEST)
Received: by mail-yw0-f54.google.com with SMTP id 7so674771ywf.13
	for <alsa-devel@alsa-project.org>; Wed, 18 May 2011 06:27:50 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Sekhar Nori <nsekhar@ti.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
Cc: Subhasish Ghosh <subhasish@mistralsolutions.com>, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

davinci-i2s enables the use of ping-pong buffers by copying the sram sizes
specified by platform data into the dma params used by davinci-pcm.

This patch series first implements that same behaviour in davinic-mcasp
and then specified sram sizes and eventq's for da850evm.

To achieve the use of ping-pong buffers at runtime this patch depends also
on the conversion of da850's SRAM allocator to the "Share RAM" region from 
the "ARM Local RAM" region -- originally proposed by Subhasish Ghosh[1] and
recently reposted by myself [2].

This is because the "ARM Local RAM" region currently used by the da850 SRAM
allocator is not addressable by the EDMA. The resulting behaviour, when
ping-pong buffers are used by davinci-pcm, is that playback produces silence
and capture acquires silence.

However, there is no change in behaviour for da850evm build with the in-tree
defconfig since suspend allocates SRAM which prevents a successful allocation
of 8K by davinci-pcm and thus the behaviour falls back to the usual scheme.

In the case of da850evm builds where CONFIG_SUSPEND is not set, playback 
will produce silence and capture will acquire silence until such time as the
patches to change the da850 SRAM allocator to the "Shared RAM" region are 
merged.

[1] http://article.gmane.org/gmane.linux.kernel/1098928
[2] http://article.gmane.org/gmane.linux.ports.arm.kernel/117261

Ben Gardiner (2):
  ASoC: davinci-mcasp: enable ping-pong SRAM buffers
  davinci: da850evm: enable mcasp ping-pong buffers and eventq's

 arch/arm/mach-davinci/board-da850-evm.c |    5 ++++-
 sound/soc/davinci/davinci-mcasp.c       |    2 ++
 2 files changed, 6 insertions(+), 1 deletions(-)

-- 
1.7.4.1
