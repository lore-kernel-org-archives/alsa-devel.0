From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] amidi output file permissions
Date: Mon, 12 Jan 2004 18:03:05 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0401121758340.23817-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: andreas@huennebeck-online.de
List-Id: alsa-devel@alsa-project.org


set file permission bits for output file


Index: alsa-utils/amidi/amidi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/amidi/amidi.c,v
retrieving revision 1.2
diff -u -r1.2 amidi.c
--- alsa-utils/amidi/amidi.c	5 Nov 2003 11:08:25 -0000	1.2
+++ alsa-utils/amidi/amidi.c	12 Jan 2004 16:57:42 -0000
@@ -450,7 +450,7 @@
 		return 1;

 	if (receive_file_name) {
-		receive_file = creat(receive_file_name, 0);
+		receive_file = creat(receive_file_name, 0666);
 		if (receive_file == -1) {
 			error("cannot create %s: %s", receive_file_name, strerror(errno));
 			return -1;






-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
