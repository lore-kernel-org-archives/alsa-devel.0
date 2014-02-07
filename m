From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v3 0/2] *** SUBJECT HERE ***
Date: Fri, 7 Feb 2014 18:09:46 +0100
Message-ID: <cover.1391792986.git.moinejf@free.fr>
Return-path: <linux-media-owner@vger.kernel.org>
Sender: linux-media-owner@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>, devel@driverdev.osuosl.org
Cc: alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dri-devel@lists.freedesktop.org, Takashi Iwai <tiwai@suse.de>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>
List-Id: alsa-devel@alsa-project.org

*** BLURB HERE ***

Jean-Francois Moine (2):
  drivers/base: permit base components to omit the bind/unbind ops
  drivers/base: declare phandle DT nodes as components

 drivers/base/component.c | 21 +++++++++++++++++++--
 drivers/base/core.c      | 18 ++++++++++++++++++
 include/linux/of.h       |  2 ++
 3 files changed, 39 insertions(+), 2 deletions(-)

-- 
1.9.rc1
