From: Shreshtha <shreshthakumar@gmail.com>
Subject: Re: Accessing already probed snd_card in kernel space
Date: Fri, 15 Apr 2011 13:57:08 +0530
Message-ID: <BANLkTikOKEvQDn096Ta3Db3mgN0+Q7NX_w@mail.gmail.com>
References: <BANLkTi=6LHNZMeKisa57FYqsoYzQ_38vqQ@mail.gmail.com>
	<20110415063015.GA4920@qtel.sh.intel.com>
	<BANLkTim6fPPjrNJE3Rijc4h3rnvRthJeTQ@mail.gmail.com>
	<4DA7FA63.3070803@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D320610382B
	for <Alsa-devel@alsa-project.org>;
	Fri, 15 Apr 2011 10:27:10 +0200 (CEST)
Received: by iwc10 with SMTP id 10so2539483iwc.38
	for <Alsa-devel@alsa-project.org>; Fri, 15 Apr 2011 01:27:08 -0700 (PDT)
In-Reply-To: <4DA7FA63.3070803@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "Alsa-devel@alsa-project.org" <Alsa-devel@alsa-project.org>, Lu Guanqun <guanqun.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 15, 2011 at 1:27 PM, Clemens Ladisch <clemens@ladisch.de> wrote:

> Shreshtha wrote:
> > Vibrator hardware is connected to D-Class amplifier of Audio block.
>
> Does this mean that you have to generate the vibration waveform as
> sound data and write it to the sound device?  This would be rather
> unwieldy in kernel space.  (Just accessing a mixer control would be
> possible.)
>
> [Shreshtha] Yes that is also a use case. But I require just to enable the
vibrator for x msec and turn it off.
This is for haptic feedback.
Please suggest how to "just accessing a mixer control" from kernel?


> > But as you described that accessing from out side the sound subsystem is
> > prohibited in Kernel.
>
> It's not prohibited, it's just not the way the API was designed.
>
> [Shreshtha] So I feel even if I use the ALSA API (or OSS emulation) in
timed_output vibrator and manage to turn on the vibrator, that will not be
accepted by kernel community.

> So only way remains is to access the sound card from user space using ALSA
> > lib APIs and replace current usage of sysfs for haptic feedback. Please
> > suggest if it is right direction.
>
> Is the sysfs API a _required_ Android API, or would Android allow you
> to write a user space driver?
>
> [Shreshtha]  I found this one way of implementation seen on other devices.
There can be other, and now I feel I require one.

>
> Regards,
> Clemens
>



-- 
shreshthakumar@gmail.com
