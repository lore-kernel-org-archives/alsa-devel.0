From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Moving sound/* to drivers/ ?
Date: Thu, 22 May 2008 09:12:30 +0200
Message-ID: <20080522071230.GB18607@uranus.ravnborg.org>
References: <s5hzlqjz74d.wl%tiwai@suse.de> <4834B252.1080700@garzik.org>
	<4834B5E2.3040301@keyaccess.nl>
	<Pine.LNX.4.61.0805220809370.1798@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pasmtpA.tele.dk (pasmtpa.tele.dk [80.160.77.114])
	by alsa0.perex.cz (Postfix) with ESMTP id B2F4A246E4
	for <alsa-devel@alsa-project.org>;
	Thu, 22 May 2008 09:11:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0805220809370.1798@tm8103-a.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>, Jeff Garzik <jeff@garzik.org>, Takashi Iwai <tiwai@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

On Thu, May 22, 2008 at 08:26:39AM +0200, Jaroslav Kysela wrote:
> On Thu, 22 May 2008, Rene Herman wrote:
> 
> > On 22-05-08 01:37, Jeff Garzik wrote:
> > 
> > > Speaking as a former OSS driver maintainer, I always preferred
> > > drivers/sound.
> > > 
> > > Though Rene's suggestion (use both sound/ and drivers/sound/) might make
> > > sense if the subsystem code is huge -- I supported the drivers/block/ ->
> > > block/ code movement for example.
> > 
> > Well, not _huge_ but ALSA is very much structured like that; large middle
> > layer with "miniport" drivers (I do by the way expect this was also Takashi
> > plan originally due to him using sound/* and not just "sound/"; that is, I
> > took the * to be shorthand for isa, pci, usb and so on)
> > 
> > From a structural view, the PCM core is just as much not a driver as the IP
> > protocol isn't one and moving all of sound/ to drivers/ would trade the
> > current "why are the drivers not under drivers/?" issue for a "why is all this
> > non-driver code under drivers/?".
> > 
> > This "net model" of sound/ and drivers/sound/ would be cleanest I feel.
> 
> Yes, it was one reason why I used 'sound/' as root of the ALSA tree. The 
> second reason was to move old OSS tree to new directory to make less 
> confusion. And the third reason was to just keep ALSA directory same as in 
> our local development tree (which is out-of-kernel tree - containing only 
> ALSA parts).
That out-of-tree stuff could mirror the kernel directory layout - no?
Then you could have both drivers/ and sound/ in that tree.

We should try to opimize the kernel directory layout to fit the kernel best
and then adapt the out-of-tree stuff to the kernel (IMHO).

	Sam
