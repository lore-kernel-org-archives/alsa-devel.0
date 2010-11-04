From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: ALSA UCM
Date: Thu, 04 Nov 2010 19:07:08 +0000
Message-ID: <1288897628.3277.99.camel@odin>
References: <AANLkTimFdKg=_KDv8fbSJry6XTEsZqyQz7GhzaPxXDYP@mail.gmail.com>
	<1288865349.3277.14.camel@odin>
	<AANLkTim1Aopc2ALEXoWorPjzua0gGoSef8CpH+At4_cp@mail.gmail.com>
	<1288890598.3277.81.camel@odin>
	<alpine.LNX.2.00.1011041932410.29422@eeebox2.perex-int.cz>
	<1288896461.3277.98.camel@odin>
	<alpine.LNX.2.00.1011041949180.29422@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id CE9442442A
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2010 20:07:11 +0100 (CET)
Received: by eyg24 with SMTP id 24so1224948eyg.38
	for <alsa-devel@alsa-project.org>; Thu, 04 Nov 2010 12:07:11 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1011041949180.29422@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, abraham duenas <aduejazz@gmail.com>, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-11-04 at 19:52 +0100, Jaroslav Kysela wrote:
> On Thu, 4 Nov 2010, Liam Girdwood wrote:
> 
> > On Thu, 2010-11-04 at 19:34 +0100, Jaroslav Kysela wrote:
> >> On Thu, 4 Nov 2010, Liam Girdwood wrote:
> >>
> >>>> 	Value {
> >>>> 	      MasterPlaybackVolume "name='Headset Playback Volume' 1"
> >>>> 	      MasterCaptureVolume "name='Capture Volume' 1"
> >>
> >> What does mean '1'? If you like to define element id index, use:
> >>
> >
> > Ah, that looks a conversion bug from Abrahams old file format to his new
> > format. I guess it caught out the parser too here.
> >
> > Abraham, could you check over your configuration files and send a patch
> > for the parser that spits an error out here.
> >
> >> MasterPlaybackVolume "name='Headset Playback Volume',index=1"
> >
> > My preference is not to use the ID since it can sometimes change with
> > driver updates. The names are pretty constant though.
> 
> You probably mean unique numid for each control? Index is just an index 
> for the ASCII name to distinguish controls with same name (I think that 
> you had a syntax name:index in the original code).

I do indeed :)

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
