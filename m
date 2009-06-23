From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: submitting patches to ALSA
Date: Tue, 23 Jun 2009 13:36:29 +0530
Message-ID: <98769532B4BB14429434178695419EAE5B8FB971@bgsmsx501.gar.corp.intel.com>
References: <BAY119-W8E3C7EC7BE9C8606E2D28B0480@phx.gbl>
	<98769532B4BB14429434178695419EAE5B719DC3@bgsmsx501.gar.corp.intel.com>
	<s5hws78emcn.wl%tiwai@suse.de>
	<98769532B4BB14429434178695419EAE5B7F85FD@bgsmsx501.gar.corp.intel.com>
	<s5heitfpdiu.wl%tiwai@suse.de>
	<98769532B4BB14429434178695419EAE5B89FFDC@bgsmsx501.gar.corp.intel.com>
	<s5hab40oif2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id C3B36245F4
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Jun 2009 10:07:07 +0200 (CEST)
In-Reply-To: <s5hab40oif2.wl%tiwai@suse.de>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Another quick question... Apologies for asking basic questions here... (Since it's my first time)

Do I need to mail the patches only here? Or need I mail it to Linux list as well to get feedback and acceptance.

Thanks,
Harsha


-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: Monday, June 22, 2009 12:38 PM
To: Harsha, Priya
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] submitting patches to ALSA

At Mon, 22 Jun 2009 12:34:55 +0530,
Harsha, Priya wrote:
> 
> Its independent of the sound stuff but the driver will just not get
> enumerated and will not be able to function with 2 other dependant
> drivers which are required for the platform.

In that case, make the Kconfig of the sound driver part dependent on
other base driver/platform Kconfig item, so that it won't be built
until the base part gets merged.


Takashi

> 
> Thanks,
> Harsha
> 
> 
> 
> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de] 
> Sent: Saturday, June 20, 2009 1:01 PM
> To: Harsha, Priya
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] submitting patches to ALSA
> 
> At Sat, 20 Jun 2009 08:37:03 +0530,
> Harsha, Priya wrote:
> > 
> > Thanks Takashi.
> > 
> > I have tested it already with aplay, papaly and firefox flash, etc,.
> > 
> > Regarding the firmware binary, need I send it as a part of the patch
> > in the email or can I be upload it in a common location where anyone
> > can access it?
> 
> Just as you like.  I don't care in which way.
> 
> > Also, I am waiting for few dependant drivers to be submitted for
> > upstream before I can submit my patches otherwise it would break.
> 
> Oh, is it completely independent from the sound stuff, or could it be
> a part of a big change including the sound driver?
> 
> 
> thanks,
> 
> Takashi
> 
> > 
> > Thanks,
> > Harsha
> > 
> > 
> > 
> > -----Original Message-----
> > From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Takashi Iwai
> > Sent: Friday, June 19, 2009 12:34 PM
> > To: Harsha, Priya
> > Cc: alsa-devel@alsa-project.org
> > Subject: Re: [alsa-devel] submitting patches to ALSA
> > 
> > At Thu, 18 Jun 2009 21:33:54 +0530,
> > Harsha, Priya wrote:
> > > 
> > > Hi,
> > > 
> > > This is the first time I am planning to submit patches to ALSA. Are
> > > there any tips/rules I need to follow?
> > 
> > In general, the rule for LKML is applied here, too.
> > 
> > > I have followed the general guidelines like checkpatch, testing with
> > > different debug configs etc.
> > 
> > Great.
> > 
> > > I have a few questions;
> > > 1. Against which kernel tree should I create patches to submit to
> > > ALSA devel mailing list?
> > 
> > Try to apply always to the latest tree, e.g. sound git tree below
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
> > 
> > > 2. I have to download firmware as a part of my driver. This firmware
> > > file is freely distributable. How should I share the firmware binary
> > > file when I send the patches? The firmware binary file would reside
> > > in /lib/firmware
> > 
> > The firmware file would be either in alsa-firmware package or in
> > linux-firmware package.  First you can put it to alsa-firmware
> > package, and we can push them to the upstream linux-firmware package
> > once after your driver gets merged.
> > 
> > > 3. Is there anything else I need to send to the mailing list in
> > > addition to the patches?
> > 
> > A good series of patches is self-explanatory :)
> > 
> > > 4. Are there any test suits that I can use to test the driver?
> > 
> > It's a timely question.  We want to discuss this, especially per
> > request from LSB.  In short answer: no test suits for the time being.
> > Most people tested with aplay and speaker-test as standard test
> > programs.
> > 
> > 
> > thanks,
> > 
> > Takashi
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > 
> 
