From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 11/11] ucm: ctlparse - always terminate cset
	buffer
Date: Tue, 21 Dec 2010 22:12:00 +0000
Message-ID: <1292969520-18047-12-git-send-email-lrg@slimlogic.co.uk>
References: <1292969520-18047-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id EFD8F103A60
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 23:12:28 +0100 (CET)
Received: by mail-ww0-f51.google.com with SMTP id 15so4322500wwe.20
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 14:12:28 -0800 (PST)
In-Reply-To: <1292969520-18047-1-git-send-email-lrg@slimlogic.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 src/control/ctlparse.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/control/ctlparse.c b/src/control/ctlparse.c
index c8300f3..a929816 100644
--- a/src/control/ctlparse.c
+++ b/src/control/ctlparse.c
@@ -208,8 +208,8 @@ int snd_ctl_ascii_elem_id_parse(snd_ctl_elem_id_t *dst, const char *str)
 					}
 					str++;
 				}
-				*ptr = '\0';
 			}
+			*ptr = '\0';
 			snd_ctl_elem_id_set_name(dst, buf);
 		} else if (!strncasecmp(str, "index=", 6)) {
 			str += 6;
-- 
1.7.1
