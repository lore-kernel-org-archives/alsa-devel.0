From: Paul Davis <paul@linuxaudiosystems.com>
Subject: fatal oops in current CVS confirmed
Date: Fri, 7 Mar 2003 08:53:49 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200303071353.h27DrnJ01476@linuxaudiosystems.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

yesterday, i backed up to gcc 2.95.3, rebuilt kernel 2.4.20 and
current ALSA CVS. i continued to get the same oops/lockups i have seen when:

	* using the trident module with arecord
	* loading the wavefront module and/or

i infrequently get an oops, and when i do, it points at either:

   in the trident case
	* smp-related code 
   in the wavefront case
	* code within the module

i can't identify code within the module because its not possible to
finish loading the module and thus get the symbol addresses. i believe
it to be in the module because when i prevent the wavefront module
from loading (normally the first module to load), the addresses
correspond to things in the trident module (which becomes my first
loaded module instead).
	
so, i reverted to my "old" ALSA CVS tree, which is quite old at this
point. i recompiled it all (gcc 2.95.3), and of course, it works
fine. for me, this conclusively points to a problem in ALSA CVS that
is not related to kernel version or compiler version, but is just a
plain and simple bug. the problem is, what is it? the diffs between my
old tree and the current CVS tree are vast, and the few oops traces i
have are unrevealing in that they do not have any ALSA related calls
in them. the only way i can see for us to track this down (unless
jaroslav or takashi have a sudden inspiration) is for me to do a
binary search on CVS using a date specification until i find the first
date that causes the oops.

any other ideas?

i would strongly advise against releasing 0.9.0 final when its so
trivial to crash a system with it. and incidentally, its precisely
this kind of waste of 3 days that explains why i haven't updated from
ALSA CVS in a long time :)

--p



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
