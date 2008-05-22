From: Adrian Bunk <bunk@kernel.org>
Subject: Re: Moving sound/* to drivers/ ?
Date: Thu, 22 May 2008 17:22:36 +0300
Message-ID: <20080522142236.GA27301@cs181133002.pp.htv.fi>
References: <s5hzlqjz74d.wl%tiwai@suse.de> <4834B252.1080700@garzik.org>
	<4834B5E2.3040301@keyaccess.nl> <s5hy7623fqs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6.pp.htv.fi (smtp6.pp.htv.fi [213.243.153.40])
	by alsa0.perex.cz (Postfix) with ESMTP id A2AC7243D9
	for <alsa-devel@alsa-project.org>;
	Thu, 22 May 2008 16:24:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hy7623fqs.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jeff Garzik <jeff@garzik.org>, Rene Herman <rene.herman@keyaccess.nl>, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

On Thu, May 22, 2008 at 10:27:55AM +0200, Takashi Iwai wrote:
> At Thu, 22 May 2008 01:53:06 +0200,
> Rene Herman wrote:
>...
> An argument for keeping the sound core in /sound is that this is used
> not only by sound drivers but also by some video drivers.

Same goes for e.g. some of the USB or PCI code.

We could start splitting stuff like crazy, but what would we really 
gain by doing it?

> Takashi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
