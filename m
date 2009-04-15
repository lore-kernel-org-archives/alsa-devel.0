From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [2.6.30-rc2][PATCH 1/2] ASoC: OMAP: Fix DSP_B
	format in OMAP McBSP DAI driver
Date: Wed, 15 Apr 2009 14:04:36 +0300
Message-ID: <200904151404.37003.peter.ujfalusi@nokia.com>
References: <1239792497-31761-1-git-send-email-jarkko.nikula@nokia.com>
	<1239792497-31761-2-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id A184C10387A
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 13:05:14 +0200 (CEST)
In-Reply-To: <1239792497-31761-2-git-send-email-jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Nikula Jarkko (Nokia-D/Helsinki)" <jarkko.nikula@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Wednesday 15 April 2009 13:48:16 Nikula Jarkko (Nokia-D/Helsinki) wrote:
> The DSP format wasn't still correct in OMAP McBSP DAI even after the commit
> bd25867a6cbe7a00ef7dbe8d9ddebc91b00b9b3f.
>
> Thanks to Peter Ujfalusi <peter.ujfalusi@nokia.com> for noticing and being
> part of the fix. Now the FS length definition is more clear by defining
> it with  FWID(0).
>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---
>  sound/soc/omap/omap-mcbsp.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)

I believe this is correct.

Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
