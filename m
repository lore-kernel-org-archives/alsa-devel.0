From: John Rigg <aldev@sound-man.co.uk>
Subject: Re: ice1712 error
Date: Fri, 19 Dec 2008 17:28:17 +0000
Message-ID: <20081219172817.GA2382@localhost>
References: <494BC00A.9080202@xs4all.nl> <s5hocz8uq0t.wl%tiwai@suse.de>
	<494BC52B.8020605@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.uklinux.net (mail3.uklinux.net [80.84.72.33])
	by alsa0.perex.cz (Postfix) with ESMTP id C4B0E2446C
	for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2008 18:15:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <494BC52B.8020605@xs4all.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Udo van den Heuvel <udovdh@xs4all.nl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 19, 2008 at 05:00:43PM +0100, Udo van den Heuvel wrote:
> Takashi Iwai wrote:
> >> ICE1712: probe of 0000:01:09.0 failed with error -12
> >> Does this mean the card is toast?
> >> What does the -12 mean?
> > 
> > It's ENOMEM, means it failed to allocate some memories.
> 
> Thanks for the info.
> 
> There is 4G of RAM in the box.
> I can boot with mem=2048000K and still get the error every like I 
> described. (sometimes it is in error, sometimes it is OK)
> 
> Do I need to remove SIMMs to test?
> 
> What could I do?

You can test your memory in situ with memtest86+
from http://www.memtest.org

John
