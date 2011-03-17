From: sudarshan.bisht@nokia.com
Subject: [PATCH 1/1] alsa-lib: fixed coverity reported issues
	under "REVERSE_INULL" checker.
Date: Thu, 17 Mar 2011 11:28:07 +0200
Message-ID: <1300354087-755-2-git-send-email-sudarshan.bisht@nokia.com>
References: <1300354087-755-1-git-send-email-sudarshan.bisht@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da02.nokia.com (smtp.nokia.com [147.243.128.26])
	by alsa0.perex.cz (Postfix) with ESMTP id E12DB103974
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 10:29:44 +0100 (CET)
Received: from localhost.localdomain (esdhcp-heru02554.research.nokia.com
	[172.21.25.54])
	by mgw-da02.nokia.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id
	p2H9TfpH013393
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 11:29:43 +0200
In-Reply-To: <1300354087-755-1-git-send-email-sudarshan.bisht@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Sudarshan <sudarshan.bisht@nokia.com>

---
 src/control/setup.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/control/setup.c b/src/control/setup.c
index eecda45..79f2b76 100644
--- a/src/control/setup.c
+++ b/src/control/setup.c
@@ -398,7 +398,7 @@ static int snd_config_get_ctl_elem_value(snd_config_t *conf,
 
 static int add_elem(snd_sctl_t *h, snd_config_t *_conf, snd_config_t *private_data)
 {
-	snd_config_t *conf;
+	snd_config_t *conf = NULL ;
 	snd_config_iterator_t i, next;
 	char *tmp;
 	int iface = SND_CTL_ELEM_IFACE_MIXER;
@@ -415,6 +415,7 @@ static int add_elem(snd_sctl_t *h, snd_config_t *_conf, snd_config_t *private_da
 	err = snd_config_expand(_conf, _conf, NULL, private_data, &conf);
 	if (err < 0)
 		return err;
+	assert(conf);
 	snd_config_for_each(i, next, conf) {
 		snd_config_t *n = snd_config_iterator_entry(i);
 		const char *id;
-- 
1.7.0.4
