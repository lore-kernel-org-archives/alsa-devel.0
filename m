From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: [PATCH 3/4] Add Wolfson Microelectronics WM8776
	codec ALSA driver
Date: Tue, 17 Apr 2012 23:07:48 +0200
Message-ID: <201204172307.58016.linux@rainbow-software.org>
References: <1334611118-10301-1-git-send-email-linux@rainbow-software.org>
	<201204172015.14582.linux@rainbow-software.org>
	<s5hy5punpem.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.atlantis.sk (mail-1-out2.atlantis.sk [80.94.52.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 8971D24402
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Apr 2012 23:08:30 +0200 (CEST)
In-Reply-To: <s5hy5punpem.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tuesday 17 April 2012 21:12:33 you wrote:
> At Tue, 17 Apr 2012 20:15:06 +0200,
>
> Ondrej Zary wrote:
> > On Tuesday 17 April 2012 20:06:19 Takashi Iwai wrote:
> > > At Tue, 17 Apr 2012 18:04:31 +0100,
> > >
> > > Mark Brown wrote:
> > > > On Tue, Apr 17, 2012 at 06:52:49PM +0200, Takashi Iwai wrote:
> > > > > Mark Brown wrote:
> > > > > > This isn't just adding something into a specific driver which
> > > > > > fails at abstraction, it's adding generic code.  If it were
> > > > > > adding something to the ice17xx driver then that'd be one thing
> > > > > > but look at the subject line and location of the file...  this
> > > > > > stuff should be buried inside the driver if it's too painful to
> > > > > > make the driver sane.
> > > > >
> > > > > The codes in sound/i2c are mostly oly for ice1712/ice1724 drivers
> > > > > after all...  They could be used by others, but I don't think there
> > > > > will be any more at this point.
> > > >
> > > > If they're specific to that driver we should make them specific to
> > > > that driver and make sure the pain is confined there.  We really
> > > > don't want to end up going back to the bad old days of having to do
> > > > per-CPU/card drivers for CODECs because nobody had thought to
> > > > abstract this stuff, that just makes everyone miserable.
> > > >
> > > > Looking at these commits I'd not expect anyone to figure out that
> > > > this isn't how we want or expect people to add generic CODEC drivers.
> > >
> > > Yeah, these stuff can be better put in pci/ice1712/ directory only
> > > for ice1724 driver.  In that way, you can avoid unnecessary exported
> > > symbols, too.
> >
> > Xonar (oxygen) has a private version of these drivers too. It could be
> > converted to use common code instead.
>
> Hm, only if the generated controls do match with your case,..
> It's case by case, especally if there is only one another candidate.

Control names can be changed (and also disabled) by the driver. In fact, 
psc724 does exactly this as is needs the WM8776 controls to be named 
as "front" and WM8766 as "rear".
I don't see any problem if something needs to be changed for this code to be 
used by Xonar (or some other driver).

-- 
Ondrej Zary
