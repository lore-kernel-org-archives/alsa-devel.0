From: Thomas Hood <jdthood@yahoo.co.uk>
Subject: warning about "assignment from incompatible pointer type"
Date: Thu, 17 Nov 2005 16:23:29 +0100
Message-ID: <437CA071.1040500@yahoo.co.uk>
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

Warning re: alsa-lib-1.0.10/src/seq/seq.c

    seq.c:4438: warning: assignment from incompatible pointer type

The line in question is

    ev = ep

where the declarations were

    snd_seq_event_t *ev

    char *ep

Given that snd_seq_event_t seems to be typedef'ed to unsigned char in seq_event.h,
it would seem that a cast should suffice to eliminate the warning.

-- 
Thomas Hood



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
