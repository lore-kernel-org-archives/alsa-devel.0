From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: [PATCH: alsa-lib] Fix a string format ambiguity
Date: Sat, 17 Apr 2010 10:49:55 +0100
Message-ID: <hqc085$ft8$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090705070402050500050407"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id AE95110380F
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Apr 2010 11:50:09 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1O34f9-0000Au-QV
	for alsa-devel@alsa-project.org; Sat, 17 Apr 2010 11:50:07 +0200
Received: from cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	([94.173.13.3]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 17 Apr 2010 11:50:07 +0200
Received: from gmane by cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 17 Apr 2010 11:50:07 +0200
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

This is a multi-part message in MIME format.
--------------090705070402050500050407
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Simply patch to fix a format-string ambiguity.

Meant to give this over before 1.0.23 but forgot.

Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mandriva Linux Contributor [http://www.mandriva.com/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]

--------------090705070402050500050407
Content-Type: text/x-patch;
 name="0501-Fix-a-string-format-ambiguity.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0501-Fix-a-string-format-ambiguity.patch"

>From a57b4e4d1433d14e6fda9b675ade7e901222381b Mon Sep 17 00:00:00 2001
From: Colin Guthrie <cguthrie@mandriva.org>
Date: Sun, 28 Feb 2010 22:25:26 +0000
Subject: [PATCH 501/501] Fix a string format ambiguity

---
 src/alisp/alisp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/alisp/alisp.c b/src/alisp/alisp.c
index f3580f9..7575f55 100644
--- a/src/alisp/alisp.c
+++ b/src/alisp/alisp.c
@@ -1712,7 +1712,7 @@ static struct alisp_object * F_princ(struct alisp_instance *instance, struct ali
 			delete_tree(instance, p1);
 		p1 = eval(instance, car(p));
 		if (alisp_compare_type(p1, ALISP_OBJ_STRING))
-			snd_output_printf(instance->out, p1->value.s);
+			snd_output_printf(instance->out, "%s", p1->value.s);
 		else
 			princ_object(instance->out, p1);
 		n = cdr(p);
-- 
1.7.0


--------------090705070402050500050407
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------090705070402050500050407--
