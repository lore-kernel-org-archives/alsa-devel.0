From: Pavel Roskin <proski@gnu.org>
Subject: Re: Fix for mmap_test, better tests needed
Date: Mon, 12 Aug 2002 17:12:15 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0208121711290.14287-100000@marabou.research.att.com>
References: <Pine.LNX.4.44.0208121541210.14146-100000@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0208121541210.14146-100000@marabou.research.att.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> Now mmap_test compiles without warnings and produces funky sounds.  
> Enjoy!

Sorry, forgot the patch:

==========================
--- alsa-driver/test/Makefile
+++ alsa-driver/test/Makefile
@@ -14,7 +14,7 @@
 	$(CC) $(CFLAGS) -o ossdelay ossdelay.c
 
 mmap_test: mmap_test.c
-	$(CC) $(CFLAGS) -DVERBOSE -o mmap_test mmap_test.c
+	$(CC) $(CFLAGS) -DVERBOSE -o mmap_test mmap_test.c -lm
 
 clean:
 	rm -f *.o $(TARGETS) *~
--- alsa-driver/test/mmap_test.c
+++ alsa-driver/test/mmap_test.c
@@ -16,21 +16,24 @@
 #include <stdio.h>
 #include <unistd.h>
 #include <fcntl.h>
+#include <stdlib.h>
+#include <string.h>
+#include <math.h>
+#include <sys/ioctl.h>
 #include <sys/types.h>
 #include <sys/mman.h>
 #include <sys/soundcard.h>
 #include <sys/time.h>
 
-main()
+int main(int args, char **argv)
 {
-	int fd, sz, fsz, i, tmp, n, l, have_data=0, nfrag;
+	int fd, sz, fsz, i, tmp, nfrag;
         int caps, idx;
 
 	int sd, sl=0, sp;
 
 	unsigned char data[500000], *dp = data;
 
-	struct buffmem_desc imemd, omemd;
         caddr_t buf;
 	struct timeval tim;
 
@@ -60,14 +63,21 @@ main()
  * Load some test data.
  */
 
-  sl = sp = 0;
-  if ((sd=open("smpl", O_RDONLY, 0))!=-1)
-  {
-	sl = read(sd, data, sizeof(data));
-	printf("%d bytes read from file.\n", sl);
-	close(sd);
-  }
-  else perror("smpl");
+	sl = sp = 0;
+	if ((sd=open("smpl", O_RDONLY, 0))!=-1)
+	{
+		sl = read(sd, data, sizeof(data));
+		printf("%d bytes read from file.\n", sl);
+		close(sd);
+	}
+	else
+	{
+		perror("smpl");
+		printf("Using generated sample\n");
+		for (i = 0; i < sizeof(data); i++) {
+			data[i] = (unsigned char) ((1+sin(i*(4+i/1000)))*127);
+		}
+	}
 
 	if (ioctl(fd, SNDCTL_DSP_GETCAPS, &caps)==-1)
 	{
@@ -104,7 +114,7 @@ main()
  * select call returns.
  */
 
-	ioctl(fd, SNDCTL_DSP_SETPERIOD, &frag);
+	ioctl(fd, SNDCTL_DSP_SETFRAGMENT, &frag);
 
 /*
  * Compute total size of the buffer. It's important to use this value
@@ -121,7 +131,7 @@ main()
 	fsz = info.fragsize;
 	printf( "info.fragstotal = %i\n", info.fragstotal );
 	printf( "info.fragsize = %i\n", info.fragsize );
-	printf( "info.periods = %i\n", info.periods );
+	printf( "info.fragsize = %i\n", info.fragsize );
 	printf( "info.bytes = %i\n", info.bytes );
 
 /*
@@ -154,7 +164,7 @@ main()
 		perror("mmap (write)");
 		exit(-1);
 	}
-	printf("mmap (out) returned %08x\n", buf);
+	printf("mmap (out) returned %p\n", buf);
 #else
         buf=data;
 #endif
@@ -198,7 +208,7 @@ main()
 	for (idx=0; idx<40; idx++)
 	{
 		struct count_info count;
-		int p, l, extra;
+		int extra;
 
 		FD_ZERO(&writeset);
 		FD_SET(fd, &writeset);
==========================

-- 
Regards,
Pavel Roskin



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
