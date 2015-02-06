From: Abhilash Kesavan <a.kesavan@samsung.com>
Subject: [PATCH v2 0/3] Switch to ioremap_wc in the SRAM allocator code
Date: Fri,  6 Feb 2015 19:15:25 +0530
Message-ID: <1423230328-6721-1-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, hirokazu.takata.wj@renesas.com
Cc: catalin.marinas@arm.com, Will.Deacon@arm.com, heiko@sntech.de, shc_work@mail.ru, p.zabel@pengutronix.de, nicoleotsuka@gmail.com, padma.v@samsung.com, arnd@arndb.de, alsa-devel@alsa-project.org, shawn.guo@linaro.org, bcousson@baylibre.com, tony@atomide.com, kernel@pengutronix.de, kgene@kernel.org
List-Id: alsa-devel@alsa-project.org

Fix alignment faults seen during play-back of files with specific
sampling rates such as 44.1K. This is based on the discussion here:
http://www.spinics.net/lists/arm-kernel/msg384647.html

Patch 1 is needed as m32r arch does not define ioremap_wc. Patch 2 adds a
resource managed helper function for ioremap_wc which is used in patch 3.

Changes since v1:
	- Fix the compilation error with m32r due to missing ioremap_wc
	definition.
	- Fixed minor indentation issues.

Note: Other architectures either have ioremap_wc defined or are including
generic "io.h"/"iomap.h". c6x arch is the only one I am not sure of.

Abhilash Kesavan (3):
  m32r: add definition of ioremap_wc to io.h
  lib: devres: add a helper function for ioremap_wc
  misc: sram: switch to ioremap_wc from ioremap

 Documentation/driver-model/devres.txt |    1 +
 arch/m32r/include/asm/io.h            |    1 +
 drivers/misc/sram.c                   |   17 ++++++++++++++---
 include/linux/io.h                    |    2 ++
 lib/devres.c                          |   28 ++++++++++++++++++++++++++++
 5 files changed, 46 insertions(+), 3 deletions(-)

-- 
1.7.9.5
