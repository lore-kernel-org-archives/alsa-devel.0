From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] EDB93xx: Add support for CS4271 CODEC on
	EDB93xx boards
Date: Wed, 2 Feb 2011 12:53:27 +0000
Message-ID: <20110202125327.GO12743@opensource.wolfsonmicro.com>
References: <1296603653.1504.9.camel@r60e>
	<0D753D10438DA54287A00B027084269764CEF59B2B@AUSP01VMBX24.collaborationhost.net>
	<1296643688.1504.23.camel@r60e>
	<20110202104943.GN12743@opensource.wolfsonmicro.com>
	<1296645167.1504.31.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1EECF24526
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2011 13:53:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1296645167.1504.31.camel@r60e>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexander Sverdlin <subaparts@yandex.ru>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, H Hartley Sweeten <hartleys@visionengravers.com>, Lennert Buytenhek <buytenh@wantstofly.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 02, 2011 at 02:12:47PM +0300, Alexander Sverdlin wrote:

> On 07 OCT 2010 you advised to integrate GPIO handling (reset and
> SPI-enable) into CODEC code flow.

> Now Hartley suggested to move GPIO handling to platform code. This makes
> sense, as SPI-enable will be managed automatically, and reset is also
> more related to platform (depending on schematics, inversion and so on).

What is the advantage of this?  The GPIO management has to be done
somewhere and replicating it in every platform seems like a complete
waste of time.  Given that one of the GPIOs is a power control it'll
also mean that it's not possible to manage the power dynamically at
runtime.
