From: Will Wagner <will_wagner@carallon.com>
Subject: Cross compile issues with alsa-utils
Date: Thu, 15 Jan 2009 11:11:38 +0000
Message-ID: <496F19EA.6000001@carallon.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080705070704080400070201"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from carallon.f9.co.uk (carallon.force9.co.uk [80.229.37.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 88886243E5
	for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2009 12:11:44 +0100 (CET)
Received: from [127.0.0.1] by carallon.f9.co.uk (MDaemon PRO v9.6.5)
	with ESMTP id md50000334863.msg
	for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2009 11:11:42 +0000
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
--------------080705070704080400070201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

I have been cross compiling alsa-utils with buildroot (www.buildroot.org) and have run 
into two issues.

The first is that alsactl is using index & rindex which are legacy functions not supported 
with all cross compile toolchains. Attached is a patch to replace the calls with strchr 
and strrchr.

The second issue is again with alsactl. It is trying to generate the alsactl_init.7 man 
page but I do not have xmlto to convert it to a man page. Could a configure option be 
added to not build any docs - similar to alsa-lib configure.

Thanks,

Will.
-- 
------------------------------------------------------------------------
Will Wagner                                     will_wagner@carallon.com
Development Manager                      Office Tel: +44 (0)20 7371 2032
Carallon Ltd, Studio G20, Shepherds Building, Rockley Rd, London W14 0DA
------------------------------------------------------------------------

--------------080705070704080400070201
Content-Type: text/plain;
 name="alsa-utils-1.0.18-fix_sysv_legacy.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-utils-1.0.18-fix_sysv_legacy.patch"

--- a/alsactl/init_parse.c	2009-01-15 10:44:48.000000000 +0000
+++ b/alsactl/init_parse.c	2009-01-15 10:46:41.000000000 +0000
@@ -381,7 +381,7 @@ static int set_ctl_value(struct space *s
 				snd_ctl_elem_value_set_integer(space->ctl_value, idx, val);
 			} else if (items > 2 && value[items-2] == 'd' && value[items-1] == 'B') {
 				val = strtol(value, NULL, 0) * 100;
-				if ((pos2 = index(value, '.')) != NULL) {
+				if ((pos2 = strchr(value, '.')) != NULL) {
 					if (isdigit(*(pos2-1)) && isdigit(*(pos2-2))) {
 						if (val < 0)
 							val -= strtol(pos2 + 1, NULL, 0);
@@ -1253,7 +1253,7 @@ static char *new_root_dir(const char *fi
 
 	res = strdup(filename);
 	if (res) {
-		tmp = rindex(res, '/');
+		tmp = strrchr(res, '/');
 		if (tmp)
 			*tmp = '\0';
 	}

--------------080705070704080400070201
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------080705070704080400070201--
