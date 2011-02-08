From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Adding bluetooth PCM interface support to ASoC
 (Was: Re: [PATCH 6/7] ASoC: Samsung: neo1973_gta02: Fix bluetooth DAI
 registration)
Date: Tue, 8 Feb 2011 13:08:23 +0000
Message-ID: <20110208130823.GG29850@opensource.wolfsonmicro.com>
References: <1297033463-14577-1-git-send-email-lars@metafoo.de>
	<1297033463-14577-6-git-send-email-lars@metafoo.de>
	<20110207115906.GD10564@opensource.wolfsonmicro.com>
	<4D5023A4.3020209@metafoo.de>
	<20110207170213.GP10564@opensource.wolfsonmicro.com>
	<4D502DBF.3050205@metafoo.de>
	<20110207174950.GQ10564@opensource.wolfsonmicro.com>
	<4D50355A.60500@metafoo.de>
	<20110207181702.GR10564@opensource.wolfsonmicro.com>
	<4D50785A.7050801@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D9CD0103813
	for <alsa-devel@alsa-project.org>; Tue,  8 Feb 2011 14:08:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4D50785A.7050801@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 07, 2011 at 11:55:22PM +0100, Lars-Peter Clausen wrote:

> I did some research on the topic and it seems that this is a pretty common
> setup in embedded devices.

Yes, this is a totally vanilla setup except that for modern hardware the
baseband is connected digitally also.

> But the bluetooth audio support seems to be entirely written in userspace. The
> in-kernel bluetooth drivers in general seem only to provide a common interface
> to the underlying hardware and all of the higher level functionality seems to
> be implemented in userspace.
> So right now I have no idea where to start if one wanted to add a ASoC driver
> which did the bt-dai configuration.

The obvious starting point would seem to be to provide a driver which
allows userspace to tell the kernel about configuration changes - that's
what we're doing at the minute for the trivial case where the hardware
doesn't change configuration.  We could then look at pushing more of the
code into the kernel if that made sense.
