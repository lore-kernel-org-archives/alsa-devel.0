From: Anssi Hannula <anssi.hannula@mbnet.fi>
Subject: Re: [PATCH] Change the freq limit of speaker-test
Date: Tue, 21 Jun 2005 17:50:36 +0300
Message-ID: <42B8293C.1060205@mbnet.fi>
References: <42B31318.1020705@mbnet.fi> <s5hzmtknf95.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010809040609020300050401"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hzmtknf95.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010809040609020300050401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> At Fri, 17 Jun 2005 21:14:48 +0300,
> Anssi Hannula wrote:
>>
>>I noticed that the speaker-test has limited sine wave frequency to 
>>50-5000 Hz. Attached patch changes that to 0-24575Hz (that's the limit 
>>at least here (x86-64) after which the freq would roll over to 0 Hz).
> 
> Does freq=0 really work?  I think this will result in zero-division.

Well, it produces the expected output (no sound) and does not crash.

> Also, atof() is better than atoi() for freq since freq is a double.
> 

OK, changed that. New patch attached.

-- 
Anssi Hannula


--------------010809040609020300050401
Content-Type: text/x-patch;
 name="speaker-test_changelimits-atof.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="speaker-test_changelimits-atof.diff"

Index: speaker-test/speaker-test.c
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/speaker-test/speaker-test.c,v
retrieving revision 1.8
diff -u -r1.8 speaker-test.c
--- speaker-test/speaker-test.c	3 May 2005 18:36:08 -0000	1.8
+++ speaker-test/speaker-test.c	21 Jun 2005 14:44:01 -0000
@@ -531,9 +531,9 @@
       channels = channels > 1024 ? 1024 : channels;
       break;
     case 'f':
-      freq = atoi(optarg);
-      freq = freq < 50 ? 50 : freq;
-      freq = freq > 5000 ? 5000 : freq;
+      freq = atof(optarg);
+      freq = freq < 0 ? 0 : freq;
+      freq = freq > 24575 ? 24575 : freq;
       break;
     case 'b':
       buffer_time = atoi(optarg);

--------------010809040609020300050401--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
