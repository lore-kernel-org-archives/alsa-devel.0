From: Thorsten Leemhuis <fedora@leemhuis.info>
Subject: Re: alsa-oss devel-files and alsa-firmware license
Date: Thu, 11 Dec 2003 16:52:52 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1071157972.1802.9.camel@work.thl.home>
References: <1071147572.4567.56.camel@thl.ct.heise.de>
	 <3FD88559.6010403@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FD88559.6010403@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thanks for answering.

Am Do, den 11.12.2003 schrieb Patrick Shirkey um 15:55:
> Thorsten Leemhuis wrote:
> >
> > - What the purpose of
> > /usr/lib/libaoss.a
> > /usr/lib/libaoss.so
> > after compiling alsa-oss? Nobody should be compiling with them,
> > or missed I something? Maybe see bug
> > 
> 
> aoss is a clever little app which hijacks oss applications output before 
> it gets to the alsa emulation layer and translates it to native ALSA.

Thanks, I know what aoss does, I simply does a

LD_PRELOAD=/usr/lib/libaoss.so.0 $*

And this file is linked against

# ldd /usr/lib/libaoss.so.0
        libdl.so.2 => /lib/libdl.so.2 (0x0042f000)
        libasound.so.2 => /usr/lib/libasound.so.2 (0x00549000)
        libm.so.6 => /lib/tls/libm.so.6 (0x0040b000)
        libpthread.so.0 => /lib/tls/libpthread.so.0 (0x00537000)
        libc.so.6 => /lib/tls/libc.so.6 (0x002d0000)
        /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x002b8000)

So what's the purpose of /usr/lib/libaoss.a ? AFAIK its a development
library -- but are there any programs that are develop ontop of
alsa-oss? Or does it have another purpose?

Maybe look at the bug at
http://bugzilla.fedora.us/show_bug.cgi?id=592

CU
thl




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
