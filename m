From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 2/3] add set_tdm_slot in tdm dai to
 define the relationship between audio channel and tdm slot
Date: Mon, 17 Aug 2009 18:50:10 +0100
Message-ID: <20090817175010.GA19707@rakim.wolfsonmicro.main>
References: <1250137511-24034-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2B504103806
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Aug 2009 19:50:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1250137511-24034-1-git-send-email-21cnbao@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 13, 2009 at 12:25:11PM +0800, Barry Song wrote:

> For ad1938, the audio channel n just uses slot n, but for ad1836, it's
> different, channel 0 uses slot 0, channel 1 uses slot 4, channels 2 uses
> slot1, ... So add set_tdm_slot entry and use the mask field to define
> the relationship between audio channel and slot number.

I think what you're trying to describe here is that the device is
expecting to see all the left channels on the bus followed by all the
right channels?  This is the normal case for I2S TDM so no unusual
configuration is required in order to implement it.

I really don't think we should have Blackfin implementing a different
API here - it makes the TDM slot API much harder to use.  Instead we
should have a consistent API between all devices.  This may mean that we
need to extend the APIs here.
