From: Mike Hearn <mike@plan99.net>
Subject: Re: Re: Change processname for dmix/dsnoop process
Date: Tue, 04 Oct 2005 15:40:04 +0100
Message-ID: <43429444.20903@plan99.net>
References: <433D491A.8070700@vidsoft.de>	<s5hzmpulit5.wl%tiwai@suse.de>	<pan.2005.10.01.23.13.56.451320@plan99.net> <s5h3bnheekv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3bnheekv.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Actually, I found it - it's SYS_prctl with PR_SET_NAME (2.6 kernels only).

Something like this:

static inline int prctl(int option, unsigned long arg2, unsigned long arg3,
                        unsigned long arg4, unsigned long arg5)
{
    int ret;
    __asm__ __volatile__ ( "pushl %%ebx; movl %2,%%ebx; int $0x80; popl %%ebx"
                           : "=a" (ret) : "0" (SYS_prctl), "r" (option),
                           "c" (arg2), "d" (arg3), "S" (arg4), "D" (arg5) );
    return SYSCALL_RET(ret);
}

prctl(15 /* PR_SET_NAME */, (unsigned long)"dmix", 0, 0, 0);

thanks -mike

Takashi Iwai wrote:

>At Sun, 02 Oct 2005 00:13:56 +0100,
>Mike Hearn wrote:
>  
>
>>On Fri, 30 Sep 2005 16:41:10 +0200, Takashi Iwai wrote:
>>    
>>
>>>Well, changing the process name in run time is very tricky on Linux. In
>>>other words: no proper way.
>>>      
>>>
>>Are you sure? I thought there was a syscall for it.
>>    
>>
>
>Then I'd be happy to change the code.  Could you give a pointer?
>
>
>Takashi
>
>  
>





-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
