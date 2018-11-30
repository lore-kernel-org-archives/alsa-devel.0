From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [Xen-devel][PATCH 1/3] xen: Introduce shared buffer helpers for
 page directory...
Date: Fri, 30 Nov 2018 09:07:29 +0200
Message-ID: <ee394331-282e-9942-a576-73cf714b620e@gmail.com>
References: <20181122100230.14976-1-andr2000@gmail.com>
 <133b948f-fc31-4505-0b85-5fc7a7beb559@gmail.com>
 <f802385f-3c78-2804-9e47-b590a9580955@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f802385f-3c78-2804-9e47-b590a9580955@suse.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org, boris.ostrovsky@oracle.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: alsa-devel@alsa-project.org

On 11/30/18 8:50 AM, Juergen Gross wrote:
> On 29/11/2018 12:22, Oleksandr Andrushchenko wrote:
>> ping
>>
>> On 11/22/18 12:02 PM, Oleksandr Andrushchenko wrote:
>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>
>>> based frontends. Currently the frontends which implement
>>> similar code for sharing big buffers between frontend and
>>> backend are para-virtualized DRM and sound drivers.
>>> Both define the same way to share grant references of a
>>> data buffer with the corresponding backend with little
>>> differences.
>>>
>>> Move shared code into a helper module, so there is a single
>>> implementation of the same functionality for all.
>>>
>>> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> In general I'm fine with this approach.
>
> With the concerns raised for one of the other patches I wanted to wait
> for V2 of the series.
Ah, I waited for any comments before rolling v2 out ;)
>   Or won't the resulting change require a
> modification of this patch?

This patch won't change, it is only DRM related

The concern for the DRM patch is already resolved

and the corresponding patch is on review now [1]

>
> It would be nice if you could point out in the commit message whether
> you are doing code movement (with some renames) only, or if there are
> any functional changes involved (and which ones).
Sure, this is pure code movement, no functional changes
>   This would make the
> review much easier and less time consuming.
>
>
> Juergen

Thank you,

Oleksandr

[1] https://lkml.org/lkml/2018/11/27/811
