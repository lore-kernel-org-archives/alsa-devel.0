From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [PATCH v2 1/5] ALSA: xen-front: Introduce Xen
 para-virtualized sound frontend driver
Date: Tue, 17 Apr 2018 11:24:56 +0300
Message-ID: <ea707fd4-fb72-aa8a-f5ac-dd9ff89dea9b@gmail.com>
References: <20180416062453.24743-1-andr2000@gmail.com>
 <20180416062453.24743-2-andr2000@gmail.com>
 <c473b7b3-6125-7f2f-d3c2-bff58dc61d48@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f66.google.com (mail-lf0-f66.google.com
 [209.85.215.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 45A6B2673D2
 for <alsa-devel@alsa-project.org>; Tue, 17 Apr 2018 10:24:58 +0200 (CEST)
Received: by mail-lf0-f66.google.com with SMTP id p142-v6so26021935lfd.6
 for <alsa-devel@alsa-project.org>; Tue, 17 Apr 2018 01:24:58 -0700 (PDT)
In-Reply-To: <c473b7b3-6125-7f2f-d3c2-bff58dc61d48@suse.com>
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
To: Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, perex@perex.cz, tiwai@suse.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: alsa-devel@alsa-project.org

On 04/16/2018 03:25 PM, Juergen Gross wrote:
> On 16/04/18 08:24, Oleksandr Andrushchenko wrote:
>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>
>> Introduce skeleton of the para-virtualized Xen sound
>> frontend driver.
>>
>> Initial handling for Xen bus states: implement
>> Xen bus state machine for the frontend driver according to
>> the state diagram and recovery flow from sound para-virtualized
>> protocol: xen/interface/io/sndif.h.
>>
>> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> Only one minor nit (see below). With that addressed (or fixed when
> committing):
will fix
> Reviewed-by: Juergen Gross <jgross@suse.com>
Thank you
>
> Juergen
>
>> ---
>>   sound/Kconfig             |   2 +
>>   sound/Makefile            |   2 +-
>>   sound/xen/Kconfig         |  10 +++
>>   sound/xen/Makefile        |   5 ++
>>   sound/xen/xen_snd_front.c | 196 ++++++++++++++++++++++++++++++++++++++++++++++
>>   sound/xen/xen_snd_front.h |  18 +++++
>>   6 files changed, 232 insertions(+), 1 deletion(-)
>>   create mode 100644 sound/xen/Kconfig
>>   create mode 100644 sound/xen/Makefile
>>   create mode 100644 sound/xen/xen_snd_front.c
>>   create mode 100644 sound/xen/xen_snd_front.h
>>
>> diff --git a/sound/xen/xen_snd_front.c b/sound/xen/xen_snd_front.c
>> new file mode 100644
>> index 000000000000..f406a8f52c51
>> --- /dev/null
>> +++ b/sound/xen/xen_snd_front.c
>> @@ -0,0 +1,196 @@
>> +static void sndback_changed(struct xenbus_device *xb_dev,
>> +			    enum xenbus_state backend_state)
>> +{
>> +	struct xen_snd_front_info *front_info = dev_get_drvdata(&xb_dev->dev);
>> +	int ret;
>> +
>> +	dev_dbg(&xb_dev->dev, "Backend state is %s, front is %s\n",
>> +		xenbus_strstate(backend_state),
>> +		xenbus_strstate(xb_dev->state));
>> +
>> +	switch (backend_state) {
>> +	case XenbusStateReconfiguring:
>> +		/* fall through */
>> +	case XenbusStateReconfigured:
>> +		/* fall through */
>> +	case XenbusStateInitialised:
>> +		/* fall through */
>> +		break;
>> +
>> +	case XenbusStateInitialising:
>> +		/* recovering after backend unexpected closure */
>> +		sndback_disconnect(front_info);
>> +		break;
>> +
>> +	case XenbusStateInitWait:
>> +		/* recovering after backend unexpected closure */
>> +		sndback_disconnect(front_info);
>> +
>> +		ret = sndback_initwait(front_info);
>> +		if (ret < 0)
>> +			xenbus_dev_fatal(xb_dev, ret, "initializing frontend");
>> +		else
>> +			xenbus_switch_state(xb_dev, XenbusStateInitialised);
>> +		break;
>> +
>> +	case XenbusStateConnected:
>> +		if (xb_dev->state != XenbusStateInitialised)
>> +			break;
>> +
>> +		ret = sndback_connect(front_info);
>> +		if (ret < 0)
>> +			xenbus_dev_fatal(xb_dev, ret, "initializing frontend");
>> +		else
>> +			xenbus_switch_state(xb_dev, XenbusStateConnected);
>> +		break;
>> +
>> +	case XenbusStateClosing:
>> +		/*
>> +		 * in this state backend starts freeing resources,
>> +		 * so let it go into closed state first, so we can also
>> +		 * remove ours
>> +		 */
> Please start the sentence with a capital letter and end it with a
> full stop.
>
>
> Juergen
