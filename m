From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH RESEND] xen/sndif: Sync up with the canonical definition
 in Xen
Date: Thu, 12 Apr 2018 13:46:33 -0400
Message-ID: <f3135104-f480-e1e8-0628-136bf265c2f6@oracle.com>
References: <20180412172627.18065-1-oleksandr_andrushchenko@epam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180412172627.18065-1-oleksandr_andrushchenko@epam.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Andrushchenko <andr2000@gmail.com>, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc: jgross@suse.com, iurii.konovalenko@globallogic.com, konrad.wilk@oracle.com, tiwai@suse.de, Oleksandr Grytsov <oleksandr_grytsov@epam.com>
List-Id: alsa-devel@alsa-project.org

On 04/12/2018 01:26 PM, Oleksandr Andrushchenko wrote:
> This is the sync up with the canonical definition of the sound
> protocol in Xen:
>
> 1. Protocol version was referenced in the protocol description,
>    but missed its definition. Fixed by adding a constant
>    for current protocol version.
>
> 2. Some of the request descriptions have "reserved" fields
>    missed: fixed by adding corresponding entries.
>
> 3. Extend the size of the requests and responses to 64 octets.
>    Bump protocol version to 2.
>
> 4. Add explicit back and front synchronization
>    In order to provide explicit synchronization between backend and
>    frontend the following changes are introduced in the protocol:
>     - add new ring buffer for sending asynchronous events from
>       backend to frontend to report number of bytes played by the
>       frontend (XENSND_EVT_CUR_POS)
>     - introduce trigger events for playback control: start/stop/pause/resume
>     - add "req-" prefix to event-channel and ring-ref to unify naming
>       of the Xen event channels for requests and events
>
> 5. Add explicit back and front parameter negotiation
>    In order to provide explicit stream parameter negotiation between
>    backend and frontend the following changes are introduced in the protocol:
>    add XENSND_OP_HW_PARAM_QUERY request to read/update
>    configuration space for the parameters given: request passes
>    desired parameter's intervals/masks and the response to this request
>    returns allowed min/max intervals/masks to be used.
>
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> Signed-off-by: Oleksandr Grytsov <oleksandr_grytsov@epam.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Takashi Iwai <tiwai@suse.de>
> ---

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
