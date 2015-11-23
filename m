From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: multi-codec support for arizona-ldo1 was Re:
 System with multiple arizona (wm5102) codecs
Date: Mon, 23 Nov 2015 10:25:22 +0000
Message-ID: <1448274322.3536.45.camel@rf-debian.wolfsonmicro.main>
References: <20151113215812.GA19020@amd>
 <20151113225355.GU12392@sirena.org.uk> <20151114074400.GA7898@amd>
 <20151114123931.GW12392@sirena.org.uk> <20151114175915.GA20429@amd>
 <20151114184940.GY12392@sirena.org.uk> <20151114211633.GE20429@amd>
 <20151116141142.GE18889@ck-lbox> <20151122065140.GC26074@amd>
 <20151123081857.GF3098@x1>  <20151123101145.GA1452@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A2E82651ED
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 11:25:56 +0100 (CET)
In-Reply-To: <20151123101145.GA1452@amd>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Machek <pavel@ucw.cz>
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, tiwai@suse.de, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2015-11-23 at 11:11 +0100, Pavel Machek wrote:
> On Mon 2015-11-23 08:18:57, Lee Jones wrote:
> > On Sun, 22 Nov 2015, Pavel Machek wrote:
> > 
> > > On Mon 2015-11-16 14:11:42, Charles Keepax wrote:
> > > > On Sat, Nov 14, 2015 at 10:16:33PM +0100, Pavel Machek wrote:
> > > > > HiOn Sat 2015-11-14 18:49:40, Mark Brown wrote:
> > > > > > On Sat, Nov 14, 2015 at 06:59:16PM +0100, Pavel Machek wrote:
> > > > > > 
> > > > > > > Well, mfd_core.c seems to call regulator_bulk_register_supply_alias()
> > > > > > > with device that does not have dev_name initialized.
> > > > > > 
> > > > > > OK, that'll be the problem then - we're not mapping the supply into the
> > > > > > individual child device but rather system wide, probably because that
> > > > > > mapping is being done too early, before we've actually created the
> > > > > > device.
> > > > > 
> > > > > Take a look at mfd_add_device(). Yes, we do
> > > > > regulator_bulk_register_supply_alias() before doing
> > > > > platform_device_add().
> > > > > 
> > > > > > > regulator_bulk_register_supply_alias() results in "Adding alias"
> > > > > > > stuff, and then drivers/regulator/arizona-micsupp.c tries to register
> > > > > > > another "MICVDD".
> > > > > > 
> > > > > > That's fine because all supplies should be namespaced with a device.
> > > > > > The goal is to say "Supply X on device Y" (we do support exceptions for
> > > > > > the few cases where there are not yet any devices involved but this
> > > > > > clearly isn't one of them).
> > > > 
> > > > Indeed that should be the case.
> > > > 
> > > > > 
> > > > > Well, clearly someone should tell that to wm5102
> > > > > maintainers. Hmm. It looks like driver is marked supported but there
> > > > > are no names attached?
> > > > > 
> > > > > WOLFSON MICROELECTRONICS DRIVERS
> > > > > L:      patches@opensource.wolfsonmicro.com
> > > > > T:      git git://opensource.wolfsonmicro.com/linux-2.6-asoc
> > > > > T:      git git://opensource.wolfsonmicro.com/linux-2.6-audioplus
> > > > > W:
> > > > > http://opensource.wolfsonmicro.com/content/linux-drivers-wolfson-device\
> > > > > s
> > > > > S:      Supported
> > > > > 
> > > > > I guess Charles Keepax should be listed there?
> > > > 
> > > > The patches mailing list functions as maintainer here. That way
> > > > anyone who works on upstream Linux stuff here will see the email
> > > > so you have more chance of someone replying. Also convient for
> > > > when people leave the company etc. makes for an easy transition.
> > > > I am afraid though that as in this case you are not always going
> > > > to get a reply over the weekend.
> > > 
> > > Well.. maintainer is a responsible person. Yes, you can list a mailing
> > > list in maintainers file.. but mailing list is not going to be
> > > responsible for that.
> > > 
> > > Having a real name of person helps; if your name was listed there, I'd
> > > know you (are supposed to be) authoritative person for this.
> > > 
> > > I see it will need to be updated from time to time, but having name
> > > really helps.
> > 
> > A Mailing List is perfectly adequate for drivers which reside in a
> > maintained subsystem.  No requirement to submit names, particularly if
> > there are lots of authorities personnel or if the personalities change
> > regularly.
> 
> That's what I'm saying. It is good to know who is the person of
> authority, as you can't tell from the From: address.
> 									Pavel

It's unreasonable to expect that one member of the Cirrus software team
has the time to answer every inquiry about our drivers and never goes on
vacation, or that there's only one person who is an authority about the
drivers. There's a mailing list for a reason.
