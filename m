From: torsten <torsten@inetw.net>
Subject: wolk kernel headers
Date: Mon, 10 Feb 2003 16:14:42 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030210161442.55d398cd.torsten@inetw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

Hello,

I've run into a problem.  I installed my machine with
a non-wolk kernel.  Now I'm running a wolk kernel.  I need
the integrated sound to keep my laptop from crashing on
suspend.

Since the kerenel headers copied into /usr/include match
the glibc when my kernel was compiled (non-wolk), there
are no files asound.h and asequencer.h (needed by kdelibs).

I cannot compile the alsa-driver package against the running
wolk kernel (it complains that I haven't enable sound).

There are header files in alsa-driver, and in the wolk kernel
tree.

Should I just copy the needed headers into /usr/include?

Torsten



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
