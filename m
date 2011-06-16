From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 1/2] ALSA: ASoC: add STA32X codec driver
Date: Thu, 16 Jun 2011 09:49:23 +0100
Message-ID: <4DF9C393.1060108@ti.com>
References: <20110615150516.GC2806@opensource.wolfsonmicro.com>
	<1308212393-22121-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id B7D2424654
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Jun 2011 10:49:32 +0200 (CEST)
In-Reply-To: <1308212393-22121-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 16/06/11 09:19, Daniel Mack wrote:
> From: Johannes Stezenbach <js@sig21.net>
> 
> Signed-off-by: Johannes Stezenbach <js@sig21.net>
> [zonque@gmail.com: transform to new ASoC structure]
> ---
>  sound/soc/codecs/Kconfig  |    4 +
>  sound/soc/codecs/Makefile |    2 +
>  sound/soc/codecs/sta32x.c |  796 +++++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/sta32x.h |  210 ++++++++++++
>  4 files changed, 1012 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/codecs/sta32x.c
>  create mode 100644 sound/soc/codecs/sta32x.h

Is this intended for review only or upstream as there is a lot of code behind #if 0 and a lots of FIXMEs ?

Liam
