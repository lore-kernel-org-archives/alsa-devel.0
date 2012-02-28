From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 2/2] ASoC: omap: mcbsp: Remove redundant
 checks for the st_data pointer
Date: Tue, 28 Feb 2012 21:34:56 +0200
Message-ID: <4F4D2C60.4080506@bitmer.com>
References: <1330416452-7195-1-git-send-email-peter.ujfalusi@ti.com>
	<1330416452-7195-3-git-send-email-peter.ujfalusi@ti.com>
	<20120228124036.GJ3683@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 6174D103F93
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 20:34:23 +0100 (CET)
In-Reply-To: <20120228124036.GJ3683@opensource.wolfsonmicro.com>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 02/28/2012 02:40 PM, Mark Brown wrote:
> On Tue, Feb 28, 2012 at 10:07:32AM +0200, Peter Ujfalusi wrote:
>> The parent functions of omap_st_start/stop also checks the validity of the
>> st_data pointer so we do not need to do it again inside of omap_st_start/stop
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
