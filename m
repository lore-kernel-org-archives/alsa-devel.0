From: Paul Davis <pbd@Op.Net>
Subject: Re: rtcw,quake3 hang on exit
Date: Wed, 20 Mar 2002 16:47:32 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200203202147.QAA02262@renoir.op.net>
References: <1016654302.933.2.camel@mjo>
In-Reply-To: Your message of "20 Mar 2002 20:58:22 +0100."
             <1016654302.933.2.camel@mjo>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Michael Jochum <e9725005@stud3.tuwien.ac.at>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>i have done a strace run of rtcw and found some interesting things:
>
>somewhere rtcw opens the dsp device:
>open("/dev/dsp", O_RDWR)                = 16
>but i cant find the coresponding
>close(16)
>
>this are the last lines of output (process locks here):
>
>write(2, "----- CL_Shutdown -----\n", 24) = 24
>write(2, "-----------------------\n", 24) = 24
>fcntl64(0, F_GETFL)                     = 0x802 (flags
>O_RDWR|O_NONBLOCK)
>fcntl64(0, F_SETFL, O_RDWR)             = 0
>write(2, "Shutdown tty console\n", 21)  = 21
>ioctl(0, SNDCTL_TMR_STOP, {B38400 opost isig icanon echo ...}) = 0
>_exit(0)                                = ?
>
>i dont know much about kernel internals - but isnt _exit a kernel syscal
>that is supposed to close all open devices?

sure, it does. but strace won't see, since it all happens *inside* the
kernel's handling of sys_exit(). strace merely traces actual syscalls,
not what happens inside the kernel. _exit will call sys_close for
every file in the task's file table.

>so what kind of bug is this? rtcw? alsa? kernel?

you haven't really described the bug very much. something to do with
processes left around, etc.

does the program(s) in question use threads? if so, using _exit() will
fail to terminate all threads in the process. this is a linux issue.

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
