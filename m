From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: Moving sound/* to drivers/ ?
Date: Wed, 21 May 2008 23:58:10 +0200
Message-ID: <48349AF2.30009@keyaccess.nl>
References: <s5hzlqjz74d.wl%tiwai@suse.de>
	<alpine.LFD.1.10.0805211431370.3081@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 696A424588
	for <alsa-devel@alsa-project.org>;
	Wed, 21 May 2008 23:55:40 +0200 (CEST)
In-Reply-To: <alpine.LFD.1.10.0805211431370.3081@woody.linux-foundation.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 21-05-08 23:44, Linus Torvalds wrote:

> So I would personally certainly not mind somebody doing a 
> 
> 	git mv sound drivers/sound
> 	.. edit makefiles and Kconfig files appropriately ..
> 	git commit -a
> 
> and it wouldn't be a problem for git (ie the repository wouldn't grow or 
> anything like that).

I'd personally like the net/ structure more. So subsystem code under 
sound/ and drivers moved to drivers/sound/.

>> Of course, the primary question is whether it's really worth.
>> The obvious drawback is that patches won't be applicable after the
>> move.
> 
> Well, git merging is actually pretty good at this, so you can apply the 
> patches to the old release and then merge it, and it will do the right 
> thing (perhaps not for newly created files, but that's pretty easy to fix 
> up).

And a few symlinks will do wonders as well. I do/did that when I "port" 
patches developped against mainline to the alsa-kernel HG repo. Not a 
problem that way. Apply and rediff to get the new paths.

> Me personally, I've been more irritated by include/asm-xyz vs arch/xyz. It 
> would be so nice if all the arch-specific changes woudl always show up 
> under arch/ (both from a statistics standpoint, and just because then a 
> diffstat really shows arch-specific stuff really obviously, and sorts all 
> the arch-specific stuff together).

And one would not forget to add the include directory to a "git log" or 
"git bisect" path specification...

Rene.
