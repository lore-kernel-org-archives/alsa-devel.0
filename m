From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v3] ASoC: Add TI tlv320aic32x4 codec
 support.
Date: Thu, 03 Mar 2011 10:29:06 +0000
Message-ID: <1299148146.3337.3.camel@odin>
References: <1299073952-11768-1-git-send-email-javier.martin@vista-silicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 823F2103819
	for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2011 11:29:10 +0100 (CET)
Received: by wyb28 with SMTP id 28so871345wyb.38
	for <alsa-devel@alsa-project.org>; Thu, 03 Mar 2011 02:29:10 -0800 (PST)
In-Reply-To: <1299073952-11768-1-git-send-email-javier.martin@vista-silicon.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, b32542@freescale.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-03-02 at 14:52 +0100, Javier Martin wrote:
> This patch adds support for tlv320aic3205 and tlv320aic3254 codecs.
> It doesn't include miniDSP support for aic3254.
> 
> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
> ---
>  include/sound/tlv320aic32x4.h    |   31 ++
>  sound/soc/codecs/Kconfig         |    4 +
>  sound/soc/codecs/Makefile        |    2 +
>  sound/soc/codecs/tlv320aic32x4.c |  794 ++++++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/tlv320aic32x4.h |  143 +++++++
>  5 files changed, 974 insertions(+), 0 deletions(-)
>  create mode 100644 include/sound/tlv320aic32x4.h
>  create mode 100644 sound/soc/codecs/tlv320aic32x4.c
>  create mode 100644 sound/soc/codecs/tlv320aic32x4.h

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
