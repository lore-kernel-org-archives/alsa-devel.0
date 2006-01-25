From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: [PATCH] Remove bogus assert
Date: Wed, 25 Jan 2006 20:29:35 +0100
Message-ID: <43D7D19F.9070509@drzeus.cx>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hermes.drzeus.cx-7963-1138217376-0001-2"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hermes.drzeus.cx-7963-1138217376-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Freeing the global config update structure when it had been created
without any configs present caused an assertion to trigger. Since this
is a valid scenario and the assertion didn't really protect against
anything, it should simply be removed. Attached patch does exactly that.

Rgds
Pierre


--=_hermes.drzeus.cx-7963-1138217376-0001-2
Content-Type: text/x-patch; name="alsa-badassert.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-badassert.patch"

--- alsa-lib-1.0.10.orig/src/conf.c	2005-10-12 18:08:53.000000000 +0200
+++ alsa-lib-1.0.10/src/conf.c	2006-01-25 20:18:30.000000000 +0100
@@ -3106,7 +3106,6 @@
 	unsigned int k;
 
 	assert(update);
-	assert(update->count > 0 && update->finfo);
 	for (k = 0; k < update->count; k++)
 		free(update->finfo[k].name);
 	if (update->finfo)

--=_hermes.drzeus.cx-7963-1138217376-0001-2--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
