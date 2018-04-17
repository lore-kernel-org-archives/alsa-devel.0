From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2 4/5] ALSA: xen-front: Implement handling of shared
 buffers
Date: Tue, 17 Apr 2018 13:15:51 +0200
Message-ID: <7abbbaa0-93c7-5c93-d653-ed5a04199f6e@suse.com>
References: <20180416062453.24743-1-andr2000@gmail.com>
 <20180416062453.24743-5-andr2000@gmail.com>
 <6ab76dd7-ec6b-0756-5490-f5b5805998d6@suse.com>
 <edbd53c6-3396-9293-4a04-2b22655eeb12@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <edbd53c6-3396-9293-4a04-2b22655eeb12@gmail.com>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Andrushchenko <andr2000@gmail.com>, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, perex@perex.cz, tiwai@suse.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: alsa-devel@alsa-project.org

On 17/04/18 11:22, Oleksandr Andrushchenko wrote:
> On 04/16/2018 04:39 PM, Juergen Gross wrote:
>> On 16/04/18 08:24, Oleksandr Andrushchenko wrote:
>>> +static int alloc_int_buffers(struct xen_snd_front_shbuf *buf,
>>> +                 int num_pages_dir, int num_pages_buffer,
>>> +                 int num_grefs)
>>> +{
>>> +    buf->grefs = kcalloc(num_grefs, sizeof(*buf->grefs), GFP_KERNEL);
>>> +    if (!buf->grefs)
>>> +        return -ENOMEM;
>>> +
>>> +    buf->directory = kcalloc(num_pages_dir, XEN_PAGE_SIZE, GFP_KERNEL);
>>> +    if (!buf->directory)
>>> +        goto fail;
>>> +
>>> +    buf->buffer_sz = num_pages_buffer * XEN_PAGE_SIZE;
>>> +    buf->buffer = alloc_pages_exact(buf->buffer_sz, GFP_KERNEL);
>>> +    if (!buf->buffer)
>>> +        goto fail;
>>> +
>>> +    return 0;
>>> +
>>> +fail:
>>> +    kfree(buf->grefs);
>>> +    buf->grefs = NULL;
>>> +    kfree(buf->directory);
>> Why do you need to free those here? Shouldn't that be done via
>> xen_snd_front_shbuf_free() in case of an error?
> At this place we only allocate memory, but xen_snd_front_shbuf_free
> will also try to gnttab_end_foreign_access if buf->grefs != NULL.

Okay.


Juergen
