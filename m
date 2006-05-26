From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: TODO list
Date: Fri, 26 May 2006 12:29:11 +0100
Message-ID: <4476E687.10608@superbug.co.uk>
References: <4475F316.5000908@superbug.co.uk> <s5hpsi1qc1h.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from anchor-post-35.mail.demon.net (anchor-post-35.mail.demon.net
	[194.217.242.85])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DC429177
	for <alsa-devel@alsa-project.org>;
	Fri, 26 May 2006 13:31:05 +0200 (MEST)
In-Reply-To: <s5hpsi1qc1h.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
>> 7) Provide better OSS emulation support. E.g. redirect all access to 
>> /dev/dsp into user space so it can use all the features of alsa-lib 
>> without needing aoss. (aoss does not work if the application uses 
>> dynamically linked audio driver plugins.
>>     
>
> A dummy kernel driver just to translate syscalls to communication with
> a user daemon is the only possible workaround, IMO.  This idea was
> denied once quite ago, but I don't see any other good way right now.
>   
That is my thought as well. When I looked into the idea some time ago, I 
concluded that is would be a rather large project, so I did not proceed 
as I have other more important (for me) ALSA features.
Can a user space daemon create /dev files, so that the application calls 
never actually reach kernel space?
If we can create such a pipe, that can forward 
open/close/read/write/ioctl, that should be enough. We then have to 
think about shared memory to look like DMA space to the application 
using us.

>
> My additional wishes are:
>
> 8) Improve release engineering.
>
> 9) Better organized Web pages and BTS.
>
> 10) Build standard test suite and diagnosis tools.
>
>   
The words "Under staffed" comes to mind. :-)
> Takashi
>   

James
