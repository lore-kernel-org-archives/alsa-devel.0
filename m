From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Remove broken WM8350 direction
 constants
Date: Tue, 09 Nov 2010 18:26:23 +0000
Message-ID: <1289327183.3290.13.camel@odin>
References: <1289305033-30397-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 68793103852
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2010 19:26:27 +0100 (CET)
Received: by eyg24 with SMTP id 24so3778288eyg.38
	for <alsa-devel@alsa-project.org>; Tue, 09 Nov 2010 10:26:27 -0800 (PST)
In-Reply-To: <1289305033-30397-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Tommy.Zhu@wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-11-09 at 12:17 +0000, Mark Brown wrote:
> The WM8350 driver was using some custom constants to interpret the direction
> of the MCLK signal which had the opposite values to those used as standard
> by the ASoC core, causing confusion in machine drivers such as the 1133-EV1
> board.
> 
> Reported-by: Tommy Zhu <Tommy.Zhu@wolfsonmicro.com>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
