From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 00/11] ASoC/MFD: twl4030 codec local register cache
 removal
Date: Wed, 8 Jan 2014 11:42:32 +0000
Message-ID: <20140108114232.GI19974@lee--X1>
References: <1388755676-16036-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1388755676-16036-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Mark,

Enjoy!

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e=
42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.linaro.org/people/ljones/mfd.git tags/ib-asoc-3.14.2

for you to fetch changes up to 9146070089cca0fa5c396f1a4d0b96d675004c04=
:

  mfd: twl-core: Enable regcache for audio registers (2014-01-08 11:37:=
52 +0000)

----------------------------------------------------------------
Immutable branch between MFD and ASoC due for the v3.14 merge window

----------------------------------------------------------------
Peter Ujfalusi (4):
      mfd: twl6040: reg_defaults support for regmap
      mfd: twl-core: Simplify IO wrapper functions by moving common cod=
e out
      mfd: twl-core: API to set the regcache bypass for a given regmap =
in twl
      mfd: twl-core: Enable regcache for audio registers

 drivers/mfd/twl-core.c  | 190 ++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--=
----------------
 drivers/mfd/twl6040.c   |  92 ++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++--
 include/linux/i2c/twl.h |   3 ++
 3 files changed, 255 insertions(+), 30 deletions(-)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
