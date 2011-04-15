From: Shreshtha <shreshthakumar@gmail.com>
Subject: Re: Accessing already probed snd_card in kernel space
Date: Fri, 15 Apr 2011 13:19:11 +0530
Message-ID: <BANLkTim6fPPjrNJE3Rijc4h3rnvRthJeTQ@mail.gmail.com>
References: <BANLkTi=6LHNZMeKisa57FYqsoYzQ_38vqQ@mail.gmail.com>
	<20110415063015.GA4920@qtel.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6FB0A1037FC
	for <Alsa-devel@alsa-project.org>;
	Fri, 15 Apr 2011 09:49:12 +0200 (CEST)
Received: by iwc10 with SMTP id 10so2516611iwc.38
	for <Alsa-devel@alsa-project.org>; Fri, 15 Apr 2011 00:49:11 -0700 (PDT)
In-Reply-To: <20110415063015.GA4920@qtel.sh.intel.com>
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
Cc: "Alsa-devel@alsa-project.org" <Alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thanks Lu and Clemens for reply.

Vibrator hardware is connected to D-Class amplifier of Audio block. Audio
block has its ASoC driver.
One way in Android is to use timed_output
("/sys/class/timed_output/vibrator/enable").
I wanted to access the alsa card, configure it and play vibrator from
"timed_output vibrator driver" in Kernel space.

But as you described that accessing from out side the sound subsystem is
prohibited in Kernel.
So only way remains is to access the sound card from user space using ALSA
lib APIs and replace current usage of sysfs for haptic feedback. Please
suggest if it is right direction.

On Fri, Apr 15, 2011 at 12:00 PM, Lu Guanqun <guanqun.lu@intel.com> wrote:

> On Fri, Apr 15, 2011 at 01:46:41PM +0800, Shreshtha wrote:
> > Hi, I am completely new to ALSA and ASoC so my question formation may
> seems
> > vague but I will try to be clear in objective.
> > How can I access already detected/populated sound card from inside the
> > kernel using standard ALSA kernel APIs?
> > Any mapping of kernel api for the following steps -
> >
> > 1) Find the right ALSA-card. (using snd_card_create)
> >
> > 2) Find the wanted ALSA-control for this card with
> snd_ctl_find_numid(...).
> >
> > 3) Modify the control
> >
> > I want to configure the vibrator from kernel using the ALSA kernel APIs.
> >
> > From user space alsa_amixer -Dhw set/sset "vibra command" "..."
> > I want to do it from kernel space using ALSA apis.
>
> Why would you do that in kernel?
>
> I don't think you should access it directly in subsystem other than
> sound subsystem. Your scenario is very much like directly access an
> opened file in kernel, which should be prohibited.
>
> I'm afraid you can notify the userspace in kernel when you want to do
> such kind of changes, and then let the userspace program issue the
> command and change it for you. It's much clear.
>
> >
> > BR
> > Mickey
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
> --
> guanqun
>



-- 
shreshthakumar@gmail.com
