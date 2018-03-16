From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [Xen-devel][PATCH v2 2/3] sndif: Add explicit back
 and front synchronization
Date: Fri, 16 Mar 2018 08:24:41 +0200
Message-ID: <7752ee92-8f43-03be-5e64-702794af0f8d@gmail.com>
References: <1521043365-26813-1-git-send-email-andr2000@gmail.com>
 <1521043365-26813-3-git-send-email-andr2000@gmail.com>
 <20180315201724.GN10870@char.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f66.google.com (mail-lf0-f66.google.com
 [209.85.215.66])
 by alsa0.perex.cz (Postfix) with ESMTP id E89C4267274
 for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2018 07:24:43 +0100 (CET)
Received: by mail-lf0-f66.google.com with SMTP id g13-v6so2722185lfe.10
 for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2018 23:24:43 -0700 (PDT)
In-Reply-To: <20180315201724.GN10870@char.us.oracle.com>
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
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: alsa-devel@alsa-project.org, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, tiwai@suse.de, Clemens Ladisch <clemens@ladisch.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Oleksandr Grytsov <oleksandr_grytsov@epam.com>, xen-devel@lists.xenproject.org
List-Id: alsa-devel@alsa-project.org

On 03/15/2018 10:17 PM, Konrad Rzeszutek Wilk wrote:
>> + ******************************************************************************
>> + *                        Back to front events delivery
>> + ******************************************************************************
>> + * In order to deliver asynchronous events from back to front a shared page is
>> + * allocated by front and its granted reference propagated to back via
>> + * XenStore entries (evt-ring-ref/evt-event-channel).
>> + * This page has a common header used by both front and back to synchronize
>> + * access and control event's ring buffer, while back being a producer of the
>> + * events and front being a consumer. The rest of the page after the header
>> + * is used for event packets.
>> + *
>> + * Upon reception of an event(s) front may confirm its reception
>> + * for either each event, group of events or none.
>> + */
>> +
>> +struct xensnd_event_page {
>> +    uint32_t in_cons;
>> +    uint32_t in_prod;
>> +    uint8_t reserved[24];
> Could this be aligned at 64 bytes?
Sure, will make the struct 64 bytes
>> +};
>> +
