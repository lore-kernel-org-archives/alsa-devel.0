From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH lib] control: complement comment for subscribe
	API
Date: Tue, 10 Feb 2015 00:18:42 +0900
Message-ID: <1423495122-24893-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: o-takashi@sakamocchi.jp, tiwai@alsa-project.org, clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, Takashi Sakamoto <mocchi@Mocchi64.miraclelinux.com>
List-Id: alsa-devel@alsa-project.org

From: Takashi Sakamoto <mocchi@Mocchi64.miraclelinux.com>

When minus value is given as a parameter, the API returns whether
the caller has already subscribed or not.

This commit adds a comment about this so as better documentation.

Signed-off-by: Takashi Sakamoto <mocchi@Mocchi64.miraclelinux.com>
---
 src/control/control.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/control/control.c b/src/control/control.c
index dd428a1..4a28cf6 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -213,7 +213,7 @@ int snd_ctl_poll_descriptors_revents(snd_ctl_t *ctl, struct pollfd *pfds, unsign
 /**
  * \brief Ask to be informed about events (poll, #snd_async_add_ctl_handler, #snd_ctl_read)
  * \param ctl CTL handle
- * \param subscribe 0 = unsubscribe, 1 = subscribe
+ * \param subscribe 0 = unsubscribe, 1 = subscribe, -1 = check subscribe or not
  * \return 0 on success otherwise a negative error code
  */
 int snd_ctl_subscribe_events(snd_ctl_t *ctl, int subscribe)
-- 
2.1.0
