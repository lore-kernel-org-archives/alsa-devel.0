From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 3/3] ASoC: Fix WM8903 DAC mute default
Date: Wed, 09 Feb 2011 21:50:29 +0000
Message-ID: <1297288229.3297.183.camel@odin>
References: <1297273377-7898-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1297273377-7898-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 7FD3B243FC
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 22:50:32 +0100 (CET)
Received: by wyi11 with SMTP id 11so650555wyi.38
	for <alsa-devel@alsa-project.org>; Wed, 09 Feb 2011 13:50:32 -0800 (PST)
In-Reply-To: <1297273377-7898-3-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-02-09 at 17:42 +0000, Mark Brown wrote:
> The WM8903 register map does not mute the DAC by default at startup
> so we need to explicitly do so.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
