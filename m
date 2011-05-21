From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 1/2] ASoC: tlv320aic3x: Don't sync first
 two registers from register cache
Date: Sat, 21 May 2011 16:30:50 +0100
Message-ID: <4DD7DAAA.3070504@ti.com>
References: <1305899558-21719-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 2170D103810
	for <alsa-devel@alsa-project.org>;
	Sat, 21 May 2011 17:30:55 +0200 (CEST)
In-Reply-To: <1305899558-21719-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 20/05/11 14:52, Jarkko Nikula wrote:
> There is no need to sync first two registers from cache to hw after a reset.
> First one is used to select page for register access and this driver is
> normally accessing page 0 only. Second one does a software reset which is
> obviously unneeded after hardware or previous software reset command.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> ---
>  sound/soc/codecs/tlv320aic3x.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 

Both

Acked-by: Liam Girdwood <lrg@ti.com>
