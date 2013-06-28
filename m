From: Kevin Hilman <khilman@linaro.org>
Subject: [PATCH 0/2] ASoc: ac97: fix multi-platform build failures
Date: Fri, 28 Jun 2013 11:17:47 -0700
Message-ID: <1372443469-20191-1-git-send-email-khilman@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
Cc: Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

When building next-20130628, I noticed a few build errors for
cm_x300_defconfig that were introduced by the new multi-platform AC'97
support.

Here's a couple fixup patches, that should maybe just be folded into
the originals, assuming they're the correct fixes.  At least it things
build again for 

Kevin


Kevin Hilman (2):
  ASoC: ac97: pxa2xx: fixup multi-platform AC'97 build failures
  ASoC: ac97: fixup multi-platform AC'97 module build failure

 sound/soc/pxa/pxa2xx-ac97.c | 2 ++
 sound/soc/pxa/pxa2xx-ac97.h | 3 ---
 sound/soc/soc-core.c        | 1 +
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.8.3
