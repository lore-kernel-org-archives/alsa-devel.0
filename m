From: Brett Dikeman <brett@cloud9.net>
Subject: alsa-driver uses invalid gcc option in configure script
Date: Sun, 19 Sep 2004 01:39:51 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <a05200f02bd72ca276aa3@[192.168.1.2]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
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

alsa-driver 1.0.6a's configure script calls /lib/cpp -V.

This seems to check for what version of gcc is running.  -V is used 
to switch between multiple versions of GCC, at least with gcc 3.4.1, 
and gcc responds with an error- "-V requires additional argument" (or 
something to that effect).  configure picks up on this as a failure- 
so, alsa won't build.

Could someone please change this to --version?

Thanks!
Brett
-- 


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
