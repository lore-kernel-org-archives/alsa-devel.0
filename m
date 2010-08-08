From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: Use Case Manager Test Drive [Was: Re: ASoC: Hiding
 unused CODEC mixer widgets in the machine driver]
Date: Sun, 08 Aug 2010 10:25:31 +0100
Message-ID: <1281259531.3100.9.camel@odin>
References: <20100806001844.GM15884@atomos.longlandclan.yi.org>
	<20100806111935.GA31326@sirena.org.uk> <1281094453.3077.46.camel@odin>
	<1281094963.3077.59.camel@odin>  <4C5DE74B.6090106@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 84CEB2414F
	for <alsa-devel@alsa-project.org>;
	Sun,  8 Aug 2010 11:25:37 +0200 (CEST)
Received: by wwb31 with SMTP id 31so491368wwb.20
	for <alsa-devel@alsa-project.org>; Sun, 08 Aug 2010 02:25:34 -0700 (PDT)
In-Reply-To: <4C5DE74B.6090106@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stuart Longland <redhatter@gentoo.org>
Cc: tiwai@suse.de, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Justin Xu <justin.oxu@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sun, 2010-08-08 at 09:07 +1000, Stuart Longland wrote:
> Hi Mark, Liam...
> On 08/06/10 21:42, Liam Girdwood wrote:
> > On Fri, 2010-08-06 at 12:34 +0100, Liam Girdwood wrote:
> >> On Fri, 2010-08-06 at 12:19 +0100, Mark Brown wrote:
> >>> The machine driver shouldn't be doing this - it's too fragile in the
> >>> face of any changes in the drivers and means hard coding use cases into
> >>> the kernel which is really bad practice since it's much slower than
> >>> doing things from user space and much harder to change as new needs
> >>> arise.
> >>
> >> Please do give UCM (Use Case Manager) a test drive. We are in the late
> >> development / early testing phase before upstreaming (still one or two
> >> things todo).
> >>
> >> You will need to checkout the use-case-verb branches of :-
> >>
> >> git://git.slimlogic.co.uk/alsa-lib.git
> >>
> >> git://git.slimlogic.co.uk/alsa-utils.git
> >>
> >> There is a tool called alsaucm that allows changing the use case from
> >> the command line. Best to use it's interactive (-i) mode atm.
> >>
> >> There is also an initial repository for UCM use case configuration files
> >> here :-
> >>
> >> git://git.slimlogic.co.uk/alsa-ucm-conf.git
> >>
> >> This will show the format required to describe use cases.
> >>
> > 
> > Forgot to add that patches are most welcome.
> 
> No worries... I can see there being possible issues with the machine
> driver being highly sensitive to changes to the CODEC driver, I was just
> curious if there was some mechanism for abstracting this.
> 
> However, a userspace solution will probably work well... I'll have a
> look and report back any findings.  How close is this to being merged
> into the main alsa-lib and alsa-utils trees?
> 

We are aiming for sometime in the next two weeks. There are still
roughly two things that need fixing:-

1) Drop the control ID from the use case configuration files. i.e.

In order to enable the 'DL1 Mixer Multimedia' path we have a config like

73:'DL1 Mixer Multimedia':1:1

this would just become

'DL1 Mixer Multimedia':1:1

This way we are not reliant on ID numbers that can easily change when
driver updates occur (something that is catching me atm with a new
driver). The control names are always very constant and unique though.

2) Add a small shared memory segment to store state information for
multiple client access.

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
