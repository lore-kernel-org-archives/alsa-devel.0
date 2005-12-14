From: Dirk Jagdmann <doj@cubic.org>
Subject: [patch] envy24control: missing command line option helptext
Date: Wed, 14 Dec 2005 15:51:04 +0100
Message-ID: <43A03158.7070406@cubic.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050004060504070303090605"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from roasted.cubic.org (roasted.cubic.org [193.108.181.130])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 374FD18A
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2005 15:51:06 +0100 (MET)
Received: from d010088.adsl.hansenet.de ([80.171.10.88] helo=mrmucke.doj)
	by roasted.cubic.org with esmtp (Exim 3.36 #1)
	id 1EmXyD-0001gY-00
	for alsa-devel@alsa-project.org; Wed, 14 Dec 2005 15:51:05 +0100
Received: from [192.168.0.3] (helo=[192.168.0.3])
	by mrmucke.doj with esmtp (Exim 3.36 #1)
	id 1EmXyC-0001CP-00
	for alsa-devel@alsa-project.org; Wed, 14 Dec 2005 15:51:04 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050004060504070303090605
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hello developers,

this patch adds the help description of the "-M" command line option.

-- 
---> Dirk Jagdmann ^ doj / cubic
----> http://cubic.org/~doj
-----> http://llg.cubic.org

--------------050004060504070303090605
Content-Type: text/plain;
 name="e24c-help.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="e24c-help.patch"

Index: envy24control.c
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/envy24control/envy24control.c,v
retrieving revision 1.40
diff -u -r1.40 envy24control.c
--- envy24control.c	8 Dec 2005 16:36:12 -0000	1.40
+++ envy24control.c	14 Dec 2005 14:49:34 -0000
@@ -1877,6 +1877,7 @@
 	fprintf(stderr, "\t-v, --view_spdif_playback\tshows the spdif playback channels in the mixer\n");
 	fprintf(stderr, "\t-f, --profiles_file\tuse file as profiles file\n");
 	fprintf(stderr, "\t-m, --midichannel\tmidi channel number for controller control\n");
+	fprintf(stderr, "\t-M, --midienhanced\tUse an enhanced mapping from midi controller to db slider\n");
 }
 
 int main(int argc, char **argv)

--------------050004060504070303090605--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
