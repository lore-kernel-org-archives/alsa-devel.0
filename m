From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Adding a new architecture to alsa-driver
Date: Tue, 11 Apr 2006 17:57:55 -0400
Message-ID: <1144792676.21098.8.camel@mindpipe>
References: <1144510532.10642.1.camel@localhost.localdomain>
	 <1144512218.22490.146.camel@mindpipe>
	 <1144542208.10642.9.camel@localhost.localdomain>
	 <1144545416.22490.184.camel@mindpipe>
	 <1144706767.9278.11.camel@localhost.localdomain>
	 <1144718017.18918.6.camel@mindpipe>
	 <1144791420.9248.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1144791420.9248.2.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-04-11 at 22:37 +0100, Adrian McMenamin wrote:
> I just cannot get this patch to apply. It seems to be made at two
> different patch levels
> 

cvs diff was not working for me (I could not get it to show the contents
of the "sh" directories, diff -Nru style) so I made a separate patch for
alsa-driver and alsa-kernel and combined them.

It works for me:

$ cat ~/aica-new.patch | patch -p0 --dry-run
patching file alsa-kernel/Kconfig
patching file alsa-kernel/Makefile
patching file alsa-kernel/sh/Kconfig
patching file alsa-kernel/sh/Makefile
patching file alsa-kernel/sh/aica.c
patching file alsa-kernel/sh/aica.h
patching file alsa-driver/Makefile
patching file alsa-driver/configure.in
patching file alsa-driver/sh/Makefile
patching file alsa-driver/sh/aica.c

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
