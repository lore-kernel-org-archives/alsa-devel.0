From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: Remove unused DAPM_DOUBLE
	control types
Date: Wed, 15 Dec 2010 13:37:09 +0000
Message-ID: <1292420229.3348.12.camel@odin>
References: <1292349202-25538-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f42.google.com (mail-ew0-f42.google.com
	[209.85.215.42]) by alsa0.perex.cz (Postfix) with ESMTP id C19F2244E9
	for <alsa-devel@alsa-project.org>; Wed, 15 Dec 2010 14:37:13 +0100 (CET)
Received: by ewy1 with SMTP id 1so1123812ewy.29
	for <alsa-devel@alsa-project.org>; Wed, 15 Dec 2010 05:37:13 -0800 (PST)
In-Reply-To: <1292349202-25538-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-12-14 at 17:53 +0000, Mark Brown wrote:
> There are no users of these and it's not clear what they would do given
> the mono flow modelling which DAPM does. If need arises we can add them
> again.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

All

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
