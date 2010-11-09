From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Ensure sane WM835x AIF configuration
 by default
Date: Tue, 09 Nov 2010 21:27:10 +0000
Message-ID: <1289338030.3290.40.camel@odin>
References: <1289329080-2631-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 09FAF10384D
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2010 22:27:13 +0100 (CET)
Received: by wyb33 with SMTP id 33so5345161wyb.38
	for <alsa-devel@alsa-project.org>; Tue, 09 Nov 2010 13:27:13 -0800 (PST)
In-Reply-To: <1289329080-2631-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Tue, 2010-11-09 at 18:58 +0000, Mark Brown wrote:
> Ensure that whatever ran before us leaves the WM835x with a sane default
> audio interface configuration as we do not override the companding,
> loopback or tristate settings and do not reset the chip at startup (as it
> is a PMIC).
> 
> Reported-by: Keiji Mitsuhisa <Keiji.Mitsuhisa@wolfsonmicro.com>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8350.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
