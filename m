From: Lee Jones <lee.jones@linaro.org>
Subject: [GIT PULL] Immutable branch between MFD and Regulator due for the
 v4.9 merge window
Date: Tue, 4 Oct 2016 15:52:32 +0100
Message-ID: <20161004145232.GC29257@dell>
References: <1472831568-466-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1472831568-466-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20160913124457.GA31412@dell>
 <20160914131106.GV27946@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160914131106.GV27946@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, lgirdwood@gmail.com, s.nawrocki@samsung.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Mark,

As requested.

On Wed, 14 Sep 2016, Mark Brown wrote:
> On Tue, Sep 13, 2016 at 01:44:57PM +0100, Lee Jones wrote:
> > On Fri, 02 Sep 2016, Charles Keepax wrote:
> 
> > Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
> > Can I take this?
> 
> The easiest thing would be if you applied it and then sent me a pull
> request.

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-regulator-v4.9-1

for you to fetch changes up to cdd8da8cc66b3d205120560649e530978ccbc567:

  mfd: arizona: Add gating of external MCLKn clocks (2016-10-04 15:46:07 +0100)

----------------------------------------------------------------
Immutable branch between MFD and Regulator due for the v4.9 merge window

----------------------------------------------------------------
Sylwester Nawrocki (1):
      mfd: arizona: Add gating of external MCLKn clocks

 drivers/mfd/arizona-core.c       | 30 ++++++++++++++++++++++++++++--
 include/linux/mfd/arizona/core.h |  9 +++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)


-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
