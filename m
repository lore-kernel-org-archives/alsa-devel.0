From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Accessing already probed snd_card in kernel space
Date: Fri, 15 Apr 2011 09:57:23 +0200
Message-ID: <4DA7FA63.3070803@ladisch.de>
References: <BANLkTi=6LHNZMeKisa57FYqsoYzQ_38vqQ@mail.gmail.com>	<20110415063015.GA4920@qtel.sh.intel.com>
	<BANLkTim6fPPjrNJE3Rijc4h3rnvRthJeTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id E071C10382B
	for <Alsa-devel@alsa-project.org>;
	Fri, 15 Apr 2011 09:55:37 +0200 (CEST)
In-Reply-To: <BANLkTim6fPPjrNJE3Rijc4h3rnvRthJeTQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shreshtha <shreshthakumar@gmail.com>
Cc: "Alsa-devel@alsa-project.org" <Alsa-devel@alsa-project.org>, Lu Guanqun <guanqun.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

Shreshtha wrote:
> Vibrator hardware is connected to D-Class amplifier of Audio block.

Does this mean that you have to generate the vibration waveform as
sound data and write it to the sound device?  This would be rather
unwieldy in kernel space.  (Just accessing a mixer control would be
possible.)

> But as you described that accessing from out side the sound subsystem is
> prohibited in Kernel.

It's not prohibited, it's just not the way the API was designed.

> So only way remains is to access the sound card from user space using ALSA
> lib APIs and replace current usage of sysfs for haptic feedback. Please
> suggest if it is right direction.

Is the sysfs API a _required_ Android API, or would Android allow you
to write a user space driver?


Regards,
Clemens
