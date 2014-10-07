From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [alsa-devel] Workable vintage driver support mechanism? (Re:
 [PATCH v3] ES938 support for ES18xx driver)
Date: Tue, 7 Oct 2014 11:44:47 +0100
Message-ID: <20141007114447.35379ef7@alan.etchedpixels.co.uk>
References: <1412027079-15876-1-git-send-email-linux@rainbow-software.org>
	<s5h7g0dzgd5.wl-tiwai@suse.de>
	<201410061555.19007.linux@rainbow-software.org>
	<s5ha959xp53.wl-tiwai@suse.de>
	<20141006184150.GA2465@rhlx01.hs-esslingen.de>
	<5432F060.5060307@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5432F060.5060307@ladisch.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Andreas Mohr <andi@lisas.de>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Ondrej Zary <linux@rainbow-software.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 06 Oct 2014 21:41:20 +0200
Clemens Ladisch <clemens@ladisch.de> wrote:

> Andreas Mohr wrote:
> > I think I have an idea which might be useful to accept:
> > for every piece of sufficiently "vintage" submission,
> > people would be tasked with offering (or somehow ensuring)
> > a sufficiently closely time-related cleanup in other places.
> 
> The problem that such a new driver imposes is not a one-time reduction
> in overall kernel quality, but the ongoing maintenance effort.

Vintage is not IMHO a useful test. We have plenty of vintage hardware
with active hands-on maintainers which causes no problem, and plenty of
modern drivers with basically no maintainer that causes endless problems.

I think there is much merit in the Debian approach - if it's not got a
maintainer, and nobody is willing to take it on, throw it out. If it's
got a maintainer leave it in.

Economics will resolve the rest of the problem reasonably efficiently. If
someone cares enough about using it then they'll figure out how to keep
it maintained.

Alan
