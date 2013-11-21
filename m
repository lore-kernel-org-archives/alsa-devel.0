From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [GIT PULL] mfd: Immutable branch for ASoC
Date: Thu, 21 Nov 2013 12:27:00 +0000
Message-ID: <20131121122700.GF23067@lee--X1>
References: <1384877043-5640-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1384877043-5640-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20131120091636.GA30012@lee--X1>
 <20131120102045.GW2674@sirena.org.uk>
 <20131120104526.GA30524@lee--X1>
 <20131120113400.GY2674@sirena.org.uk>
 <20131121090724.GB19368@lee--X1>
 <20131121114105.GO2674@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131121114105.GO2674@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, lgirdwood@gmail.com, sameo@linux.intel.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

> I was expecting patch 1 in the series as well (the DSP stuff won't wo=
rk
> properly without the register map updates to go with it).

Try this instead:

The following changes since commit 5e01dc7b26d9f24f39abace5da98ccbd6a5c=
eb52:

  Linux 3.12 (2013-11-03 15:41:51 -0800)

are available in the git repository at:

  git://git.linaro.org/people/ljones/mfd.git tags/ib-asoc-1

for you to fetch changes up to 254dc326dbfd23c2678fafad1b84fc0e42ac4374=
:

  ASoC: wm5110: Expose input high pass filter controls (2013-11-21 12:2=
3:21 +0000)

----------------------------------------------------------------
Immutable branch for ASoC, as requested by Mark Brown

----------------------------------------------------------------
Charles Keepax (2):
      mfd: wm5110: Make DSP memories readable
      ASoC: wm5110: Expose input high pass filter controls

 drivers/mfd/wm5110-tables.c           | 73 +++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++----
 include/linux/mfd/arizona/registers.h | 37 +++++++++++++++++++++++++++=
++++++++++
 sound/soc/codecs/arizona.c            | 10 ++++++++++
 sound/soc/codecs/arizona.h            |  1 +
 sound/soc/codecs/wm5110.c             | 19 +++++++++++++++++++
 5 files changed, 136 insertions(+), 4 deletions(-)



--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
