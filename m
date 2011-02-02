From: Alexander Sverdlin <subaparts@yandex.ru>
Subject: Re: [PATCH] EDB93xx: Add support for CS4271 CODEC on
	EDB93xx boards
Date: Wed, 02 Feb 2011 14:12:47 +0300
Message-ID: <1296645167.1504.31.camel@r60e>
References: <1296603653.1504.9.camel@r60e>
	<0D753D10438DA54287A00B027084269764CEF59B2B@AUSP01VMBX24.collaborationhost.net>
	<1296643688.1504.23.camel@r60e>
	<20110202104943.GN12743@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward9.mail.yandex.net (forward9.mail.yandex.net
	[77.88.61.48]) by alsa0.perex.cz (Postfix) with ESMTP id BC46C244DA
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2011 12:12:55 +0100 (CET)
In-Reply-To: <20110202104943.GN12743@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, H Hartley Sweeten <hartleys@visionengravers.com>, Lennert Buytenhek <buytenh@wantstofly.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Dear Mark,

On Wed, 2011-02-02 at 10:49 +0000, Mark Brown wrote:
> On Wed, Feb 02, 2011 at 01:48:08PM +0300, Alexander Sverdlin wrote:
> 
> > I'm really confused now, where should it be? If I will init
> > cs4271_platform_data with GPIO values, CODEC driver will manage it.
> > Otherwise CODEC driver should be rewritten without GPIO support and I
> > can add it to platform code.
> 
> What is the problem?
> 

On 07 OCT 2010 you advised to integrate GPIO handling (reset and
SPI-enable) into CODEC code flow.

Now Hartley suggested to move GPIO handling to platform code. This makes
sense, as SPI-enable will be managed automatically, and reset is also
more related to platform (depending on schematics, inversion and so on).

As for me, I think handle it in platform code is better. So we can now
remove all the GPIO code and cs4271_platform_data structure from CS4271
CODEC.

Best regards,
	Alexander.
