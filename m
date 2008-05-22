From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: Moving sound/* to drivers/ ?
Date: Thu, 22 May 2008 11:57:40 +0200
Message-ID: <48354394.9040205@keyaccess.nl>
References: <s5hzlqjz74d.wl%tiwai@suse.de>	<4834B252.1080700@garzik.org>	<4834B5E2.3040301@keyaccess.nl>
	<s5hy7623fqs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 1783A2479E
	for <alsa-devel@alsa-project.org>;
	Thu, 22 May 2008 11:55:16 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>
List-Id: alsa-devel@alsa-project.org

On 22-05-08 10:27, Takashi Iwai wrote:

> At Thu, 22 May 2008 01:53:06 +0200,
> Rene Herman wrote:

>> Well, not _huge_ but ALSA is very much structured like that; large 
>> middle layer with "miniport" drivers (I do by the way expect this was 
>> also Takashi plan originally due to him using sound/* and not just 
>> "sound/"; that is, I took the * to be shorthand for isa, pci, usb and so on)
> 
> Well, no, I originally thought moving all $LINUX/sound to
> $LINUX/drivers/sound.

Oh okay, misinterpreted that.

>> This "net model" of sound/ and drivers/sound/ would be cleanest I feel.
> 
> I think it's a question of the balance.  The net stuff is huge, 10
> times more codes than the sound core.

Indeed, but then again, block/ is 3 times as small. Don't actually know 
what the rationale was for that one but I'd expect some of the same 
reasons for that split to apply here.

Yes, there's more non driver work under drivers already but this might 
be something to try to minimise. Drivers are really sort of special in 
their nicely defined and limited impact and statistics such as the 
percentage of updates that are in drivers are used in that way.

> An argument for keeping the sound core in /sound is that this is used
> not only by sound drivers but also by some video drivers.

Mm, right. In a sense the snd-pcsp thing might be an argument even. 
There really wants to be one driver for the PC speaker which doesn't 
want to live in (drivers/)sound/ due to it being generic hardware but 
which does want to use sound/ to pretend it is.

In that sense, the sound core is shared infrastructure...

Rene.
