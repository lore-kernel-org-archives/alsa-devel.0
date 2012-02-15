From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: dapm: Convert pin switches to use
	snd_soc_card
Date: Wed, 15 Feb 2012 10:09:24 +0000
Message-ID: <1329300564.7841.3.camel@odin>
References: <1329268340-25342-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog101.obsmtp.com (na3sys009aog101.obsmtp.com
	[74.125.149.67]) by alsa0.perex.cz (Postfix) with ESMTP id 74802244AA
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 11:09:28 +0100 (CET)
Received: by mail-wi0-f175.google.com with SMTP id hq7so466611wib.20
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 02:09:26 -0800 (PST)
In-Reply-To: <1329268340-25342-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2012-02-14 at 17:12 -0800, Mark Brown wrote:
> Since the addition of the non-CODEC control adds card controls like the
> DAPM pin switch have been broken as they are expecting the private data
> for the control to be the CODEC but it's now the card. Fix that for the
> pin switches, an audit of other drivers is required.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@ti.com>

I covered all the machine drivers who directly used the old API with the
original patch but I'll also do some further audit for indirect users
like the pin switch.

Liam
