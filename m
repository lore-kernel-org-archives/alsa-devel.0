From: Caleb Crome <caleb@crome.org>
Subject: Re: Proposed changes to soc core to allow multiple
 codecs bound together on a single bus
Date: Thu, 9 Jun 2011 12:23:22 -0700
Message-ID: <BANLkTimCfF15KFMHrsCS5AZpTUgT8mg=Xw@mail.gmail.com>
References: <BANLkTimBmj+BROhu9b-+wQRXUQa6ABpOBQ@mail.gmail.com>
	<20110606105115.GB12783@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F82B103BF5
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Jun 2011 21:23:24 +0200 (CEST)
Received: by pwi9 with SMTP id 9so939283pwi.38
	for <alsa-devel@alsa-project.org>; Thu, 09 Jun 2011 12:23:22 -0700 (PDT)
In-Reply-To: <20110606105115.GB12783@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks for the feedback Liam and Mark.

I'll take a look at the PCM changes, that would be great if it'll work for
my situation, because something similar to what i was thinking would require
major changes (at least as far as my feble brain is concerned).

I've checked out Liam's PCM code base, but haven't taken a look yet -- since
my driver's now more-or-less working, I'm actually testing out my board...

Thanks,
  -Caleb




On Mon, Jun 6, 2011 at 3:51 AM, Mark Brown <
broonie@opensource.wolfsonmicro.com> wrote:

> On Fri, Jun 03, 2011 at 05:04:12PM -0700, Caleb Crome wrote:
>
> > static char *my_codec_dais[] = {
> >      "tlv320aic3x-hifi.0",   <---- in this case, the '.0'
> >      "tlv320aic3x-hifi.1",    ---- means that it's slot 0
> >      "tlv320aic3x-hifi.2",    ---- on the TDM bus.
> >      "tlv320aic3x-hifi.3",
> > };
> > static char *my_codec_names[] = {
> >      "tlv320aic3x-codec.2-0018", <--- codec on i2c bus 2, addr 0x18
> >      "tlv320aic3x-codec.2-0019", <--- codec on i2c bus 2, addr 0x19
> >      "tlv320aic3x-codec.2-001a", <--- codec on i2c bus 2, addr 0x1a
> >      "tlv320aic3x-codec.2-001b", <--- codec on i2c bus 2, addr 0x1b
> > };
>
> I don't like the need to line the two arrays up, and the DAI names
> really ought to be enough anyway (this applies in general, not just
> here).
>
> > The core will parse the dai name for the slot order, and pass it on to
> the
> > codec during hw_params.  Then the codec can properly set the TDM slot on
> the
> > hardware interface.
>
> No, the machine driver needs to own the TDM configuration.  We need to
> have the flexibiltiy for the system to use arbatrary arrangements for
> things like buses with more than two devices on them and we need to be
> able to cope with random layouts of the channels (for example, all the
> left channels on one device, all the right channels on another device).
> We also need to be able to change this dynamically at runtime depending
> on the current needs of the system.
>
