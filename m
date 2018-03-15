From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel][PATCH v2 2/3] sndif: Add explicit back
 and front synchronization
Date: Thu, 15 Mar 2018 16:17:24 -0400
Message-ID: <20180315201724.GN10870@char.us.oracle.com>
References: <1521043365-26813-1-git-send-email-andr2000@gmail.com>
 <1521043365-26813-3-git-send-email-andr2000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EC97267282
 for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2018 21:17:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1521043365-26813-3-git-send-email-andr2000@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: alsa-devel@alsa-project.org, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, tiwai@suse.de, Clemens Ladisch <clemens@ladisch.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Oleksandr Grytsov <oleksandr_grytsov@epam.com>, xen-devel@lists.xenproject.org
List-Id: alsa-devel@alsa-project.org

> + ******************************************************************************
> + *                        Back to front events delivery
> + ******************************************************************************
> + * In order to deliver asynchronous events from back to front a shared page is
> + * allocated by front and its granted reference propagated to back via
> + * XenStore entries (evt-ring-ref/evt-event-channel).
> + * This page has a common header used by both front and back to synchronize
> + * access and control event's ring buffer, while back being a producer of the
> + * events and front being a consumer. The rest of the page after the header
> + * is used for event packets.
> + *
> + * Upon reception of an event(s) front may confirm its reception
> + * for either each event, group of events or none.
> + */
> +
> +struct xensnd_event_page {
> +    uint32_t in_cons;
> +    uint32_t in_prod;
> +    uint8_t reserved[24];

Could this be aligned at 64 bytes?
> +};
> +
