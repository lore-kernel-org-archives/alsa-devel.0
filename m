From: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Subject: Re: [PATCH] ASoC: WL1273 FM radio: Access I2C IO
 functions through pointers.
Date: Mon, 17 Jan 2011 16:58:14 +0200
Message-ID: <1295276294.25951.54.camel@masi.mnp.nokia.com>
References: <1294924965-6358-1-git-send-email-matti.j.aaltonen@nokia.com>
	<1294925701.3453.5.camel@odin>
	<1294928273.6390.5.camel@masi.mnp.nokia.com>
	<20110113150113.GC20480@sirena.org.uk>
	<1294935501.6390.44.camel@masi.mnp.nokia.com>
	<20110113171202.GG30351@opensource.wolfsonmicro.com>
	<1294990984.6390.81.camel@masi.mnp.nokia.com>
	<20110114122250.GC20846@opensource.wolfsonmicro.com>
	<1295254346.25951.23.camel@masi.mnp.nokia.com>
	<20110117135634.GB21113@opensource.wolfsonmicro.com>
Reply-To: matti.j.aaltonen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa01.nokia.com (smtp.nokia.com [147.243.1.47])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B36A10386D
	for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2011 15:58:17 +0100 (CET)
In-Reply-To: <20110117135634.GB21113@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, ext Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-01-17 at 13:56 +0000, ext Mark Brown wrote:
> On Mon, Jan 17, 2011 at 10:52:26AM +0200, Matti J. Aaltonen wrote:
> > On Fri, 2011-01-14 at 12:22 +0000, ext Mark Brown wrote:
> > > help
> > > Normally ASoC codec drivers are only built if a
> > > machine driver which uses them is also built since
> > > they are only usable with a machine driver. 
> > > Selecting this option will allow these drivers to be
> > > built without an explicit machine driver for test
> > > and development purposes.
> 
> I'm not entirely clear how that follows from the above?  The issue here
> is primarily in terms of test building with SND_SOC_ALL_CODECS.

Would you be happy with the following change?

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 937517a..c2b39fa 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -43,7 +43,7 @@ config SND_SOC_ALL_CODECS
        select SND_SOC_TWL6040 if TWL4030_CORE
        select SND_SOC_UDA134X
        select SND_SOC_UDA1380 if I2C
-       select SND_SOC_WL1273 if RADIO_WL1273
+       select SND_SOC_WL1273
        select SND_SOC_WM2000 if I2C
        select SND_SOC_WM8350 if MFD_WM8350
        select SND_SOC_WM8400 if MFD_WM8400

That way the compilation of the codec would be independent of the rest
of the driver...

> > And as I said, with my original design the core (MFD) could have been
> > compiled (and used) with either child driver: the codec and the V4L2
> > part. A fact is that Mauro didn't accept that structure, he wanted to
> > have all functionality (except for the audio) in the V4L2 driver.
> 
> I don't particularly care if the resulting driver is useful but it
> should at least be possible to build the two subsystems independantly.
> If it's not even possible to do that then why is there a MFD driver in
> the first place?

After I had to break the original design of functional core with add-on
interfaces, I have also started question things... But actually I didn't
remember the above Kconfic dependence to the V4L2 driver (I was mainly
thinking about building a codec that can in some sense be run)...

> > And also the question is: what should be done now or next. If you mean
> > that the dependence between V4L2 part and the core should be removed,
> > that's easy to do but what's we gain with that? I would like to return
> > to the original structure, but that doesn't seem to be possible?
> 
> It means we'd be able to get build coverage of each subsystem without
> having to enable the other, having to pick up only the core rather than
> an entire new subsystem.

With above change you only need to have the core header file in place
and then the codec can be compiled.
