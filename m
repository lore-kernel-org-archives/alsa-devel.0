From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [PATCH v4 4/4] ALSA: usb-audio: UAC3: Parse Input
	Terminal number of channels.
Date: Fri, 11 May 2018 16:25:37 +0100
Message-ID: <20180511152537.32267-5-jorge.sanjuan@codethink.co.uk>
References: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
 <20180511152537.32267-1-jorge.sanjuan@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imap1.codethink.co.uk (imap1.codethink.co.uk [176.9.8.82])
 by alsa0.perex.cz (Postfix) with ESMTP id 737A02677D7
 for <alsa-devel@alsa-project.org>; Fri, 11 May 2018 17:25:48 +0200 (CEST)
In-Reply-To: <20180511152537.32267-1-jorge.sanjuan@codethink.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com
Cc: gregkh@linuxfoundation.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>, ruslan.bilovol@gmail.com
List-Id: alsa-devel@alsa-project.org

Obtain the number of channels for the Input Terminal from the
Logical Cluster Descriptor. This achieves a useful minimal parsing
of this unit so it can be used in other units in the topology.

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 sound/usb/mixer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 431f3c319839..19b25fbc7437 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -903,9 +903,9 @@ static int check_input_term(struct mixer_build *state, int id,
 				 * recursion calls */
 				term->id = id;
 				term->type = le16_to_cpu(d->wTerminalType);
+				term->channels = get_cluster_channels_v3(state, d->wClusterDescrID);
 
-				/* REVISIT: UAC3 IT doesn't have channels/cfg */
-				term->channels = 0;
+				/* REVISIT: UAC3 IT doesn't have channels cfg */
 				term->chconfig = 0;
 
 				term->name = le16_to_cpu(d->wTerminalDescrStr);
-- 
2.11.0
