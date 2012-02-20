From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 0/3] Coefficient configuration support
Date: Mon, 20 Feb 2012 09:06:13 +0000
Message-ID: <1329728773.3782.1.camel@odin>
References: <20120218004909.GA6712@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog119.obsmtp.com (na3sys009aog119.obsmtp.com
	[74.125.149.246]) by alsa0.perex.cz (Postfix) with SMTP id 84FF4243CC
	for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2012 10:06:17 +0100 (CET)
Received: by mail-wi0-f179.google.com with SMTP id hj6so3027051wib.38
	for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2012 01:06:15 -0800 (PST)
In-Reply-To: <20120218004909.GA6712@opensource.wolfsonmicro.com>
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

On Fri, 2012-02-17 at 16:49 -0800, Mark Brown wrote:
> This series is only compile tested as yet, I'll probably get a chance to
> test it shortly - it should work out so hopefully the review can overlap
> usefully with the testing.
> 
> Mark Brown (3):
>       ASoC: core: Add SND_SOC_BYTES control for coefficient blocks
>       ASoC: core: Add support for masking out parts of coefficient blocks
>       ASoC: wm5100: Add DRC coefficient configuration
> 
>  include/sound/soc.h       |   27 +++++++++++
>  sound/soc/codecs/wm5100.c |    2 +
>  sound/soc/soc-core.c      |  110 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 139 insertions(+), 0 deletions(-)

All

Acked-by: Liam Girdwood <lrg@ti.com>
