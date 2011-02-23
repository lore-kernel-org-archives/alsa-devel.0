From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: : Question ASoC driver without Codec driver?
Date: Wed, 23 Feb 2011 20:08:57 +0000
Message-ID: <20110223200857.GB2534@opensource.wolfsonmicro.com>
References: <2A84145621092446B6659B8A0F28E26F4703F09682@irsmsx501.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E696B24387
	for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2011 21:08:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <2A84145621092446B6659B8A0F28E26F4703F09682@irsmsx501.ger.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Bensaid, Selma" <selma.bensaid@intel.com>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Benavoli, PatrickX" <patrickx.benavoli@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 23, 2011 at 09:29:41AM +0000, Bensaid, Selma wrote:

> I'm trying to find out if it's possible to implement an ASoC driver 
> without a codec driver.

Obviously, platform and CPU drivers have no CODEC dependencies.

> I'm implementing a ASoC driver for BT/FM WL1273, where the FM WL1273 control 
> interface is based on V4L2 since since we use the Combined Interface 
> Mode (The host controls both the BT and the FM Radio through the BT HCI host interface).

You need to implement a CODEC driver for this but there's no reason for
it to do anything except expose the capabilities of the device - there's
several in tree examples you can look at.  Remember that we still need
to know how to configure the other drivers that talk to the chip, even
if the chip itself is unconfigurable.
