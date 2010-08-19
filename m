From: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Subject: Re: [PATCH v6 0/1] A codec driver for the TI WL1273 FM
 Radio.
Date: Thu, 19 Aug 2010 09:57:43 +0300
Message-ID: <1282201063.14489.142.camel@masi.mnp.nokia.com>
References: <1282045280-16696-1-git-send-email-matti.j.aaltonen@nokia.com>
	<1282125215.14489.114.camel@masi.mnp.nokia.com>
	<20100818120454.GA15536@sirena.org.uk>
	<1282138337.14489.129.camel@masi.mnp.nokia.com>
	<20100818134533.GA4588@rakim.wolfsonmicro.main>
Reply-To: matti.j.aaltonen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A76B243AB
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Aug 2010 08:57:41 +0200 (CEST)
In-Reply-To: <20100818134533.GA4588@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-08-18 at 15:45 +0200, ext Mark Brown wrote:
> > My mail was meant as a friendly remainder, I've more used to get replies
> > like: "thanks for reminding me"... 
> 
> A friendly reminder if it looks like things have been forgotten is one
> thing, but a reminder after less than 24 hours doesn't come over as
> that.
> 
> > But I sent the version five of the codec on the fifth of August and got
> > no comments to that either and then I sent version six just because I
> > had had a change to test it. So for me it was almost two weeks, which
> > still perfectly fine... I just sent that message with I thought was
> > perfectly unoffensive.
> 
> You got comments on v5 - both Liam and myself replied to your v5 posting
> reminding you to update for multi-component.

We might as well have the facts right:

Above you are talking about v3 because v4 was the first multi component
version:

And to that you (Mark) commented:

> This basically looks OK but...
> 
> > +/* codec private data */
> > +struct wl1273_priv {
> > +     struct snd_soc_codec codec;
> > +     enum wl1273_mode mode;
> > +     struct wl1273_core *core;
> > +     unsigned int channels;
> > +};
> 
> ...why would anything outside the driver be peering > into this?


Then I sent v5 (on 5 of Aug) to which I got no comment, then I sent v6
after being able to test the codec... And be because I hadn't heard you
in 13 days I wrote the unfortunate phrase: "I haven't heard you in a
while"... Which I meant as a form a small talk and of course as way to
get attention, which I got...

Thanks,
Matti.
