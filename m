From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [Pull request] Support for wm9705 codec and two
	machines that use it.
Date: Fri, 16 Jan 2009 11:54:09 +0000
Message-ID: <20090116115408.GB7554@sirena.org.uk>
References: <496E8DD0.4090006@mnementh.co.uk> <s5hfxjl3v6s.wl%tiwai@suse.de>
	<496F0ABD.4080207@mnementh.co.uk>
	<s5hk58v4inq.wl%tiwai@suse.de> <497070D1.50301@mnementh.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C12FE1038E1
	for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2009 12:54:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <497070D1.50301@mnementh.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 16, 2009 at 11:34:41AM +0000, Ian Molton wrote:

> It looks like register caching is a very common thing, would you be 
> interested in a patch that consolidates the cache handling in soc-core, 
> rather than having multiple possibly broken implementations around?

There's gotchas with variable register sizes and volatile bits (this was
originally done more in the core but pushed out).  I've looked at it
before and it looked like the best way to handle it was to do it along
with a factoring out of common I/O routines.  Possibly best to leave it
for now.

> Also, I could be wrong, but wm8980 caching looks completely broken 
> (array is type u16 but there is no register shift applied, AFAICT)

There's normally a reason for the non-mainline drivers being that way
but in this case that's not it - the chip has 16 bit registers and the
cache is being worked with as u16 * so natural array indexing should
DTRT.

Please post an incremental patch with your other changes.
