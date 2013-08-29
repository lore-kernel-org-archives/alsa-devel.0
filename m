From: Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH RFC 10/13] ASoC: kirkwood-t5325: add DAPM
 links between codec and cpu DAI
Date: Thu, 29 Aug 2013 23:12:35 +0200
Message-ID: <CAOyKLY_mQzPxHAg2RFSMY89uxp-0-OAf6fC=gVY0i+pQhv4iHQ@mail.gmail.com>
References: <20130820114421.GN30073@sirena.org.uk>
 <20130820114949.GB23006@n2100.arm.linux.org.uk>
 <20130820133143.GC23006@n2100.arm.linux.org.uk>
 <20130820185019.GP30073@sirena.org.uk>
 <20130820201824.GA17845@n2100.arm.linux.org.uk>
 <1377199370.2618.99.camel@loki>
 <20130822201658.GK6617@n2100.arm.linux.org.uk>
 <1377259994.2444.41.camel@loki>
 <20130823125803.GN6617@n2100.arm.linux.org.uk>
 <20130823165800.GB30617@sirena.org.uk>
 <20130823174505.GQ6617@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f180.google.com (mail-ea0-f180.google.com
 [209.85.215.180])
 by alsa0.perex.cz (Postfix) with ESMTP id CE45C265599
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2013 23:12:35 +0200 (CEST)
Received: by mail-ea0-f180.google.com with SMTP id h10so509896eaj.39
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2013 14:12:35 -0700 (PDT)
In-Reply-To: <20130823174505.GQ6617@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 23 August 2013 19:45, Russell King - ARM Linux <linux@arm.linux.org.uk>wrote:

> On Fri, Aug 23, 2013 at 05:58:00PM +0100, Mark Brown wrote:
> > On Fri, Aug 23, 2013 at 01:58:03PM +0100, Russell King - ARM Linux wrote:
> > > The split of the DMA backend from the CPU DAI backend is something
> > > which early ASoC forced, but that has "mostly" been fixed with (as
> > > far as I'm currently aware through testing) the problem I've been
> >
> > Essentially all the dmaengine based platforms in mainline use a shared
> > device for DMA and DAI; I'm fairly sure someone would have mentioned if
> > there were problems.
> >
> > As you have been repeatedly told the Kirkwood drivers are the first
> > drivers submitted to mainline which use DPCM and therefore it is not
> > surprising that there are a few issues which need to be worked through,
> > there were a few revisions to the framework which went in as a result of
> > review during the mainline merge.  The problem you are seeing here is
> > due to this being the first platform with a *shared* device to use DPCM.
>
> So that's why it fails _without_ any DPCM stuff?  That's why the codecs
> fail to have their set_bias stuff called?
>
> Look Mark, frankly, shut your fucking mouth up about DPCM.


I was about to answer your other emails and work on the fix tonight but was
very disappointed in you when I read this statement. There is really no
need to be abusive to anybody on the list and this sort of abuse is very
unprofessional in front of the community and your customers.

I'm sorry, but my motivation to fix the issue tonight has gone. My free
time is short this week as I'm travelling, so I wont be able to look at
this again until Monday now.

This bug has
> nothing what so ever to do with DPCM, and the more times you try and
> state that doesn't change that *FACT*.  And it is a FACT.
>
> You've had this problem described by IRC, including extracts from the
> ASoC code indicating where things go wrong.  I've shown you the debug
> I've used.  I've shown you the result of that debug.  You've had
> descriptions of this problem via email too.  Yet you refuse to acknowledge
> that there could possibly be a problem here.
>
> All the time that you insist that there isn't a problem against factual
> evidence, you're just making yourself look totally incompetent and
> obstructive - not only that but you're making yourself look like a total
> idiot.
>

I think you are doing a lot worse to your reputation with abusive
statements. Please remember that your customers do read this list.


>
> I'm sick to death with you.
>
> You are not a fit person to hold the maintainership role for ASoC in my
> opinion, and you are long past having any ability to change my opinion
> on that anymore, given your obtuseness against this bug.
>
>
I completely disagree with you here.

Do you not see how statements like this will just end up making you look
like someone who is very difficult to work with when faced with a technical
disagreement ? I had acknowledged to you that this had not been tested for
your configuration before you sent this email and that I would fix the
issue.

Liam
