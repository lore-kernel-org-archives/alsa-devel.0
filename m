From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: alsa-driver CVS configure.in broken
Date: Sat, 6 Nov 2004 11:57:13 +0000 (GMT)
Message-ID: <20041106115713.95297.qmail@web52908.mail.yahoo.com>
References: <1099705381.1461.5.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1099705381.1461.5.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

 --- Lee Revell <rlrevell@joe-job.com> wrote: 
> Can you send a patch with the change?  I have been
> having problems building from CVS also.

My email client will probably mangle this, but you get
the idea:

Index: alsa-driver/configure.in
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/configure.in,v
retrieving revision 1.274
diff -u -u -r1.274 configure.in
--- alsa-driver/configure.in    28 Oct 2004 09:14:49
-0000      1.274
+++ alsa-driver/configure.in    6 Nov 2004 11:56:17
-0000
@@ -1900,7 +1900,7 @@
   echo "Hacking autoconf.h..."
   rm -f include/linux/autoconf.h
   mkdir -p include/linux
-  grep -v CONFIG_SND_
$CONFIG_SND_KERNELDIR/include/linux/autoconf.h >
include/linux/autoconf.h
+  grep -v CONFIG_SND_
$kernelbuild/include/linux/autoconf.h >
include/linux/autoconf.h
   cat include/autoconf-extra.h >>
include/linux/autoconf.h
   cat include/config1.h >> include/linux/autoconf.h
 else



	
	
		
___________________________________________________________ALL-NEW Yahoo! Messenger - all new features - even more fun! http://uk.messenger.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
