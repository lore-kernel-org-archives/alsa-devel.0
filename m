From: Ondrej Zary <linux@rainbow-software.org>
Subject: [PATCH 0/2] tea575x: Move from sound to media
Date: Sun, 28 Jul 2013 22:01:42 +0200
Message-ID: <1375041704-17928-1-git-send-email-linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-1.atlantis.sk (mail-1.atlantis.sk [80.94.52.57])
 by alsa0.perex.cz (Postfix) with ESMTP id 191A1261982
 for <alsa-devel@alsa-project.org>; Sun, 28 Jul 2013 22:02:19 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: alsa-devel@alsa-project.org, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


Hello,
TEA575x is neither a sound device nor an i2c device. Let's finally move it 
from sound/i2c/other to drivers/media/radio.

Tested with snd-es1968, snd-fm801 and radio-sf16fmr2.

-- 
Ondrej Zary
