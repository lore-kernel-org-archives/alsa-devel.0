From: Chris Rankin <rankincj@yahoo.com>
Subject: ALSA, and building the Linux kernel outside its source tree...
Date: Wed, 13 Oct 2004 00:43:44 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041012234344.2098.qmail@web52905.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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

Hi,

I have a number of Linux boxes, each with different
CPUs of various speeds. For the sake of speed and
storage space, I am experimenting with having a single
source tree from which I can build multiple kernels.
(It really doesn't make sense to force a P200 to
compile its own kernel while its networked P4
neighbour 'twiddles its bits', if you catch my
meaning.) The Linux build process now allows this by
specifying:

make O=<output directory path> menuconfig
make O=<output directory path>
make O=<output directory path> modules_install

You get the idea. The installation procedure now
creates two symlinks:

/lib/modules/<version>/build
/lib/modules/<version>/source

However, the ALSA driver cvscompile script expects
everything to be accessible via the 'build' link,
although the only headers available under
build/include/linux are:

version.h
compile.h
autoconf.h

Would it be difficult to change the ALSA driver
configure script to allow for separate source and
build trees, please?

Thanks,
Chris



	
	
		
___________________________________________________________ALL-NEW Yahoo! Messenger - all new features - even more fun!  http://uk.messenger.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
