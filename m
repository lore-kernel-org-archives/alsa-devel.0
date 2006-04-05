From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: amd64 bus error
Date: Wed, 05 Apr 2006 21:34:22 +0100
Message-ID: <443429CE.8040304@superbug.co.uk>
References: <4433ABD2.6030704@superbug.co.uk> <2c746f620604051315w53d94a5bo5236778a28397959@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <2c746f620604051315w53d94a5bo5236778a28397959@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Eric Shattow <lucent@gmail.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Eric Shattow wrote:
> This may be a hardware error on your computer platform.  Is the bug
> reproducible? If not, you should try replacing the CPU/ram of your
> test machine.
> 
>  Eric
> 
> On 4/5/06, James Courtier-Dutton <James@superbug.co.uk> wrote:
>> Here is a backtrace of a alsa application that ran for about 1 hour
>> before giving this:
>>
>> [New Thread 1098918240 (LWP 23392)]
>>
>> Program received signal SIGBUS, Bus error.
>> [Switching to Thread 1098918240 (LWP 23392)]
>> 0x00002aaaac51bcc8 in ao_alsa_loop (iarg=<value optimized out>)
>>     at start_alsa.c:494
>> 494                     if (poll (pfd, nfds, 200000) < 0) {
>>
>>
>> Have we had any bus error type fixes to alsa-driver between the current
>> ubuntu alsa version and the latest?
>> The poll() call above is with alsa file descriptors.
>>
>> James
>>

I ran one cycle of memtest86+ on it, and it has no errors.
I don't think this is a hardware problem.

James




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
