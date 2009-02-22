From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: snd_pcm_hw_params_get_period_size points to __old_
 symbol
Date: Sun, 22 Feb 2009 22:32:04 +0000
Message-ID: <1235341924.27887.555.camel@vega.slimlogic.co.uk>
References: <20090222213553.GA5893@buzzloop.caiaq.de>
	<1235340956.27887.547.camel@vega.slimlogic.co.uk>
	<20090222222228.GE5893@buzzloop.caiaq.de>
	<1235341488.27887.552.camel@vega.slimlogic.co.uk>
	<20090222222739.GF5893@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from slimlogic.co.uk (slimlogic.co.uk [89.16.172.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B253244E4
	for <alsa-devel@alsa-project.org>; Sun, 22 Feb 2009 23:32:06 +0100 (CET)
In-Reply-To: <20090222222739.GF5893@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2009-02-22 at 23:27 +0100, Daniel Mack wrote:
> On Sun, Feb 22, 2009 at 10:24:48PM +0000, Liam Girdwood wrote:
> > > > Please either build alsa-lib natively or with OpenEmbedded.
> > > 
> > > This is rather unpracticable for us as we build the whole system with
> > > buildroot. Hence, I'd rather go and fix it. Any hint about what could
> > > possibily go wrong during the build phase which would explain that bug
> > > to happen? A missing/wrong define, bogus configure arguments?
> > > 
> > 
> > Probably best to check against OE alsa-lib config arguments. They have
> > gitweb now for easy browsing.
> 
> Ok, will do and let you know. So probably both my questions would have
> the same root cause, which would be great :)

Hopefully :)

The only other major ARM alsa-lib PITA is gcc 4.1.1. It would optimise
out PCM refinement. Although OE patched their gcc years ago so probably
not an issue anymore.

Liam
