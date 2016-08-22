From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH 3/3] ALSA: usb: fine-tune Tenor error
	compensation value
Date: Mon, 22 Aug 2016 08:53:38 +0200
Message-ID: <1471848818-11860-3-git-send-email-daniel@zonque.org>
References: <1471848818-11860-1-git-send-email-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 1277D2666D6
 for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2016 08:53:50 +0200 (CEST)
In-Reply-To: <1471848818-11860-1-git-send-email-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: norman.nolte@gmx.net, T.Gresens@intershop.de, clemens@ladisch.de, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Users of devices affected by the Tenor feedback data error report
buffer underruns, even with the +/- 0x1.0000 quirk applied.
Compensating the error with 0xf000 instead seems to reliably fix
that issue.

See

  https://sourceforge.net/p/alsa/mailman/message/35230259/

Reported-and-tested-by: Norman Nolte <norman.nolte@gmx.net>
Reported-and-tested-by: Thomas Gresens <T.Gresens@intershop.de>
Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 sound/usb/endpoint.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index c317a8d..c470251 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -1174,9 +1174,9 @@ void snd_usb_handle_sync_urb(struct snd_usb_endpoint *ep,
 		 * by +/- 0x1.0000.
 		 */
 		if (f < ep->freqn - 0x8000)
-			f += 0x10000;
+			f += 0xf000;
 		else if (f > ep->freqn + 0x8000)
-			f -= 0x10000;
+			f -= 0xf000;
 	} else if (unlikely(ep->freqshift == INT_MIN)) {
 		/*
 		 * The first time we see a feedback value, determine its format
-- 
2.5.5
