From: Manuel Jander <mjander@embedded.cl>
Subject: Re: problems with gcc 3.2.2 update
Date: Sat, 08 Mar 2003 16:01:19 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E6A4C0F.6060509@embedded.cl>
References: <200303061856.h26IuI300825@linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200303061856.h26IuI300825@linuxaudiosystems.com>
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

Hi,

I'm writing an Audio driver (vortex) and when the DMA engine of the
cards starts transferring data everything locks up.
I'm using a simple linear DMA buffer, and i actually get
playback but for only one period. If i disable the
interrupt "period elapsed" calls the playback keeps playing the buffer
in a loop, if not it stops after one buffer pass.
If i simple disable the "trigger" call, so anything else is done but the DMA
engine remains stopped, no problems happens (no segfault, anything else
semes clean).

I was unable to retrieve any ALSA related ksymoops information
("ksyms <ksymoopsfiles> |grep snd" returns empty).

Could this be some kid of gcc compiler problem ? I tried the
ens1371 driver, and it works OK.

Debian SID (almost up to date).
ALSA version 0.9.0rc7
Kernel 2.4.20 + xfs
GCC: 3.2.2 20030109 (Debian prerelease)
CPU: AMD Athlon Thunderbird 1.4 GHz
256 MB RAM DDR

Any comments , suggestinos ?

bye.

Manuel Jander

Paul Davis wrote:

>i backpedaled to 2.4.20 (vanilla, no patches). i grabbed this
>morning's ALSA CVS. i used the simplest kernel config i could come up
>with for my system. i recompiled everything, reinstalled, rebooted
>(several times, in fact).
>
>the system runs fine for kernel compiles, X, browsing, emacs,
>development work ... in short, absolutely everything until 
>an audio device is accessed. when that happens (actually, when it is
>first written to), we get either an oops or the system just locks
>totally solid (no magic-sysrq, nothing).
>
>from the oops files, there are some suggestions that the issue is SMP
>related. i am now downloading gcc 2.95.3 to try all over again.
>
>
>-------------------------------------------------------
>This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
>for complex code. Debugging C/C++ programs can leave you feeling lost and 
>disoriented. TotalView can help you find your way. Available on major UNIX 
>and Linux platforms. Try it free. www.etnus.com
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel
>
>.
>
>  
>




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
