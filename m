From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [RESEND PATCH v4 4/4] ALSA: usb-audio: UAC3: Parse
	Input Terminal number of channels.
Date: Mon, 14 May 2018 12:03:42 +0100
Message-ID: <20180514110342.23683-1-jorge.sanjuan@codethink.co.uk>
References: <20180511152537.32267-5-jorge.sanjuan@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imap1.codethink.co.uk (imap1.codethink.co.uk [176.9.8.82])
 by alsa0.perex.cz (Postfix) with ESMTP id CAD0F266C1C
 for <alsa-devel@alsa-project.org>; Mon, 14 May 2018 13:03:55 +0200 (CEST)
In-Reply-To: <20180511152537.32267-5-jorge.sanjuan@codethink.co.uk>
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
 sound/usb/mixer.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 431f3c319839..99804cd4aed6 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -904,8 +904,12 @@ static int check_input_term(struct mixer_build *state, int id,
 				term->id = id;
 				term->type = le16_to_cpu(d->wTerminalType);
 
-				/* REVISIT: UAC3 IT doesn't have channels/cfg */
-				term->channels = 0;
+				err = get_cluster_channels_v3(state, le16_to_cpu(d->wClusterDescrID));
+				if (err < 0)
+					return err;
+				term->channels = err;
+
+				/* REVISIT: UAC3 IT doesn't have channels cfg */
 				term->chconfig = 0;
 
 				term->name = le16_to_cpu(d->wTerminalDescrStr);
-- 
2.11.0
