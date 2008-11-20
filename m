From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: twl4030 asoc kcontrols and widgets
Date: Thu, 20 Nov 2008 07:39:14 -0800
Message-ID: <5e088bd90811200739x537252efx94e3fbe4e2303180@mail.gmail.com>
References: <ef0d8a250811200138y36fc840dn9978dd862214dec4@mail.gmail.com>
	<200811201602.44035.peter.ujfalusi@nokia.com>
	<20081120141401.GG4539@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gv-out-0910.google.com (gv-out-0910.google.com [216.239.58.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 91A5C243FA
	for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2008 16:39:15 +0100 (CET)
Received: by gv-out-0910.google.com with SMTP id i36so132757gve.24
	for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2008 07:39:14 -0800 (PST)
In-Reply-To: <20081120141401.GG4539@sirena.org.uk>
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
To: Mark Brown <broonie@sirena.org.uk>
Cc: ext naveen krishna ch <naveenkrishna.ch@gmail.com>, alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Steve Sakoman <steve@sakoman.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 20, 2008 at 6:14 AM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Thu, Nov 20, 2008 at 04:02:43PM +0200, Peter Ujfalusi wrote:
>
>> My plan is to add _all_ (ok, almost all) the features we can get with
>> TWLx030...
>> So instead of having 'only' one possible route from DACl2/DACR2, I have
>> implemented in a reverse order:
>
> ...
>
>> With this mode one can enable whatever combination of routing he/she
>> needs from TWL.
>
>> Since these channels are really 'independent' inside of TWL, making the
>> routing/mixing flexible (you might say extremely flexible) could make
>> sense.
>
> This is good - an ASoC codec driver should expose as much functionality
> of the codec as possible and let user space configure it at runtime.
> See for example the WM8900 or WM8990 drivers for examples of codecs with
> fairly complex audio routing.

Agreed! This is a really good thing to do.

Had I not been under a lot of time pressure when doing the original
version of the driver I would have taken this approach myself.

I'm glad to see that you are tackling this.  Peter, you should post
your patches for comment.  Might help speed things along if we get
more folks looking and contributing.

Steve
