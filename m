From: Clemens Ladisch <clemens@ladisch.de>
Subject: running out of sequencer client numbers
Date: Fri, 18 Nov 2005 11:29:43 +0100
Message-ID: <1132309783.437dad17900ca@webmail.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
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
To: alsa-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org


Currently, sequencer client numbers of kernel drivers are allocated
statically, with each card getting a range of eight numbers out of the
64..127 range.

This will no longer be possible when the maximum number of sound cards
will is increased (which I'm going to do soon).

1) We could allocate client numbers dynamically (like for user space
applications), but it's desirable to have stable client numbers
because there are applications that identify ports by their client
number instead of by their name.

2) We could reduce the number of sequencer clients per sound card,
but this would limit us to 16 cards because we still need four clients
per card.

3) We could reuse some of the numbers from the system range (0..63).
Currently, only a few of those are actually used.


I intend to combine all three points: Allow only four sequencer
clients per cards; give the first 16 card static numbers from the
64..127 range; cards >=17 get dynamically allocated numbers from
the 16..47 range (0..15 and 48..63 still available for system
clients).

Comments?



Clemens


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
