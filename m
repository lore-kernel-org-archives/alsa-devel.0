From: Nathaniel Gray <n8gray@caltech.edu>
Subject: More info on the intel8x0 vs. Dell APM problem
Date: Tue, 29 Apr 2003 16:30:47 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304291630.47676.n8gray@caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I found a link or two that might help to understand the problem with the 
intel8x0 driver on Dell laptops.  It looks like APM has adverse effects 
on the system clock:

http://math.stanford.edu/~carlton/i8200/time.html

I imagine that maybe the alsa intel8x0 driver keeps time differently 
than the oss driver, which is why it gets disrupted by reads from 
/proc/apm when the oss driver doesn't.  I've seen a report that 
configuring the kernel to enable interrupts during APM calls 
(CONFIG_APM_ALLOW_INTS=y) solves the problem.  Here's a link:
http://groups.yahoo.com/group/linux-dell-laptops/message/15701

I'm recompiling my kernel right now and I'll report back on whether or 
not it helps.

Cheers,
-n8

-- 
>>>-- Nathaniel Gray -- Caltech Computer Science ------>
>>>-- Mojave Project -- http://mojave.cs.caltech.edu -->



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
