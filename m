From: Michael Jochum <e9725005@stud3.tuwien.ac.at>
Subject: Re: rtcw,quake3 hang on exit
Date: 20 Mar 2002 23:05:52 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1016661952.933.5.camel@mjo>
References: <200203202147.QAA02262@renoir.op.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <200203202147.QAA02262@renoir.op.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hi paul!

On Wed, 2002-03-20 at 22:47, Paul Davis wrote:
> sure, it does. but strace won't see, since it all happens *inside* the
> kernel's handling of sys_exit(). strace merely traces actual syscalls,
> not what happens inside the kernel. _exit will call sys_close for
> every file in the task's file table.
> 
> >so what kind of bug is this? rtcw? alsa? kernel?
> 
> you haven't really described the bug very much. something to do with
> processes left around, etc.
> 
> does the program(s) in question use threads? if so, using _exit() will
> fail to terminate all threads in the process. this is a linux issue.
rtcw doesn`t use threads theres only one process during the execution of
rtcw and thats the process that hangs on exit. the process can be
terminatet with Ctrl-C. 
Steven Walter reported that the problem also exists in the demo version
of the games which is aviable at various places. maybe you could debug
the problem? 
http://www.3dgamers.com/dl/games/returnwolfenstein/wolfmpdemo-linux-1.1-mp.x86.run.html
its about 66MByets to download and i understand if you don`t have the
time to do it - but maybe you can give me some hints to debug the
problem.

michael.





_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
