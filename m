From: Ed Wildgoose <lists@wildgooses.com>
Subject: patch: RME9632 precise_ptr fix (9652 owners please read)
Date: Wed, 06 Oct 2004 15:10:18 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4163FCCA.1090909@wildgooses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
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
List-Id: alsa-devel@alsa-project.org

Hooray.  With some very kind help from Martin Björnsen, I have figured 
out the problem with the rme9652 driver when using the precise_ptr 
option and a fix is shown below.

I have not been able to get in touch with Thomas Charbonnel (original 
author) for a long time now, so I would be grateful if someone on the 
alsa team could commit this to cvs.  Please note that I have only tested 
this on a 9632 card, but the driver also supports the 9652 (and 
others?), so perhaps someone could retest this on those bits of 
hardware.  It's possible that a similar fix could be applied to the 
rme9652.c driver, but I don't really understand which driver is for 
which card here?

The justification for this fix being correct is that the position 
counter used here is a 16 sample counter (it's not really sample 
accurate), and it also counts up continuously, and doesn't reset each 
time the buffer is emptied.  This created a logic error in the original 
code because it was masking against the max buffer size, and not against 
the *current* buffer size. 

With the fix in below, basic testing on mplayer with some debug code 
shows extremely accurate sync rates with the video now, and life is 
rosey again!

By the way, if testing against other hardware shows that this patch 
causes no problems (and works correctly), which I think it will, then we 
can completely remove the accurate_ptr option and make this code the 
default.  If testers could copy me in directly I will submit a new patch 
once a suitable number of responses are received

Thanks

Ed Wildgoose


--- hdsp.c.orig 2004-10-06 14:58:37.052866070 +0100
+++ hdsp.c      2004-10-06 14:59:15.034213752 +0100
@@ -969,8 +969,7 @@

        position &= HDSP_BufferPositionMask;
        position /= 4;
-       position -= 32;
-       position &= (HDSP_CHANNEL_BUFFER_SAMPLES-1);
+        position &= ((hdsp->period_bytes/2)-1);
        return position;
 }




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
