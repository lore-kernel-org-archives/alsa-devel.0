From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: intel8x0 has stopped working.
Date: Fri, 06 Feb 2004 20:05:42 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4023F396.7030407@superbug.demon.co.uk>
References: <401E8BAE.6010802@superbug.demon.co.uk>	<s5hn081uztv.wl@alsa2.suse.de>	<401EA82D.3060702@superbug.demon.co.uk>	<s5hwu72aba0.wl@alsa2.suse.de>	<40217A56.2020808@superbug.demon.co.uk>	<s5hr7x98ga5.wl@alsa2.suse.de>	<4022C373.7060601@superbug.demon.co.uk> <s5hekt88mzc.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-31.mail.demon.net (anchor-post-31.mail.demon.net [194.217.242.89])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA10929
	for <alsa-devel@alsa-project.org>; Fri, 6 Feb 2004 20:58:03 +0100
In-Reply-To: <s5hekt88mzc.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Thu, 05 Feb 2004 22:28:03 +0000,
> James Courtier-Dutton wrote:
> 
>>I checked out a new anonymouse cvs of alsa-driver/alsa-kernel, applied 
>>your patch, and attach the output from doing modprobe snd-intel8x0.
>>
>>I can only see printf's in the patch, so I don't see how it could have 
>>fixes the VRA.
> 
> 
> no, it doesn't fix yet.
> 
> 
>>Feb  5 22:22:53 new kernel: determined VRA rates: 0xfe
>>Feb  5 22:22:53 new kernel: determined VRA rates: 0xfe
>>Feb  5 22:22:53 new kernel: determined SPDIF rates: 0xe0
>>Feb  5 22:22:53 new kernel: determined SDAC rates: 0x80
>>Feb  5 22:22:53 new kernel: determined LDAC rates: 0x80
> 
> 
> here's the problem.  surround and LFE DAC sample rates are not
> detected properly.
> i don't figure out yet why...
> 
> does the attached patch have influence?  check the messages above.
> (it doesn't contain the patch to ac97_pcm.c.  it's not needed now.)
> 
> 
> Takashi
> 
> 
I checked out a new cvs of alsa-driver, alsa-kernel
Added your patch, and the rates are detected correctly now, and the 
rates change on the hardware correctly now.
Thanks

By looking at your code, it looks like you are making sure the rate for 
the Front, Surround and Center/LFE all change together, which seems to 
work, although, the alc650 datasheet spec does not seem to mention that 
this has to happen. Why have 3 ac97 registers, if they all have to 
change together?

Anyway, thanks for the fix.

Cheers
James







-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
