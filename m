From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Support configuration of WM8958
 microphone bias analogue parameters
Date: Tue, 22 Feb 2011 09:42:20 +0000
Message-ID: <1298367740.3353.13.camel@odin>
References: <>
	<1298337360-12614-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 10FA410386A
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2011 10:42:24 +0100 (CET)
Received: by wyb28 with SMTP id 28so1936313wyb.38
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2011 01:42:23 -0800 (PST)
In-Reply-To: <1298337360-12614-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Tue, 2011-02-22 at 01:16 +0000, Mark Brown wrote:
> The WM8958 has a different microphone bias architecture to WM8994 so needs
> different configuration to WM8994. Support this in platform data.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  include/linux/mfd/wm8994/pdata.h     |    7 +++++--
>  include/linux/mfd/wm8994/registers.h |    2 ++
>  sound/soc/codecs/wm8994.c            |    7 +++++++
>  3 files changed, 14 insertions(+), 2 deletions(-)

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
