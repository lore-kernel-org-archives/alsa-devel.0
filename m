From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Re: How can I link the kernel with libgcc ?
Date: Fri, 10 Mar 2006 11:55:05 +0000
Message-ID: <44116919.3000807@superbug.co.uk>
References: <4410D9F0.6010707@kenati.com>	 <200603100145.k2A1jMem005323@turing-police.cc.vt.edu>	 <1141956362.13319.105.camel@mindpipe> <4410EC0D.3090303@kenati.com>	 <4410F1BE.7000904@kenati.com> <1141961152.13319.118.camel@mindpipe> <4410F6CB.8070907@kenati.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4410F6CB.8070907@kenati.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Carlos Munoz <carlos@kenati.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Valdis.Kletnieks@vt.edu, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Carlos Munoz wrote:
> Lee Revell wrote:
>
>> On Thu, 2006-03-09 at 19:25 -0800, Carlos Munoz wrote:
>>  
>>
>>> I figured out how to get the driver to use floating point operations.
>>> I included source code (from an open source math library) for the
>>> log10 function in the driver. Then I added the following lines to the
>>> file arch/sh/kernel/sh_ksyms.c:   
Carlos,

Be warned. You CANNOT use floating point instructions in the kernel.
The floating point registers are not saved during a task switch for any 
kernel module.

James




This e-mail and any attachment is for authorised use by the intended recipient(s) only. It may contain proprietary material, confidential information and/or be subject to legal privilege. It should not be copied, disclosed to, retained or used by, any other party. If you are not an intended recipient then please promptly delete this e-mail and any attachment and all copies and inform the sender. Thank you.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
