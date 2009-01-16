From: Ian Molton <ian@mnementh.co.uk>
Subject: Re: [Pull request] Support for wm9705 codec and two
 machines that use it.
Date: Fri, 16 Jan 2009 11:34:41 +0000
Message-ID: <497070D1.50301@mnementh.co.uk>
References: <496E8DD0.4090006@mnementh.co.uk>	<s5hfxjl3v6s.wl%tiwai@suse.de>	<496F0ABD.4080207@mnementh.co.uk>
	<s5hk58v4inq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mnementh.co.uk (mail.mnementh.co.uk [173.45.232.4])
	by alsa0.perex.cz (Postfix) with ESMTP id BBD421038E1
	for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2009 12:34:12 +0100 (CET)
In-Reply-To: <s5hk58v4inq.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Thu, 15 Jan 2009 10:06:53 +0000,
> Ian Molton wrote:

> Shouldn't be this "reg >= ARRAY_SIZE(wm9705_reg)" ?

Looks that way. Will fix.

I've spotted the same error in a couple of other drivers too.

It looks like register caching is a very common thing, would you be 
interested in a patch that consolidates the cache handling in soc-core, 
rather than having multiple possibly broken implementations around?

Also, I could be wrong, but wm8980 caching looks completely broken 
(array is type u16 but there is no register shift applied, AFAICT)

fixed in wm9705 for now anyway.

> Ditto, should be "reg < ARRAY_SIZE(wm9705_reg)".

Fixed.

> You can use kmemdup() here.

Changed.

TTFN,

-Ian
