From: Shreshtha <shreshthakumar@gmail.com>
Subject: Re: Accessing already probed snd_card in kernel space
Date: Fri, 15 Apr 2011 14:30:40 +0530
Message-ID: <BANLkTikEwEpG4ha147muGNjweQBk3wR9Dg@mail.gmail.com>
References: <BANLkTi=6LHNZMeKisa57FYqsoYzQ_38vqQ@mail.gmail.com>
	<20110415063015.GA4920@qtel.sh.intel.com>
	<BANLkTim6fPPjrNJE3Rijc4h3rnvRthJeTQ@mail.gmail.com>
	<4DA7FA63.3070803@ladisch.de>
	<BANLkTikOKEvQDn096Ta3Db3mgN0+Q7NX_w@mail.gmail.com>
	<20110415083617.GB4920@qtel.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 38E7D10382B
	for <Alsa-devel@alsa-project.org>;
	Fri, 15 Apr 2011 11:00:43 +0200 (CEST)
Received: by iwc10 with SMTP id 10so2559056iwc.38
	for <Alsa-devel@alsa-project.org>; Fri, 15 Apr 2011 02:00:40 -0700 (PDT)
In-Reply-To: <20110415083617.GB4920@qtel.sh.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lu Guanqun <guanqun.lu@intel.com>
Cc: "Alsa-devel@alsa-project.org" <Alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Sorry, I couldn't get your point of sending notification to userspace.

just describing my understanding, if we are in same page -
For example if user touches a phone button, android gets the notification
from touch driver and in its reaction it displays the button on screen and
also uses sysfs interface (one way of implementation) to make vibrator
vibrate (haptic feedback).
sysfs open/enable handled by timed_output vibrator driver, which internally
can enable/drive some vibrator via GPIO or Audio block etc.
Here my case is Audio block and directly accessing Audio block registers is
not suggested.
So ALSA API inside the kernel which comes to mind. But now I am not sure if
that is even possible and recommended.

So proper way I see is to remove sysfs interface and implement the glue
layer of android and kernel using ALSA lib API to configure the mixer.

BR
Shreshtha

On Fri, Apr 15, 2011 at 2:06 PM, Lu Guanqun <guanqun.lu@intel.com> wrote:

> On Fri, Apr 15, 2011 at 04:27:08PM +0800, Shreshtha wrote:
> >
> >
> > > So only way remains is to access the sound card from user space using
> ALSA
> > > lib APIs and replace current usage of sysfs for haptic feedback. Please
> > > suggest if it is right direction.
> >
> > Is the sysfs API a _required_ Android API, or would Android allow you
> > to write a user space driver?
> >
> > [Shreshtha]  I found this one way of implementation seen on other
> devices. There can be other, and now I feel I require one.
>
> You might use input subsystem to notify the userspace, just like jack's
> implementation in sound subsystem.
>
> >
> > Regards,
> > Clemens
> >
> >
> >
> > --
> > shreshthakumar@gmail.com<mailto:shreshthakumar@gmail.com>
>
> --
> guanqun
>



-- 
shreshthakumar@gmail.com
