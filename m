From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/3] ALSA: usb-us122l: compatible ioctl support
	and fix sparse warnings
Date: Thu, 28 Jul 2016 00:06:45 +0900
Message-ID: <1469632008-29710-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id C34F72672A1
 for <alsa-devel@alsa-project.org>; Wed, 27 Jul 2016 17:06:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset is to fix some sparse warnings in ALSA USB US122L module.
Additionally, compatible ioctl is supported.

Takashi Sakamoto (3):
  usb-us122l: replace 'unsigned' with 'unsigned int'
  usb-us122l: add support for compatible ioctl
  usb-us122l: add qualifier into pointer to userspace

 sound/usb/usx2y/us122l.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

-- 
2.7.4
