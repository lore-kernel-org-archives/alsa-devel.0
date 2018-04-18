From: Alberto Aguirre <albaguirre@gmail.com>
Subject: [PATCH 0/2] Add support for the Axe-Fx III implicit fb
	setup
Date: Wed, 18 Apr 2018 09:35:33 -0500
Message-ID: <20180418143535.11097-1-albaguirre@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
 [209.85.218.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 2612A266E30
 for <alsa-devel@alsa-project.org>; Wed, 18 Apr 2018 16:35:42 +0200 (CEST)
Received: by mail-oi0-f68.google.com with SMTP id n65-v6so1773178oig.6
 for <alsa-devel@alsa-project.org>; Wed, 18 Apr 2018 07:35:42 -0700 (PDT)
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
Cc: Alberto Aguirre <albaguirre@gmail.com>
List-Id: alsa-devel@alsa-project.org

Some consolidation of repeated code in set_sync_ep_implicit_fb_quirk and a 
quirk to support implicit feedback for the Axe-FX III

Alberto Aguirre (2):
  ALSA: usb-audio: simplify set_sync_ep_implicit_fb_quirk
  ALSA: usb-audio: add implicit fb quirk for Axe-Fx III

 sound/usb/pcm.c | 56 ++++++++++++++++++++++++--------------------------------
 1 file changed, 24 insertions(+), 32 deletions(-)

-- 
2.14.1
