From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 3/3] ASoC: TWL4030: Fix voice interface
	clock masters
Date: Mon, 22 Jun 2009 09:35:27 +0300
Message-ID: <200906220935.27903.peter.ujfalusi@nokia.com>
References: <67059DBF19D7214F9C66BB0EA91BA90E3543F31E@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id E5E9B2456A
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Jun 2009 08:35:36 +0200 (CEST)
In-Reply-To: <67059DBF19D7214F9C66BB0EA91BA90E3543F31E@dlee04.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ext Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Friday 19 June 2009 11:23:42 ext Lopez Cruz, Misael wrote:
> Voice interface of twl4030 codec supports: CBM_CFM and
> CBS_CFS. It doesn't support CBS_CFM.
>
> Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
> ---
>  sound/soc/codecs/twl4030.c |    2 +-
>  sound/soc/omap/sdp3430.c   |    2 +-
>  sound/soc/omap/zoom2.c     |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Acked-By: Peter Ujfalusi <peter.ujfalusi@nokia.com>
