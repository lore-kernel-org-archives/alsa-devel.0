From: Anssi Hannula <anssi.hannula@mbnet.fi>
Subject: [PATCH] Change the freq limit of speaker-test
Date: Fri, 17 Jun 2005 21:14:48 +0300
Message-ID: <42B31318.1020705@mbnet.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080402040205000408060208"
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

This is a multi-part message in MIME format.
--------------080402040205000408060208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

I noticed that the speaker-test has limited sine wave frequency to 
50-5000 Hz. Attached patch changes that to 0-24575Hz (that's the limit 
at least here (x86-64) after which the freq would roll over to 0 Hz).

ps. I'm not subscribed, CC me when replying.

-- 
Anssi Hannula


--------------080402040205000408060208
Content-Type: text/x-patch;
 name="speaker-test_changelimits.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="speaker-test_changelimits.diff"

Index: alsa-utils/speaker-test/speaker-test.c
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/speaker-test/speaker-test.c,v
retrieving revision 1.8
diff -u -r1.8 speaker-test.c
--- alsa-utils/speaker-test/speaker-test.c	3 May 2005 18:36:08 -0000	1.8
+++ alsa-utils/speaker-test/speaker-test.c	17 Jun 2005 18:07:34 -0000
@@ -532,8 +532,8 @@
       break;
     case 'f':
       freq = atoi(optarg);
-      freq = freq < 50 ? 50 : freq;
-      freq = freq > 5000 ? 5000 : freq;
+      freq = freq < 0 ? 0 : freq;
+      freq = freq > 24575 ? 24575 : freq;
       break;
     case 'b':
       buffer_time = atoi(optarg);

--------------080402040205000408060208--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
