From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: CVS does not compile
Date: Tue, 15 Feb 2005 18:41:33 -0500
Message-ID: <1108510893.3772.9.camel@krustophenia.net>
References: <1108501339.3772.5.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <1108501339.3772.5.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2005-02-15 at 16:02 -0500, Lee Revell wrote:
> from /smb/rlrevell/cvs/alsa-default-2/alsa-driver/acore/hwdep.c:28:
> include/linux/pm.h:198: error: redefinition of `pm_message_t'
> /smb/rlrevell/cvs/alsa-default-2/alsa-driver/include/adriver.h:717:
> error: `pm_message_t' previously declared here

If I back out this patch it works fine.

Lee

Index: include/adriver.h
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/include/adriver.h,v
retrieving revision 1.105
retrieving revision 1.106
diff -u -u -r1.105 -r1.106
--- include/adriver.h	7 Feb 2005 08:29:13 -0000	1.105
+++ include/adriver.h	14 Feb 2005 13:55:43 -0000	1.106
@@ -712,7 +712,8 @@
 #endif
 
 /* pm_message_t type */
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 11)
+/* #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 11) */
+#ifndef PMSG_FREEZE
 typedef u32 /*__bitwise*/ pm_message_t;
 #define PMSG_FREEZE	3
 #define PMSG_SUSPEND	3



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
