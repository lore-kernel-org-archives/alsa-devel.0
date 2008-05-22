From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: Moving sound/* to drivers/ ?
Date: Thu, 22 May 2008 10:11:45 +0200
Message-ID: <48352AC1.9000501@keyaccess.nl>
References: <s5hzlqjz74d.wl%tiwai@suse.de> <4834B252.1080700@garzik.org>
	<4834B5E2.3040301@keyaccess.nl>
	<Pine.LNX.4.61.0805220809370.1798@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id BD3BB2475B
	for <alsa-devel@alsa-project.org>;
	Thu, 22 May 2008 10:09:21 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>
List-Id: alsa-devel@alsa-project.org

On 22-05-08 08:26, Jaroslav Kysela wrote:

> On Thu, 22 May 2008, Rene Herman wrote:

>> From a structural view, the PCM core is just as much not a driver
>> as the IP protocol isn't one and moving all of sound/ to drivers/
>> would trade the current "why are the drivers not under drivers/?"
>> issue for a "why is all this non-driver code under drivers/?".
>> 
>> This "net model" of sound/ and drivers/sound/ would be cleanest I
>> feel.
> 
> Yes, it was one reason why I used 'sound/' as root of the ALSA tree.
> The second reason was to move old OSS tree to new directory to make
> less confusion. And the third reason was to just keep ALSA directory
> same as in our local development tree (which is out-of-kernel tree -
> containing only ALSA parts).
> 
> I feel that from the maintenance perspective, having one directory is
> a plus. We have already 'drivers/usb/core', 'mmc/core',
> 'drivers/base' (ALSA toplevel and midlevel modules use functions from
> this tree) etc.

Yes, examples of the same thing. drivers/base still sort of fits, but yes.

Would the maintenance be really helped? As you said in another reply, 
the external tree already shuffles Documentation/sound/alsa and 
include/sound around anyway.

I don't feel very strongly about it or anything but it's also a kernel 
statistics issue. Linus for example frequently announces new -rc's with 
"90% is in drivers" and such and if large(r) parts of drivers/ consist 
not of driver code that's a less useful metric.

> If we have general consensus that sound drivers should go to back to 
> 'drivers/sound' then I would move all code. We can move 'sound/core'
> tree to '/sound' in next round later...

I'd expect that if you give up your nice top level directory you're not 
getting it back later... :-)

Rene.
