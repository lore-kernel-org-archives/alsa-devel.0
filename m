From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: tpa6130a2: TLV mapping for tpa6140a2
Date: Tue, 04 May 2010 21:09:57 +0100
Message-ID: <1273003797.2801.83.camel@odin>
References: <1272960498-9560-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id BECBC24491
	for <alsa-devel@alsa-project.org>;
	Tue,  4 May 2010 22:10:10 +0200 (CEST)
Received: by wyb40 with SMTP id 40so831668wyb.38
	for <alsa-devel@alsa-project.org>; Tue, 04 May 2010 13:10:08 -0700 (PDT)
In-Reply-To: <1272960498-9560-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, ilkka.koskinen@nokia.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-05-04 at 11:08 +0300, Peter Ujfalusi wrote:
> Both tpa6130a2, and tpa6140a2 is supported by the
> same driver, but the gain dB scaling is different on
> the amplifiers.
> 
> Provide different mixer control for the chips with correct
> TLV mapping.
> 
> User space will see:
> "TPA6130A2 Headphone Playback Volume" in case of 6130
> "TPA6140A2 Headphone Playback Volume" in case of 6140
> 
> The way machine drivers are using this amplifier remained
> the same.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---
>  sound/soc/codecs/tpa6130a2.c |   31 ++++++++++++++++++++++++++++---
>  1 files changed, 28 insertions(+), 3 deletions(-)

Applied.

Thanks

Liam
