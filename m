From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: Accessing already probed snd_card in kernel space
Date: Thu, 28 Apr 2011 11:25:11 +0530
Message-ID: <1303970111.896.30.camel@vkoul-udesk3>
References: <BANLkTi=6LHNZMeKisa57FYqsoYzQ_38vqQ@mail.gmail.com>
	<20110415063015.GA4920@qtel.sh.intel.com>
	<BANLkTim6fPPjrNJE3Rijc4h3rnvRthJeTQ@mail.gmail.com>
	<4DA7FA63.3070803@ladisch.de>
	<BANLkTikOKEvQDn096Ta3Db3mgN0+Q7NX_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 48E0E103904
	for <Alsa-devel@alsa-project.org>;
	Thu, 28 Apr 2011 08:27:00 +0200 (CEST)
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
Cc: "Alsa-devel@alsa-project.org" <Alsa-devel@alsa-project.org>, "Lu,
	Guanqun" <guanqun.lu@intel.com>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-04-15 at 13:57 +0530, Shreshtha wrote:
> On Fri, Apr 15, 2011 at 1:27 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> 
> > Shreshtha wrote:
> > > Vibrator hardware is connected to D-Class amplifier of Audio block.
> >
> > Does this mean that you have to generate the vibration waveform as
> > sound data and write it to the sound device?  This would be rather
> > unwieldy in kernel space.  (Just accessing a mixer control would be
> > possible.)
> >
> > [Shreshtha] Yes that is also a use case. But I require just to enable the
> vibrator for x msec and turn it off.
> This is for haptic feedback.
> Please suggest how to "just accessing a mixer control" from kernel?
Sorry for late reply...been on a vacation

I have implemented a similar mechanism, all the vibrator controls are
exposed as mixer elements by the codec driver.
To turn on just treat the vibrator as input and connect them in
userspace to the output, that will power on this path and you cna get x
ms vibrations

HTH
-- 
~Vinod
