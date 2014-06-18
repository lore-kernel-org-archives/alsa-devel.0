From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH V2 0/2] Sound support for Exynos4412 Odroid X2,
	U3 board
Date: Wed, 18 Jun 2014 18:22:29 +0200
Message-ID: <1403108551-25058-1-git-send-email-s.nawrocki__23288.6009187952$1403108606$gmane$org@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: mark.rutland@arm.com, linux-samsung-soc@vger.kernel.org, pawel.moll@arm.com, zhen1.chen@samsung.com, kyungmin.park@samsung.com, Sylwester Nawrocki <s.nawrocki@samsung.com>, galak@codeaurora.org, alsa-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
List-Id: alsa-devel@alsa-project.org

This series adds basic sound support for the Odroid X2/U3 boards.
It relies on specific Exynos Audio Subsystem clock parent and
frequencies being pre-configured.

My full testing git branch has been pushed to:
git://linuxtv.org/snawrocki/samsung.git v3.16-rc1-odroid-sound-clk

It can be browsed at:
http://git.linuxtv.org/cgit.cgi/snawrocki/samsung.git/log/?h=v3.16-rc1-odroid-sound-clk

I didn't use the simple-card since there is going to be added
one more CPU interface using the secondary I2S and IDMA.

Sylwester Nawrocki (2):
  ASoC: samsung: Add machine driver for Odroid X2/U3
  doc: dt bindings: Document Odroid X2/U3 audio subsystem bindings

 .../bindings/sound/samsung,odroidx2-max98090.txt   |   35 ++++
 sound/soc/samsung/Kconfig                          |    8 +
 sound/soc/samsung/Makefile                         |    2 +
 sound/soc/samsung/odroidx2_max98090.c              |  191 ++++++++++++++++++++
 4 files changed, 236 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/samsung,odroidx2-max98090.txt
 create mode 100644 sound/soc/samsung/odroidx2_max98090.c

--
1.7.9.5

