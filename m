From: Reilly Grant <reillyeon@qotw.net>
Subject: PATCH: [plug] Move fast_ops copy after slave
	configuration.
Date: Thu, 29 Sep 2011 16:54:14 -0700
Message-ID: <4E850526.6050800@qotw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jane.qotw.net (jane.qotw.net [72.14.183.39])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C6A82445A
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Sep 2011 01:54:20 +0200 (CEST)
Received: from [192.168.17.204] (unknown [64.125.181.70])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested) (Authenticated sender: reillyeon)
	by jane.qotw.net (Postfix) with ESMTPSA id 28763539B2
	for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2011 19:54:17 -0400 (EDT)
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

The plug plugin copies the fast_ops structure and fast_op_arg from its
slave PCM on initialization and after inserting a new plugin. This works
unless the slave PCM is also an instance of the plug plugin because plug
can change its fast_ops structure during _snd_pcm_hw_params.

Instead of copying fast_ops in snd_pcm_plug_insert_plugins wait until
the end of snd_pcm_plug_hw_params when the slave has been fully
initialized.

This fixes a crash when two instances of plug are instantiated back to
back and the format conversion plugin inserted by the second is skipped
by the first because the fast_ops pointer is not properly updated.
---
 src/pcm/pcm_plug.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/pcm/pcm_plug.c b/src/pcm/pcm_plug.c
index e9d2923..72456d5 100644
--- a/src/pcm/pcm_plug.c
+++ b/src/pcm/pcm_plug.c
@@ -659,8 +659,6 @@ static int snd_pcm_plug_insert_plugins(snd_pcm_t *pcm,
 		}
 		if (err) {
 			plug->gen.slave = new;
-			pcm->fast_ops = new->fast_ops;
-			pcm->fast_op_arg = new->fast_op_arg;
 		}
 		k++;
 	}
@@ -1049,6 +1047,9 @@ static int snd_pcm_plug_hw_params(snd_pcm_t *pcm,
snd_pcm_hw_params_t *params)
 	}
 	snd_pcm_unlink_hw_ptr(pcm, plug->req_slave);
 	snd_pcm_unlink_appl_ptr(pcm, plug->req_slave);
+
+	pcm->fast_ops = slave->fast_ops;
+	pcm->fast_op_arg = slave->fast_op_arg;
 	snd_pcm_link_hw_ptr(pcm, slave);
 	snd_pcm_link_appl_ptr(pcm, slave);
 	return 0;
-- 
1.7.3.4
