From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: ESI reply!! (MAYA44 datasheet request)
Date: Wed, 22 Aug 2007 19:17:19 -0700
Message-ID: <1187835439.4189.315.camel@razman.gruemaster.com>
References: <20070822152207.5959424468@alsa0.perex.cz>
	<s5h4pirnsre.wl%tiwai@suse.de> <46CCB433.1030704@gmail.com>
	<s5h6437w5rm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 66BF31037F6
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Aug 2007 04:17:21 +0200 (CEST)
In-Reply-To: <s5h6437w5rm.wl%tiwai@suse.de>
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
Cc: Claus Riethmueller <claus@esi-audio.com>, alsa-devel@alsa-project.org, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

I can attest to that.  I had to port a Windows driver to Linux for an
internal test card (the card & code never left the building).  The
Windows code was ~50k lines long, and did the exact same thing as my
final Linux driver of ~7500 lines.  Part of the problem was all of the
Windows API's that needed to be included.  Another problem was the
Windows driver was written in C++ with heavy OO code.

Tobin

On Thu, 2007-08-23 at 00:42 +0200, Takashi Iwai wrote:

> At Thu, 23 Aug 2007 00:09:55 +0200,
> Rene Herman wrote:
> > 
> > On 08/22/2007 11:50 PM, Takashi Iwai wrote:
> > 
> > > As James mentioned, the datasheet is vial.  "SOME SORT OF" datasheet
> > > is.  Yes, this can be any document.
> > 
> > Where existing Windows driver source would, I assume, count as "some sort".
> 
> Well, as my personal preference, Windows driver source code isn't
> suitable as the primary information source.  It's good as a reference,
> for example, for debugging a bug in your driver.
> But, the proprietary driver code is often hard to disclose publicly
> than the other technical documents.  And, above all, when you write a
> driver based on windows code, it tends to result in a bad code ;)
> 
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis  


Circumstances rule men; men do not rule circumstances.
		-- Herodotus
