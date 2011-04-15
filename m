From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: Accessing already probed snd_card in kernel space
Date: Fri, 15 Apr 2011 16:36:17 +0800
Message-ID: <20110415083617.GB4920@qtel.sh.intel.com>
References: <BANLkTi=6LHNZMeKisa57FYqsoYzQ_38vqQ@mail.gmail.com>
	<20110415063015.GA4920@qtel.sh.intel.com>
	<BANLkTim6fPPjrNJE3Rijc4h3rnvRthJeTQ@mail.gmail.com>
	<4DA7FA63.3070803@ladisch.de>
	<BANLkTikOKEvQDn096Ta3Db3mgN0+Q7NX_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 9B9BC10382B
	for <Alsa-devel@alsa-project.org>;
	Fri, 15 Apr 2011 10:37:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTikOKEvQDn096Ta3Db3mgN0+Q7NX_w@mail.gmail.com>
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
Cc: "Alsa-devel@alsa-project.org" <Alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 15, 2011 at 04:27:08PM +0800, Shreshtha wrote:
> 
> 
> > So only way remains is to access the sound card from user space using ALSA
> > lib APIs and replace current usage of sysfs for haptic feedback. Please
> > suggest if it is right direction.
> 
> Is the sysfs API a _required_ Android API, or would Android allow you
> to write a user space driver?
> 
> [Shreshtha]  I found this one way of implementation seen on other devices. There can be other, and now I feel I require one.

You might use input subsystem to notify the userspace, just like jack's
implementation in sound subsystem.

> 
> Regards,
> Clemens
> 
> 
> 
> --
> shreshthakumar@gmail.com<mailto:shreshthakumar@gmail.com>

-- 
guanqun
