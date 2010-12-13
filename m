From: Joe Perches <joe@perches.com>
Subject: [PATCH 0/5] trivia: Use vsprintf extension %pR
Date: Mon, 13 Dec 2010 13:42:17 -0800
Message-ID: <cover.1292276119.git.joe@perches.com>
Return-path: <linux-parisc-owner@vger.kernel.org>
Sender: linux-parisc-owner@vger.kernel.org
To: linux-parisc@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Randy Dunlap <randy.dunlap@oracle.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Joe Perches (5):
  ste_dma40.c: Use vsprintf extension %pR for struct resource
  lba_pci.c: Use vsprintf extension %pR for struct resource
  samsung.c: Use vsprintf extension %pR for struct resource
  mx3fb.c: Use vsprintf extension %pR for struct resource
  ml403-ac97cr.c: Use vsprintf extension %pR for struct resource

 drivers/dma/ste_dma40.c      |    5 ++---
 drivers/parisc/lba_pci.c     |   13 +++++--------
 drivers/serial/samsung.c     |    2 +-
 drivers/video/mx3fb.c        |    3 +--
 sound/drivers/ml403-ac97cr.c |    4 ++--
 5 files changed, 11 insertions(+), 16 deletions(-)

-- 
1.7.3.3.398.g0b0cd.dirty

