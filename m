From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [PATCH v2 3/5] ALSA: xen-front: Implement Xen event channel
 handling
Date: Tue, 24 Apr 2018 17:29:15 +0300
Message-ID: <af277f77-5b22-58e3-4ea6-cde34e3181d3@gmail.com>
References: <20180416062453.24743-1-andr2000@gmail.com>
 <20180416062453.24743-4-andr2000@gmail.com> <s5ho9i8sn25.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5ho9i8sn25.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, perex@perex.cz, Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: alsa-devel@alsa-project.org

On 04/24/2018 05:20 PM, Takashi Iwai wrote:
> On Mon, 16 Apr 2018 08:24:51 +0200,
> Oleksandr Andrushchenko wrote:
>> +static irqreturn_t evtchnl_interrupt_req(int irq, void *dev_id)
>> +{
>> +	struct xen_snd_front_evtchnl *channel = dev_id;
>> +	struct xen_snd_front_info *front_info = channel->front_info;
>> +	struct xensnd_resp *resp;
>> +	RING_IDX i, rp;
>> +	unsigned long flags;
>> +
>> +	if (unlikely(channel->state != EVTCHNL_STATE_CONNECTED))
>> +		return IRQ_HANDLED;
>> +
>> +	spin_lock_irqsave(&front_info->io_lock, flags);
>> +
>> +again:
>> +	rp = channel->u.req.ring.sring->rsp_prod;
>> +	/* ensure we see queued responses up to rp */
>> +	rmb();
>> +
>> +	for (i = channel->u.req.ring.rsp_cons; i != rp; i++) {
> I'm not familiar with Xen stuff in general, but through a quick
> glance, this kind of code worries me a bit.
>
> If channel->u.req.ring.rsp_cons has a bogus number, this may lead to a
> very long loop, no?  Better to have a sanity check of the ring buffer
> size.
In this loop I have:
resp = RING_GET_RESPONSE(&channel->u.req.ring, i);
and the RING_GET_RESPONSE macro is designed in the way that
it wraps around when *i* in the question gets bigger than
the ring size:

#define RING_GET_REQUEST(_r, _idx)                    \
     (&((_r)->sring->ring[((_idx) & (RING_SIZE(_r) - 1))].req))

So, even if the counter has a bogus number it will not last long

>> +static irqreturn_t evtchnl_interrupt_evt(int irq, void *dev_id)
>> +{
>> +	struct xen_snd_front_evtchnl *channel = dev_id;
>> +	struct xen_snd_front_info *front_info = channel->front_info;
>> +	struct xensnd_event_page *page = channel->u.evt.page;
>> +	u32 cons, prod;
>> +	unsigned long flags;
>> +
>> +	if (unlikely(channel->state != EVTCHNL_STATE_CONNECTED))
>> +		return IRQ_HANDLED;
>> +
>> +	spin_lock_irqsave(&front_info->io_lock, flags);
>> +
>> +	prod = page->in_prod;
>> +	/* ensure we see ring contents up to prod */
>> +	virt_rmb();
>> +	if (prod == page->in_cons)
>> +		goto out;
>> +
>> +	for (cons = page->in_cons; cons != prod; cons++) {
> Ditto.
Same as above
>
> thanks,
>
> Takashi
Thank you,
Oleksandr
