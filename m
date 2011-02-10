From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: WM8994: Improve robustness in
 some use cases
Date: Thu, 10 Feb 2011 23:59:38 +0000
Message-ID: <1297382378.3313.101.camel@odin>
References: <1297344478-30490-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 3347B243F8
	for <alsa-devel@alsa-project.org>; Fri, 11 Feb 2011 00:59:42 +0100 (CET)
Received: by wyi11 with SMTP id 11so1903350wyi.38
	for <alsa-devel@alsa-project.org>; Thu, 10 Feb 2011 15:59:41 -0800 (PST)
In-Reply-To: <1297344478-30490-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-02-10 at 13:27 +0000, Dimitris Papastamos wrote:
> Ensure that on disabling certain registers such as AIF1DAC1L,
> AIF1DAC1R etc. the AIF1CLK and AIF2CLK remain enabled.  Similarly
> when enabling those registers, AIF1CLK and AIF2CLK will remain
> disabled.
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> ---

Both

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
