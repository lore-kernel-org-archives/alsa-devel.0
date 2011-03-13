From: pbruskispam@op.pl
Subject: [PATCH - ctxfi driver 4/4] Fix: clear input settings
	before initialization
Date: Sun, 13 Mar 2011 16:18:58 +0100
Message-ID: <1300029538-3147-4-git-send-email-pbruskispam@op.pl>
References: <1300029538-3147-1-git-send-email-pbruskispam@op.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1300029538-3147-1-git-send-email-pbruskispam@op.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Przemyslaw Bruski <pbruskispam@op.pl>
List-Id: alsa-devel@alsa-project.org

From: Przemyslaw Bruski <pbruskispam@op.pl>


Signed-off-by: Przemyslaw Bruski <pbruskispam@op.pl>

diff --git a/pci/ctxfi/ctdaio.c b/pci/ctxfi/ctdaio.c
index af56eb9..47d9ea9 100644
--- a/pci/ctxfi/ctdaio.c
+++ b/pci/ctxfi/ctdaio.c
@@ -176,6 +176,7 @@ static int dao_set_left_input(struct dao *dao, struct rsc *input)
 	if (!entry)
 		return -ENOMEM;
 
+	dao->ops->clear_left_input(dao);
 	/* Program master and conjugate resources */
 	input->ops->master(input);
 	daio->rscl.ops->master(&daio->rscl);
@@ -204,6 +205,7 @@ static int dao_set_right_input(struct dao *dao, struct rsc *input)
 	if (!entry)
 		return -ENOMEM;
 
+	dao->ops->clear_right_input(dao);
 	/* Program master and conjugate resources */
 	input->ops->master(input);
 	daio->rscr.ops->master(&daio->rscr);
-- 
1.7.1
