From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: TWL4030: Use codec defaults for
 Headset initial configuration
Date: Wed, 17 Feb 2010 10:53:11 +0000
Message-ID: <1266403991.3609.54.camel@odin>
References: <1266392994-29551-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id A762C24394
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 11:53:15 +0100 (CET)
Received: by ewy23 with SMTP id 23so1790551ewy.4
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 02:53:15 -0800 (PST)
In-Reply-To: <1266392994-29551-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-02-17 at 09:49 +0200, Peter Ujfalusi wrote: 
> Disable the amplifiers for the headset outputs, and do not select
> routings by default to the headset outputs.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---
> 
> The obvious side effect of this patch is that on boards which are using the
> headset output the playback will not work 'out of box'.
> The user need to specifically enable the routings for the boards.
> Board that came to my mind is the Beagle, and probably it's clones as well.
> 
>  sound/soc/codecs/twl4030.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
