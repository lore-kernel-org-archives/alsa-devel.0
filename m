From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] Provide sequencer sound card number /
	PID	via alsa-lib
Date: Mon, 15 Feb 2016 11:39:13 +0100
Message-ID: <56C1AAD1.70307@ladisch.de>
References: <1455370937-501-1-git-send-email-martin@mail.zuhause>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 6AD0D2612DF
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 11:39:16 +0100 (CET)
In-Reply-To: <1455370937-501-1-git-send-email-martin@mail.zuhause>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Martin Koegler <martin.koegler@chello.at>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Martin Koegler wrote:
> +++ b/src/seq/seq.c
>  /**
> + * \brief Get the sound card number (kernel) or owning PID
> + * \param info client_info container
> + * \return card number/PID/-1 if value is not available.
> + */

Please document that card/pid are valid only for clients of type
SND_SEQ_KERNEL/USER_CLIENT.

And I think two functions for card and pid are more appropriate.


Regards,
Clemens
