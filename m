From: Miles Lane <miles@megapathdsl.net>
Subject: Build failure in cvs HEAD alsa-tools with kernel 2.5.5-pre1.
Date: Tue, 19 Feb 2002 00:38:03 -0800
Message-ID: <3C720EEB.30902@megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from front2.mail.megapathdsl.net (front2.mail.megapathdsl.net [66.80.60.30])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id JAA22555
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2002 09:42:31 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Jaroslav,

I got alsa-lib and alsa-utils to build fine using the new
--with-kernel=2.5.5-pre1 flag.  But, I got the following build
failure with alsa-tools:

make[2]: Entering directory `/usr/src/alsa-tools/seq/sbiload'
gcc -DPACKAGE=\"sbiload\" -DVERSION=\"0.3.0\" -DSTDC_HEADERS=1 
-DHAVE_LIBASOUND=1  -I. -I.      -Wall -g -c sbiload.c
sbiload.c:23:29: sound/ainstr_fm.h: No such file or directory
make[2]: *** [sbiload.o] Error 1
make[2]: Leaving directory `/usr/src/alsa-tools/seq/sbiload'
make[2]: Entering directory `/usr/src/alsa-tools/seq/sbiload'
gcc -DPACKAGE=\"sbiload\" -DVERSION=\"0.3.0\" -DSTDC_HEADERS=1 
-DHAVE_LIBASOUND=1  -I. -I.      -Wall -g -c sbiload.c
sbiload.c:23:29: sound/ainstr_fm.h: No such file or directory
make[2]: *** [sbiload.o] Error 1
make[2]: Leaving directory `/usr/src/alsa-tools/seq/sbiload'


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
