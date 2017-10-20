From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [Patch v6 2/7] slimbus: Add messaging APIs to slimbus framework
Date: Thu, 19 Oct 2017 22:00:26 -0700
Message-ID: <CAOCOHw4k+JTm-QRTvdYAKJy=bSSM1EXq+4Ne3E9APsKRC5pgtw@mail.gmail.com>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-3-srinivas.kandagatla@linaro.org> <20171018061500.GE1575@tuxbook>
 <1dfaba0b-78c2-8445-3b04-0bd6a25bf221@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1dfaba0b-78c2-8445-3b04-0bd6a25bf221@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Sagar Dharia <sdharia@codeaurora.org>, bp@suse.de, poeschel@lemonage.de, Thierry Reding <treding@nvidia.com>, gong.chen@linux.intel.com, andreas.noever@gmail.com, alan@linux.intel.com, Mathieu Poirier <mathieu.poirier@linaro.org>, daniel@ffwll.ch, Jiri Kosina <jkosina@suse.cz>, sharon.dvir1@mail.huji.ac.il, joe@perches.com, David Miller <davem@davemloft.net>, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, kheitke@audience.com, linux-arm-msm <linux-arm-msm@vger.ke>
List-Id: alsa-devel@alsa-project.org

On Wed 18 Oct 09:39 PDT 2017, Srinivas Kandagatla wrote:

> Thanks for Review Comments,
>
>
> On 18/10/17 07:15, Bjorn Andersson wrote:
> > On Fri 06 Oct 08:51 PDT 2017, srinivas.kandagatla@linaro.org wrote:
[..]
> >
> > > + if (!async) {
> > > + txn->msg->comp_cb = NULL;
> > > + txn->msg->ctx = NULL;
> >
> > I believe txn->msg is always required, so you don't need to do this
> > contidionally.
>
> I don't get this, why do you want to set comp_cb to NULL unconditionally?
>

I'm just not happy about the complexity of this function, but perhaps
it's confusing to always set them, regardless of them being used. Feel
free to keep it.

[..]
> > > +void slim_return_tx(struct slim_controller *ctrl, int err)
> > > +{
> > > + unsigned long flags;
> > > + int idx;
> > > + struct slim_pending cur;
> > > +
> > > + spin_lock_irqsave(&ctrl->tx.lock, flags);
> > > + idx = ctrl->tx.head;
> > > + ctrl->tx.head = (ctrl->tx.head + 1) % ctrl->tx.n;
> > > + cur = ctrl->pending_wr[idx];
> >
> > Why is this doing struct copy?
> >
> Not sure, do you see any issue with this?
>

It's a rarely used feature and I don't see a reason for using it here.

It's probably better to make a copy of cur.cb and cur.ctx to make their
use after the spin-unlock more obvious (but should be fine as the
spinlock is for the pending_wr array.

> > > + spin_unlock_irqrestore(&ctrl->tx.lock, flags);
> > > +
> > > + if (!cur.cb)
> > > + dev_err(&ctrl->dev, "NULL Transaction or completion");
> > > + else
> > > + cur.cb(cur.ctx, err);
> > > +
> > > + up(&ctrl->tx_sem);
> > > +}
> > > +EXPORT_SYMBOL_GPL(slim_return_tx);
[..]
> > > +/**
> > > + * struct slim_ctrl_buf: circular buffer used by contoller for TX, RX
> > > + * @base: virtual base address for this buffer
> > > + * @phy: physical address for this buffer (this is useful if controller can
> > > + *  DMA the buffers for TX and RX to/from controller hardware
> > > + * @lock: lock protecting head and tail
> > > + * @head: index where buffer is returned back
> > > + * @tail: index from where buffer is consumed
> > > + * @sl_sz: byte-size of each slot in this buffer
> > > + * @n:  number of elements in this circular ring, note that this needs to be
> > > + * 1 more than actual buffers to allow for one open slot
> > > + */
> >
> > Is this ringbuffer mechanism defined in the slimbus specification? Looks
> > like something specific to the Qualcomm controller, rather than
> > something that should be enforced in the framework.
> >
>
> Yes, this is not part of the slimbus specs, but Qcom SOCs have concept of
> Message Queues.
>
> Are you suggesting that this buffer handling has to be moved out of core
> into controller driver?
>

The fact that this seems to describe a physical ring buffer, with some
set of properties that are related to how a ring buffer works in the
Qualcomm hardware and it carries a notion of physical mapping, all
indicates to me that this describes some Qualcomm hardware interface.

I believe this is a hardware implementation detail that should reside in
the hardware part of the implementation (i.e. the Qualcomm driver).

>
> > > +struct slim_ctrl_buf {
> > > + void *base;
> > > + phys_addr_t phy;
> > > + spinlock_t lock;
> > > + int head;
> > > + int tail;
> > > + int sl_sz;
> > > + int n;
> > > +};

Regards,
Bjorn
