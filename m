From: Paul Davis <paul@linuxaudiosystems.com>
Subject: problems with gcc 3.2.2 update
Date: Thu, 6 Mar 2003 13:56:18 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200303061856.h26IuI300825@linuxaudiosystems.com>
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

i backpedaled to 2.4.20 (vanilla, no patches). i grabbed this
morning's ALSA CVS. i used the simplest kernel config i could come up
with for my system. i recompiled everything, reinstalled, rebooted
(several times, in fact).

the system runs fine for kernel compiles, X, browsing, emacs,
development work ... in short, absolutely everything until 
an audio device is accessed. when that happens (actually, when it is
first written to), we get either an oops or the system just locks
totally solid (no magic-sysrq, nothing).

from the oops files, there are some suggestions that the issue is SMP
related. i am now downloading gcc 2.95.3 to try all over again.


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
