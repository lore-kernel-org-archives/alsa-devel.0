From: "Martin Tufnel" <martin.tufnel@gmail.com>
Subject: Re: hdsp rpm support
Date: Wed, 28 May 2008 22:58:24 +1000
Message-ID: <c62722740805280558k74b5add9ocb6ee622a60aada8@mail.gmail.com>
References: <c62722740805260033t68f1ab1cu7ed5908f803fbacd@mail.gmail.com>
	<200805270814.36011.faber@faberman.de>
	<c62722740805270559q6a47d5fq3e3084a995494e1@mail.gmail.com>
	<200805271508.32695.faber@faberman.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.234])
	by alsa0.perex.cz (Postfix) with ESMTP id 55F3E245FB
	for <alsa-devel@alsa-project.org>;
	Wed, 28 May 2008 14:58:57 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 50so1754312wri.2
	for <alsa-devel@alsa-project.org>; Wed, 28 May 2008 05:58:56 -0700 (PDT)
In-Reply-To: <200805271508.32695.faber@faberman.de>
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
To: Florian Faber <faber@faberman.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Flo

On Tue, May 27, 2008 at 11:08 PM, Florian Faber <faber@faberman.de> wrote:

> Martin,
>
> > > The driver itself won't help you since the old user space tools
> > > don't know the io box. You wouldn't be able to upload the firmware,
> > > adjust the mixer levels etc. (unless you patch the old user space
> > > tools, of course).
> > I'm sorry, I'm a bit confused here.  You said above that "You have
> > IO, you can adjust the input levels, switch standby and disconnect
> > the box. So everything works as you would expect it."
>
> With the hdsp*-tools that are currently part of the alsa-tools suite,
> you cannot control the RPM. Neither can you control a lot of the other
> RME cards. That's going to change with a whole new set of userspace
> tools.
>
> So, if you are curious, I can give you the new driver and a small
> command line program that enables the RPM io box (which is on bypass
> mode by default). Or you wait until I finished the new user space
> tools..
>

Thanks for the clarification and, yes, I'd be interested in having a look at
the new driver - if you don't mind sending it to me that would be great.

Karl seemed to be patching the firmware for some reason - I don't know why.
As Roman points out, the firmware is operating system independent.

I'm still a little unclear as to what actually can be done with the box at
the moment.  If the firmware loader (under Linux) is not ready, I'm unclear
as to what the RPM can do without the firmware.

At the risk of wasting your time with my questions (and drawing you away
from your work), when you say a "small command line program that enables the
RPM io box (which is on bypass mode by default)", does this mean that you
can plug in a mic/headphone and get them both amplified and sent/received
to/from the RME PCI board?  But if that's the case, I thought that was
really all the RPM box did anyway??

So, when you say "everything works as you would expect it", I'm a little
unclear how that would be the case without any firmware loaded??

Sorry, but it would be nice to know what can actually be done/not done as it
stands at the moment.

Regards, Martin
