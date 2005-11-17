From: Thomas Hood <jdthood@yahoo.co.uk>
Subject: two warnings about variables that "may be used uninitialized in this
 function"
Date: Thu, 17 Nov 2005 16:16:09 +0100
Message-ID: <437C9EB9.5050504@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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

Warning re: alsa-lib-1.0.10/src/mixer/simple_none.c

    simple_none.c:1271: warning: 'type' may be used uninitialized in this function

Given that base_len may not always write to *type, there may be
something to this warning.  I haven't looked at it too closely.


Warning re:  alsa-lib-1.0.10/src/pcm/pcm_route.c

    pcm_route.c:348: warning: 'src' may be used uninitialized in this function

This seems like a bogus warning since the line in question is:

    const char *src = srcs[srcidx];

Bogus or not, it would be nice if the code were tweaked so that gcc doesn't
generate these warnings; or at least if the code were commented with
"/* gcc generates bogus warning message about this */".
-- 
Thomas Hood


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
