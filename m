From: Alexey Fisher <bug-track@fisher-privat.net>
Subject: [PATCH 2/2] Add "cval->res = 384" quirk for Logitech
	Webcam C600
Date: Thu, 10 Mar 2011 14:53:39 +0100
Message-ID: <1299765219-31386-3-git-send-email-bug-track@fisher-privat.net>
References: <1299765219-31386-1-git-send-email-bug-track@fisher-privat.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by alsa0.perex.cz (Postfix) with SMTP id BF1041037FB
	for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2011 14:54:07 +0100 (CET)
In-Reply-To: <1299765219-31386-1-git-send-email-bug-track@fisher-privat.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Alexey Fisher <bug-track@fisher-privat.net>
List-Id: alsa-devel@alsa-project.org

One more affected devices: Logitech Webcam C600 (046d:0808)

Volume range before quirk is 6400, after (also real) is 16.

Signed-off-by: Alexey Fisher <bug-track@fisher-privat.net>
---
 sound/usb/mixer.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index eba8ae8..c549522 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1122,6 +1122,7 @@ static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
 		}
 		break;
 
+	case USB_ID(0x046d, 0x0808):
 	case USB_ID(0x046d, 0x0809):
 	case USB_ID(0x046d, 0x0991):
 	/* Most audio usb devices lie about volume resolution.
-- 
1.7.1
