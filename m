From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Fix passing platform_data to ac97
 bus users and fix a leak.
Date: Thu, 25 Mar 2010 08:55:01 +0000
Message-ID: <1269507301.3758.0.camel@odin>
References: <4BA99514.8020708@gmail.com>
	<20100324130611.GA26910@sirena.org.uk>  <4BAAACB4.6030303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f176.google.com (mail-yw0-f176.google.com
	[209.85.211.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E1F62453E
	for <alsa-devel@alsa-project.org>; Thu, 25 Mar 2010 09:55:11 +0100 (CET)
Received: by ywh6 with SMTP id 6so2153255ywh.16
	for <alsa-devel@alsa-project.org>; Thu, 25 Mar 2010 01:55:10 -0700 (PDT)
In-Reply-To: <4BAAACB4.6030303@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Graham Gower <graham.gower@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-03-25 at 10:52 +1030, Graham Gower wrote:
> Mark, Liam,
> 
> As requested, this patch removes the initial allocation of codec->ac97.
> 
> 
> Signed-off-by: Graham Gower <graham.gower@gmail.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
