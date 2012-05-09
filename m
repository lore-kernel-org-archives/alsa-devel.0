From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH 3/3] ASoC: cs42l73: Use DAPM routes to hook
 AIF widgets to DAI's
Date: Wed, 9 May 2012 12:20:29 -0500
Message-ID: <alpine.DEB.2.02.1205091219570.6547@heelrod.ad.cirrus.com>
References: <1336583644-12349-1-git-send-email-brian.austin@cirrus.com>
	<1336583644-12349-3-git-send-email-brian.austin@cirrus.com>
	<20120509171833.GM3955@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
	(am1ehsobe005.messaging.microsoft.com [213.199.154.208])
	by alsa0.perex.cz (Postfix) with ESMTP id 170232413A
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2012 19:23:23 +0200 (CEST)
In-Reply-To: <20120509171833.GM3955@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Wed, 9 May 2012, Mark Brown wrote:

> On Wed, May 09, 2012 at 12:14:04PM -0500, Brian Austin wrote:
>> Signed-off-by: Brian Austin <brian.austin@cirrus.com>
>
> I'd also expect to see the stream name removed from the AIF widgets,
> otherwise you get duplicate links (which is harmless but still).
>
can I just submit a new patch that adds the AIF widget changes? Or resend 
this one with it included?
