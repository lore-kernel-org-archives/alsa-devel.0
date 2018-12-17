From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [Xen-devel] [PATCH v2 2/3] drm/xen-front: Use Xen
 common shared buffer implementation
Date: Mon, 17 Dec 2018 10:26:42 -0500
Message-ID: <19501fdd-eae6-295e-7394-777c25ea4cf1@oracle.com>
References: <20181130074205.20496-1-andr2000@gmail.com>
 <20181130074205.20496-2-andr2000@gmail.com>
 <3c69d924-11e1-7037-bfa5-276d22b245fe@gmail.com>
 <27491aa5-3548-4c39-13a2-132c738fae14@gmail.com>
 <71920419-f0ef-8489-35ff-ff8375cb7361@gmail.com>
 <ce52ec2e-1b22-8a2f-7f99-d90fcfdbfebd@oracle.com>
 <686a8b1e-3588-32bc-abc7-79221dc9c74e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by alsa0.perex.cz (Postfix) with ESMTP id C252F267944
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 16:26:59 +0100 (CET)
In-Reply-To: <686a8b1e-3588-32bc-abc7-79221dc9c74e@gmail.com>
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
To: Oleksandr Andrushchenko <andr2000@gmail.com>, jgross@suse.com
Cc: alsa-devel@alsa-project.org, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, xen-devel@lists.xenproject.org
List-Id: alsa-devel@alsa-project.org

On 12/17/18 10:03 AM, Oleksandr Andrushchenko wrote:
> On 12/17/18 4:52 PM, Boris Ostrovsky wrote:
>> On 12/17/18 5:19 AM, Oleksandr Andrushchenko wrote:
>>> Hello, Juergen, Boris!
>>>
>>> As this DRM part of the series is the only one which needs ack/nack
>>>
>>> (and it might take quite some time to complete) could we please
>>>
>>> merge the patches 1 and 3 now that already have ack/r-b?
>>>
>>
>>
>> TBH I am not sure it makes sense to do this without the second patch.
>> Refactoring (and IIUIC this series is purely refactoring --- is it not?)
>> is done to reduce amount of code, and with only first and third patch we
>> end up with quite a significant increase in the number of LoC. (I am
>> going purely by diffstat)
>>
>> Of course, the other reason for refactoring is to eliminate code
>> duplication, but without second patch that will not happen.
>
> Agree, but this is the basis for the new pv camera frontend
>
> I am working on now [1], so even if we do not remove the code from DRM
>
> then we at least do not add it to the camera driver


Since 1 and 3 are already ACKed you should be able to start the camera
series with these two patches as pre-requisites even if patch 2 is still
stalled by the time your camera code is posted (which I assume will be
4.22 or later).



-boris


>
>> -boris
>
> Thank you,
>
> Oleksandr
>
> [1]
> https://github.com/andr2000/linux/blob/camera_front_v1/drivers/media/xen/Kconfig#L6
>
