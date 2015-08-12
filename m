From: Julian Scheel <julian@jusst.de>
Subject: [PATCH] ALSA: usb-audio: Recurse before saving
	terminal properties
Date: Wed, 12 Aug 2015 22:14:59 +0200
Message-ID: <1439410499-28630-1-git-send-email-julian@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender163-mail.zoho.com (sender163-mail.zoho.com
 [74.201.84.163])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F2D1260462
 for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2015 22:15:11 +0200 (CEST)
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
Cc: Julian Scheel <julian@jusst.de>
List-Id: alsa-devel@alsa-project.org

When the descriptor parser recurses into the clock source descriptor, the
terminals properties, like name and type, are set to the values of the clock
selector as check_input_term overwrites term->name and others in the recursive
call. As we want to only fill missing values using the descriptors higher in
the recursion tree the properties taken from the actual descriptor must be
applied after recursing.

Signed-off-by: Julian Scheel <julian@jusst.de>
---
 sound/usb/mixer.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 6b3acba..4a49944 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -715,15 +715,16 @@ static int check_input_term(struct mixer_build *state, int id,
 				term->name = d->iTerminal;
 			} else { /* UAC_VERSION_2 */
 				struct uac2_input_terminal_descriptor *d = p1;
-				term->type = le16_to_cpu(d->wTerminalType);
-				term->channels = d->bNrChannels;
-				term->chconfig = le32_to_cpu(d->bmChannelConfig);
-				term->name = d->iTerminal;
 
 				/* call recursively to get the clock selectors */
 				err = check_input_term(state, d->bCSourceID, term);
 				if (err < 0)
 					return err;
+
+				term->type = le16_to_cpu(d->wTerminalType);
+				term->channels = d->bNrChannels;
+				term->chconfig = le32_to_cpu(d->bmChannelConfig);
+				term->name = d->iTerminal;
 			}
 			return 0;
 		case UAC_FEATURE_UNIT: {
-- 
2.5.0
