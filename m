From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: multi-component: TWL4030: Restore
	registers on removal
Date: Thu, 12 Aug 2010 09:20:07 +0100
Message-ID: <2DCC5BA4-C46A-4CD7-ABF5-A7F5498394E7@opensource.wolfsonmicro.com>
References: <1281594592-2251-1-git-send-email-peter.ujfalusi@nokia.com>
	(sfid-20100812_073026_680583_FF14829A)
Mime-Version: 1.0 (iPad Mail 7B405)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 49DE42441F
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Aug 2010 10:19:35 +0200 (CEST)
In-Reply-To: <1281594592-2251-1-git-send-email-peter.ujfalusi@nokia.com>
	(sfid-20100812_073026_680583_FF14829A)
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 12 Aug 2010, at 07:29, Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> Add back the register restore call, when the codec driver is
> removed.
> This does not affect normal operation, but it is usefull when
> debugging audio through the twl4030 class codecs.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
