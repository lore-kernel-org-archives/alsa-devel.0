From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: [PATCH 17/17]sound:core:seq:seq_ports.c Remove one to
	many n's in a word.
Date: Sat, 26 Feb 2011 20:34:10 -0800
Message-ID: <1298781250-2718-18-git-send-email-justinmattock@gmail.com>
References: <1298781250-2718-1-git-send-email-justinmattock@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2EDDA1037E3
	for <alsa-devel@alsa-project.org>; Sun, 27 Feb 2011 05:35:01 +0100 (CET)
Received: by iwc10 with SMTP id 10so2387414iwc.38
	for <alsa-devel@alsa-project.org>; Sat, 26 Feb 2011 20:34:58 -0800 (PST)
In-Reply-To: <1298781250-2718-1-git-send-email-justinmattock@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: trivial@kernel.org
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Justin P. Mattock" <justinmattock@gmail.com>
List-Id: alsa-devel@alsa-project.org

The Patch below removes one to many "n's" in a word..

Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>
CC: Jaroslav Kysela <perex@perex.cz>
CC: Takashi Iwai <tiwai@suse.de>
CC: alsa-devel@alsa-project.org
---
 sound/core/seq/seq_ports.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/core/seq/seq_ports.c b/sound/core/seq/seq_ports.c
index 3bf7d73..e12bcd9 100644
--- a/sound/core/seq/seq_ports.c
+++ b/sound/core/seq/seq_ports.c
@@ -412,7 +412,7 @@ int snd_seq_get_port_info(struct snd_seq_client_port * port,
  * initialization or termination of devices (see seq_midi.c).
  *
  * If callback_all option is set, the callback function is invoked
- * at each connnection/disconnection. 
+ * at each connection/disconnection. 
  */
 
 static int subscribe_port(struct snd_seq_client *client,
-- 
1.7.4.1
