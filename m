From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] add set_tdm_slot in tdm dai to define
 the relationship between audio channel and tdm slot
Date: Wed, 12 Aug 2009 14:56:08 +0100
Message-ID: <20090812135608.GD11898@rakim.wolfsonmicro.main>
References: <1250051574-25119-1-git-send-email-21cnbao@gmail.com>
	<1250051574-25119-2-git-send-email-21cnbao@gmail.com>
	<1250051574-25119-3-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 804BB244B3
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Aug 2009 15:56:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1250051574-25119-3-git-send-email-21cnbao@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 12, 2009 at 12:32:53PM +0800, Barry Song wrote:
> For ad1938, the audio channel n just uses slot n, but for ad1836, it's
> different, channel 0 uses slot 0, channel 1 uses slot 4, channels 2 uses
> slot1, ... So add set_tdm_slot entry and use the mask field to define
> the relationship between audio channel and slot number.

> Signed-off-by: Barry Song <21cnbao@gmail.com>

OK but this needs updating to the new tdm_slot() API too.
