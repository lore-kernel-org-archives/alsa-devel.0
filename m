From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: [PATCH alsa-lib] Fix build error with
	-Werror=format-security
Date: Mon, 9 Feb 2009 17:18:49 -0200
Message-ID: <200902091718.49574.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C779103829
	for <alsa-devel@alsa-project.org>; Mon,  9 Feb 2009 20:18:35 +0100 (CET)
Received: from localhost (perninha.conectiva.com.br [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 083613EA6
	for <alsa-devel@alsa-project.org>; Mon,  9 Feb 2009 14:18:51 -0500 (EST)
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new,
	port 10025)
	with LMTP id mFajd860IGZM for <alsa-devel@alsa-project.org>;
	Mon,  9 Feb 2009 14:18:50 -0500 (EST)
Received: from fox.conectiva (fox.conectiva [10.0.2.195])
	by perninha.conectiva.com.br (Postfix) with ESMTP id AE9973EA4
	for <alsa-devel@alsa-project.org>; Mon,  9 Feb 2009 14:18:50 -0500 (EST)
Received: from gotham.conectiva (gotham.conectiva [10.0.2.23])
	by fox.conectiva (Postfix) with ESMTP id DC34F2F0E3
	for <alsa-devel@alsa-project.org>; Mon,  9 Feb 2009 16:18:33 -0300 (BRT)
Content-Disposition: inline
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

src/alisp/alisp.c (F_princ): add missing format argument in call to
snd_output_printf

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
---
 src/alisp/alisp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/alisp/alisp.c b/src/alisp/alisp.c
index 4ad1d09..de3defb 100644
--- a/src/alisp/alisp.c
+++ b/src/alisp/alisp.c
@@ -1708,7 +1708,7 @@ static struct alisp_object * F_princ(struct alisp_instance *instance, struct ali
 			delete_tree(instance, p1);
 		p1 = eval(instance, car(p));
 		if (alisp_compare_type(p1, ALISP_OBJ_STRING))
-			snd_output_printf(instance->out, p1->value.s);
+			snd_output_printf(instance->out, "%s", p1->value.s);
 		else
 			princ_object(instance->out, p1);
 		n = cdr(p);
-- 
1.6.1.3
