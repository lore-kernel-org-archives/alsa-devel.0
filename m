From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] add native DSD support for XMOS based DACs.
Date: Fri, 05 Sep 2014 11:36:16 +0200
Message-ID: <54098410.6050103@ladisch.de>
References: <1409906971-3365-1-git-send-email-gtmkramer@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id C6731265705
 for <alsa-devel@alsa-project.org>; Fri,  5 Sep 2014 11:36:19 +0200 (CEST)
In-Reply-To: <1409906971-3365-1-git-send-email-gtmkramer@xs4all.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jurgen Kramer <gtmkramer@xs4all.nl>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jurgen Kramer wrote:
> Add quirk for XMOS based DACs for native DSD playback support using the new DSD_U32_LE sample
> format. Works for all DAC vendors which use XMOS as idVendor. E.g. iFi Audio
> with their micro iDSD and nano iDSD.
>
> +++ b/sound/usb/quirks.c
> +	/* XMOS based DACs, e.g. iFi Audio micro/nano iDSD */
> +	if (le16_to_cpu(chip->dev->descriptor.idVendor) == 0x20b1) {
> +		switch (fp->altsetting) {
> +		case 2:
> +			return SNDRV_PCM_FMTBIT_DSD_U32_LE;

Can you confirm that all XMOS devices ever built will have DSD on that
alternate setting?


Regards,
Clemens
