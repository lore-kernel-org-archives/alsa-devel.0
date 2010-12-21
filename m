From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 07/11] ucm: check for valid value list before
	dereference.
Date: Tue, 21 Dec 2010 22:11:56 +0000
Message-ID: <1292969520-18047-8-git-send-email-lrg@slimlogic.co.uk>
References: <1292969520-18047-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4CB3A103A51
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 23:12:23 +0100 (CET)
Received: by mail-ww0-f51.google.com with SMTP id 15so4322500wwe.20
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 14:12:23 -0800 (PST)
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
 src/ucm/main.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/ucm/main.c b/src/ucm/main.c
index 403f5c5..3a61679 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -959,6 +959,9 @@ static int get_value1(const char **value, struct list_head *value_list,
         struct ucm_value *val;
         struct list_head *pos;
         
+	if (!value_list)
+		return -ENOENT;
+
         list_for_each(pos, value_list) {
               val = list_entry(pos, struct ucm_value, list);
               if (check_identifier(identifier, val->name)) {
-- 
1.7.1
