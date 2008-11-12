From: Steve Sakoman <steve@sakoman.com>
Subject: Re: [topic/asoc][PATCH] ASoC: Fix supported sample
	rates of	TWL4030 audio codec
Date: Wed, 12 Nov 2008 08:42:16 -0800
Message-ID: <1226508136.3914.61.camel@tera.sakoman.net>
References: <1226502341-21815-1-git-send-email-jarkko.nikula@nokia.com>
Reply-To: steve@sakoman.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx11.roch.ny.frontiernet.net (mx11.roch.ny.frontiernet.net
	[66.133.183.238])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D0AA244B4
	for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2008 17:51:06 +0100 (CET)
In-Reply-To: <1226502341-21815-1-git-send-email-jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2008-11-12 at 17:05 +0200, Jarkko Nikula wrote:
> TWL4030 currently supports rates between 8 kHz and 48 kHz and sets the codec
> mode register accordingly in twl4030_hw_params. Expose this info so that
> ASoC can match other rates than 44.1 kHz or 48 kHz as well.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> Cc: Steve Sakoman <steve@sakoman.com>

Acked-by: Steve Sakoman <steve@sakoman.com>
