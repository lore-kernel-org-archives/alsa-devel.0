From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v2 0/2] Add earphone speaker in OMAP4
Date: Wed, 19 May 2010 14:19:55 +0100
Message-ID: <1274275195.3240.149.camel@odin>
References: <1274204658-31614-1-git-send-email-jorge.candelaria@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 186FC1038FB
	for <alsa-devel@alsa-project.org>;
	Wed, 19 May 2010 15:20:03 +0200 (CEST)
Received: by wya21 with SMTP id 21so55530wya.38
	for <alsa-devel@alsa-project.org>; Wed, 19 May 2010 06:20:02 -0700 (PDT)
In-Reply-To: <1274204658-31614-1-git-send-email-jorge.candelaria@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-05-18 at 12:44 -0500, Jorge Eduardo Candelaria wrote:
> Add support for earphone speaker in SDP4430 board.
> 
> Changes from v1:
> - Separated changes for codec and machine drivers in two patches.
> - Added Acked-by tag to patches.
> 
> Jorge Eduardo Candelaria (2):
>       ASoC: SDP4430: Add support for Earphone speaker
>       ASoC: TWL6040: Enable earphone path in codec
> 
>  sound/soc/codecs/twl6040.c |   21 ++++++++++++++++++++-
>  sound/soc/omap/sdp4430.c   |    4 ++++
>  2 files changed, 24 insertions(+), 1 deletions(-)

Both applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
