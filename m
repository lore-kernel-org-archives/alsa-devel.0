From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: Moving sound/* to drivers/ ?
Date: Thu, 22 May 2008 01:53:06 +0200
Message-ID: <4834B5E2.3040301@keyaccess.nl>
References: <s5hzlqjz74d.wl%tiwai@suse.de> <4834B252.1080700@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 298A324607
	for <alsa-devel@alsa-project.org>;
	Thu, 22 May 2008 01:50:44 +0200 (CEST)
In-Reply-To: <4834B252.1080700@garzik.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 22-05-08 01:37, Jeff Garzik wrote:

> Speaking as a former OSS driver maintainer, I always preferred 
> drivers/sound.
> 
> Though Rene's suggestion (use both sound/ and drivers/sound/) might make 
> sense if the subsystem code is huge -- I supported the drivers/block/ -> 
> block/ code movement for example.

Well, not _huge_ but ALSA is very much structured like that; large 
middle layer with "miniport" drivers (I do by the way expect this was 
also Takashi plan originally due to him using sound/* and not just 
"sound/"; that is, I took the * to be shorthand for isa, pci, usb and so on)

 From a structural view, the PCM core is just as much not a driver as 
the IP protocol isn't one and moving all of sound/ to drivers/ would 
trade the current "why are the drivers not under drivers/?" issue for a 
"why is all this non-driver code under drivers/?".

This "net model" of sound/ and drivers/sound/ would be cleanest I feel.

Rene.
