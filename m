From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] WM8750: Convert to new API
Date: Fri, 26 Mar 2010 16:37:01 +0000
Message-ID: <1269621421.9909.58.camel@odin>
References: <1269613142-23942-1-git-send-email-marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A0E85103978
	for <alsa-devel@alsa-project.org>; Fri, 26 Mar 2010 17:37:01 +0100 (CET)
Received: by pvg12 with SMTP id 12so4464652pvg.38
	for <alsa-devel@alsa-project.org>; Fri, 26 Mar 2010 09:37:00 -0700 (PDT)
In-Reply-To: <1269613142-23942-1-git-send-email-marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-03-26 at 15:19 +0100, Marek Vasut wrote:
> Register the WM8750 as a SPI or I2C device. This patch mostly shuffles code
> around. Hugely inspired by WM8753 which was already converted.
> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> ---
>  sound/soc/codecs/wm8750.c |  297 +++++++++++++++++++++------------------------
>  1 files changed, 140 insertions(+), 157 deletions(-)

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
