From: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: Re: [PATCH 1/7] powerpc/52xx: define FSL_SOC
Date: Fri, 14 Sep 2012 10:45:32 -0400
Message-ID: <0A40042D85E7C84DB443060EC44B3FD336D854FEF9@dekaexchange07.deka.local>
References: <1347572596-37540-1-git-send-email-emillbrandt@dekaresearch.com>
 <1347572596-37540-2-git-send-email-emillbrandt@dekaresearch.com>
 <20120914113100.119048xeot7zcym8@webmail.mnet-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dekaexchange07.deka.local (mail.dekaresearch.com
 [208.65.175.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D560264ED1
 for <alsa-devel@alsa-project.org>; Fri, 14 Sep 2012 16:45:42 +0200 (CEST)
In-Reply-To: <20120914113100.119048xeot7zcym8@webmail.mnet-online.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "'agust@denx.de'" <agust@denx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 2012-09-14 agust@denx.de wrote:
> Eric Millbrandt <emillbrandt@dekaresearch.com> wrote:
>
...
>
> Better use:
>
> diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig index
> d701330..4563b28 100644
> --- a/sound/soc/fsl/Kconfig
> +++ b/sound/soc/fsl/Kconfig
> @@ -6,7 +6,7 @@ config SND_SOC_FSL_UTILS
>
>   menuconfig SND_POWERPC_SOC
>          tristate "SoC Audio for Freescale PowerPC CPUs"
> -       depends on FSL_SOC
> +       depends on FSL_SOC || PPC_MPC52xx
>          help
>            Say Y or M if you want to add support for codecs attached to
>            the PowerPC CPUs.
> Thanks,
>
> Anatolij
>

Looks good to me, I will do this instead.  Thanks.

Eric


-DISCLAIMER: an automatically appended disclaimer may follow. By posting-
-to a public e-mail mailing list I hereby grant permission to distribute-
-and copy this message.-

This e-mail and the information, including any attachments, it contains are intended to be a confidential communication only to the person or entity to whom it is addressed and may contain information that is privileged. If the reader of this message is not the intended recipient, you are hereby notified that any dissemination, distribution or copying of this communication is strictly prohibited. If you have received this communication in error, please immediately notify the sender and destroy the original message.

Thank you.

Please consider the environment before printing this email.
