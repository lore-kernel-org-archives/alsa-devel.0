From: "Ivica Bukvic" <ico@fuse.net>
Subject: Suse 8.0 Alsa CVS compile problem (possibly snd-hammerfall-mem problem?)
Date: Sun, 19 May 2002 22:08:06 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <ac9lrf$jk1$2@main.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
Cc: 'Paul Davis' <pbd@op.net>
List-Id: alsa-devel@alsa-project.org

Hi all, I am having an odd problem with the ALSA cvs compile on SUSE
8.0. I am trying to do this in order to get the hdsp driver. However,
whenever I compile the driver it stores all the modules in the
/lib/modules/2.4.18-4GB/ folder assuming that my kernel is 2.4.18-4GB.
However, when I open the k control center it tells me that I am using
2.4.18-64GB-SMP kernel (which makes no sense since I am using it on a
single processor laptop).

So, when I try to install the module for the built-in soundcard (intel
8x0), it installs fine, but when I try to modprobe snd-hammerfall-mem,
it fails saying that it has been compiled for the 2.4.18-4GB kernel and
that I am using 2.4.18-64GB-SMP kernel -> hence the kernel mismatch ->
modprobe failed.

Anyone has a clue as to why is this happening?

(Paul, I'm cc'ing this to you since it seems to me like it may be
another problem with the new hdsp driver, not sure as of yet).

Ico



_______________________________________________________________
Hundreds of nodes, one monster rendering program.
Now that's a super model! Visit http://clustering.foundries.sf.net/
