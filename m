From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: User land drivers.
Date: Fri, 03 Sep 2004 16:58:09 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <41389491.1030804@superbug.demon.co.uk>
References: <413456AE.7000007@superbug.demon.co.uk> <Pine.LNX.4.58.0409031603060.21405@linux.local> <s5hy8jrwhoy.wl@alsa2.suse.de> <Pine.LNX.4.58.0409031628530.21405@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-30.mail.demon.net (anchor-post-30.mail.demon.net [194.217.242.88])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 78D90298
	for <alsa-devel@alsa-project.org>; Fri,  3 Sep 2004 17:58:10 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.58.0409031628530.21405@linux.local>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Fri, 3 Sep 2004, Takashi Iwai wrote:
> 
> 
>>Also, we may provide a more easy-to-use interface for additional ALSA
>>pcm plugins.  The current design of plugin is bound too tightly to the
>>ALSA lowlevel structure, and it's a pain to implement all on that at
>>each time.
> 
> 
> I think that we should follow the kernel space here - create only helper 
> functions which might be used in the user space driver design.
> 
> 						Jaroslav
> 

Currently, to support a new sound card in ALSA, we just write a small 
bit of code to talk to the hardware, and other alsa kernel modules 
provide all the helper functions(period_elapsed etc.), so for a user 
land driver(bluetooth), these helper functions should be in alsa-lib.

You mention the PCM plugin. I did not know there was already a PCM 
plugin api that could be used to talk to some other user land program. I 
just thought the PCM plugins were for sample rate conversion and simple 
stuff like that.

I might have to look at the docs again.

James


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
