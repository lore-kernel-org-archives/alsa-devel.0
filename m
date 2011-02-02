From: Alexander Sverdlin <subaparts@yandex.ru>
Subject: Re: [PATCH] EDB93xx: Add support for CS4271 CODEC on
	EDB93xx boards
Date: Wed, 02 Feb 2011 20:33:19 +0300
Message-ID: <1296667999.1504.44.camel@r60e>
References: <1296603653.1504.9.camel@r60e>
	<0D753D10438DA54287A00B027084269764CEF59B2B@AUSP01VMBX24.collaborationhost.net>
	<1296643688.1504.23.camel@r60e>
	<20110202104943.GN12743@opensource.wolfsonmicro.com>
	<1296645167.1504.31.camel@r60e>
	<20110202125327.GO12743@opensource.wolfsonmicro.com>
	<1296653211.1504.40.camel@r60e>
	<0D753D10438DA54287A00B027084269764CEFD45C8@AUSP01VMBX24.collaborationhost.net>
	<20110202165959.GT12743@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward15.mail.yandex.net (forward15.mail.yandex.net
	[95.108.130.119])
	by alsa0.perex.cz (Postfix) with ESMTP id A22BA2474D
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2011 18:33:28 +0100 (CET)
In-Reply-To: <20110202165959.GT12743@opensource.wolfsonmicro.com>
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

On Wed, 2011-02-02 at 17:00 +0000, Mark Brown wrote:
> On Wed, Feb 02, 2011 at 10:53:15AM -0600, H Hartley Sweeten wrote:
> 
> > I don't have any problem with leaving the reset management in the codec.
> > The enable (chip-select) should be handled in the platform code.  But,
> > gpio_disable should be removed from struct cs4271_platform_data to avoid
> > any confusion.
> 
> Is that really a chip select or is it a power control?
> 

It's a chip select. The way I've managed it in CODEC it's because Cirrus
boards do not have any other SPI devices. Supported by current mainline,
at least.
