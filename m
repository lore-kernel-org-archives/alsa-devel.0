From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel][PATCH 2/2] sndif: add explicit back
 and front synchronization
Date: Thu, 1 Mar 2018 17:11:56 -0500
Message-ID: <20180301221156.GC32676@char.us.oracle.com>
References: <1517819100-1029-1-git-send-email-andr2000@gmail.com>
 <1517819100-1029-3-git-send-email-andr2000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by alsa0.perex.cz (Postfix) with ESMTP id A8C0026731A
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 23:12:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1517819100-1029-3-git-send-email-andr2000@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Oleksandr Grytsov <oleksandr_grytsov@epam.com>, xen-devel@lists.xenproject.org
List-Id: alsa-devel@alsa-project.org

>   * +----------------+----------------+----------------+----------------+
>   * |                           gref_directory                          | 24
>   * +----------------+----------------+----------------+----------------+
> - * |                             reserved                              | 28
> - * +----------------+----------------+----------------+----------------+
> - * |/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|
> + * |                             period_sz                             | 28
>   * +----------------+----------------+----------------+----------------+
>   * |                             reserved                              | 32
>   * +----------------+----------------+----------------+----------------+
> @@ -578,6 +616,14 @@
>   * pcm_channels - uint8_t, number of channels of this stream,
>   *   [channels-min; channels-max]
>   * buffer_sz - uint32_t, buffer size to be allocated, octets
> + * period_sz - uint32_t, recommended event period size, octets
> + *   This is the recommended (hint) value of the period at which frontend would
> + *   like to receive XENSND_EVT_CUR_POS notifications from the backend when
> + *   stream position advances during playback/capture.
> + *   It shows how many octets are expected to be played/captured before
> + *   sending such an event.
> + *   If set to 0 no XENSND_EVT_CUR_POS events are sent by the backend.
> + *

I would gate this based on the version. That is if version 0 then this
field does not exist.
>   * gref_directory - grant_ref_t, a reference to the first shared page
>   *   describing shared buffer references. At least one page exists. If shared
>   *   buffer size  (buffer_sz) exceeds what can be addressed by this single page,
> @@ -592,6 +638,7 @@ struct xensnd_open_req {
>      uint16_t reserved;
>      uint32_t buffer_sz;
>      grant_ref_t gref_directory;
> +    uint32_t period_sz;

The same here. Just put a comment mentioning the version part.
