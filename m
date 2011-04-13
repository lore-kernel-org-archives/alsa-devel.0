From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v2] ASoC: tlv320dac33: Lower the OSC
 calibration time
Date: Wed, 13 Apr 2011 09:33:44 +0100
Message-ID: <1302683624.3600.28.camel@odin>
References: <1302588557-6072-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 053B7103806
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Apr 2011 10:33:50 +0200 (CEST)
Received: by fxm5 with SMTP id 5so340413fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2011 01:33:48 -0700 (PDT)
In-Reply-To: <1302588557-6072-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-04-12 at 09:09 +0300, Peter Ujfalusi wrote:
> To get correct calibration, we can decrease the time
> needed for the OSC to calibrate itself.
> With this change we can save ~15ms in the OSC
> calibration phase.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> 
> Hi,
> 
> Changes: typo fix in the commit message.
> 
>  sound/soc/codecs/tlv320dac33.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Applied.

Thanks

Liam
