From: "Jarkko Nikula" <jhnikula@gmail.com>
Subject: Re: [PATCH] asoc tlv320aic3x: add GPIO support
Date: Mon, 21 Apr 2008 16:41:35 +0300
Message-ID: <bd7b27490804210641p337ee8b0h1668ac66c1cc13df@mail.gmail.com>
References: <20080418181214.GB26197@buzzloop.caiaq.de>
	<bd7b27490804181326v311f192bi8454c9c0661427d2@mail.gmail.com>
	<20080419004103.GA29770@buzzloop.caiaq.de>
	<20080419112425.GA18877@sirena.org.uk>
	<20080419121838.GA1680@buzzloop.caiaq.de>
	<20080419145005.GA23492@sirena.org.uk>
	<20080419162418.GA3177@buzzloop.caiaq.de>
	<20080419185129.GB3559@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by alsa0.perex.cz (Postfix) with ESMTP id 29320243E9
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Apr 2008 15:41:41 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so504207ana.80
	for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2008 06:41:35 -0700 (PDT)
In-Reply-To: <20080419185129.GB3559@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 19, 2008 at 9:51 PM, Mark Brown <
broonie@opensource.wolfsonmicro.com> wrote:

> On Sat, Apr 19, 2008 at 06:24:18PM +0200, Daniel Mack wrote:
> > On Sat, Apr 19, 2008 at 03:50:06PM +0100, Mark Brown wrote:
>
> > > In the case of jack detect I'm actually currently working on a
> > > generalisation of that since it's such a common feature.  I hope to
> have
> > > something in the next week or two but it depends on my other work.
>
> > I attached a patch for a proprietary interface - is that what you were
> > talking about? Would that approach be mergeable with your generic jack
> > detect code?
>
> Yes, that was the sort of thing I was thinking about - looks good from
> an API perspective, though I've not looked at the code properly yet.  It
> should fit in with the jack detect code, the idea is more to let drivers
> push notifications of jack detect status - it doesn't really care how
> the driver detects the jack status.
>

This latest version looks ok to me. IMO we can use this as a base for
further development.


Jarkko
