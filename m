From: Zinx Verituse <zinx@epicsol.org>
Subject: Re: CMI9739A
Date: Sun, 12 Dec 2004 04:57:07 -0600
Message-ID: <20041212105707.GA7019@bliss>
References: <20041125004649.GA21551@bliss> <s5hact5oqa6.wl@alsa2.suse.de> <20041130020525.GA2591@bliss> <s5h1xebps0f.wl@alsa2.suse.de> <20041212093013.GA338@bliss>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from imf24aec.mail.bellsouth.net (imf24aec.mail.bellsouth.net [205.152.59.72])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 58994351
	for <alsa-devel@alsa-project.org>; Sun, 12 Dec 2004 11:56:59 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <20041212093013.GA338@bliss>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 12, 2004 at 03:30:13AM -0600, Zinx Verituse wrote:
> 
> Results:
> 72 0001 does nothing.
> 
> However, setting one of the registers that actually differs - 64 - does
> fix it.  The other registers that changed (6c, 70) seemed to have no effect.
> 
> Non-working value for register 0x64: 0x5400
> Working value for register 0x64: 0x1438
> 
> Also working value for register 0x64: 0x0010
> 
> Bit 4 doesn't appear to be documented in the source, or in the CM9739
> documentation, and it actually defaults to 0x1438 here rather than 0x0000,
> so I've made a patch that just keeps the value (luckily, it seems to default
> to on when the card is initialized).
> 
> The patch also includes the id for the 9739A.
> The patch is against 2.6.10-rc3, but it's fairly simple so it shouldn't
> be too hard to apply by hand if it fails.

Apparently this single bit isn't enough for surround; I should have checked
that.  Bit 3 is also needed for surround, and I wouldn't doubt bit 5 being
needed for something.

-- 
Zinx Verituse                                    http://zinx.xmms.org/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
