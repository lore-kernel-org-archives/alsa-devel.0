From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [uclinux-dist-devel] [PATCH 1/4] Blackfin: Use
 8bit spi transfers for the ad1836
Date: Thu, 5 May 2011 18:56:38 -0400
Message-ID: <BANLkTi=u+_LBkv2=DAwhZ53FEoRaYcHErA@mail.gmail.com>
References: <1304617966-4410-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 421C8243B7
	for <alsa-devel@alsa-project.org>;
	Fri,  6 May 2011 00:57:00 +0200 (CEST)
Received: by gyg8 with SMTP id 8so1115987gyg.38
	for <alsa-devel@alsa-project.org>; Thu, 05 May 2011 15:56:58 -0700 (PDT)
In-Reply-To: <1304617966-4410-1-git-send-email-lars@metafoo.de>
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
Cc: device-driver-devel@blackfin.uclinux.org, uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, May 5, 2011 at 13:52, Lars-Peter Clausen wrote:
> Currently there is a special case for the ad1836 in the ASoC generic spi write
> functions, which swaps the upper and the lower byte for 4/12 transfers.
> This was done, because the 4/12 spi write function was added for the ad1836
> for which all of the users are configured to use use 16-bit transfers.
> In order to be able to get rid of this special casing switch all users of
> ad1836 to 8-bit transfers.

16bit spi transfers are inherently less overhead than 8bit transfers.
so if the codec supports it, we should use it rather than drop 16bit
support everywhere because 8bit is simpler.  am i missing something
obvious ?
-mike
