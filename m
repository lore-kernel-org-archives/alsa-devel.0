From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Alsamixertest
Date: Mon, 04 Oct 2010 14:01:46 +0200
Message-ID: <4CA9C22A.2010104@ladisch.de>
References: <4C9F6409.6010400@aknet.ru>	<20100927005858.GD21247@sirena.org.uk>	<4CA0221D.6030208@aknet.ru>	<i7qltg$bph$1@dough.gmane.org>	<AANLkTi=9gcs0A6s55wSS-RP4NucvUqkxCoYynezdF+5g@mail.gmail.com>	<4CA306CB.1090305@canonical.com>	<AANLkTi=h+ZKXNdhmC1BtTbBaGF6_V+uD2ZO7sx4WMJMW@mail.gmail.com>
	<4CA9877F.7060009@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id EF01824466
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Oct 2010 14:00:59 +0200 (CEST)
In-Reply-To: <4CA9877F.7060009@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

David Henningsson wrote:
> On 2010-10-02 04:11, Raymond Yau wrote:
> > It seem that the program keep complain about those controls without dB scale
> > (e.g. AC97 3D Control - depth and rear depth , .) with the emulated intel8x0
> > driver  and no volume control with the emulated sb16 in virtualbox
> 
> It's a righteous warning if you ask me - all volume controls should
> provide dB information,

But "3D Depth" and some other controls are not volume controls and are
not measured in dB.

> or we don't know what they actually do.

Where "we" = "generic software like PA".  Non-standard controls can be
controlled only by hardware-specific tools or by the user.


Regards,
Clemens
