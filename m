From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [Xen-devel][PATCH] ALSA: xen-front: Do not use stream buffer size
 before it is set
Date: Thu, 4 Apr 2019 15:46:53 +0300
Message-ID: <605c7689-de3e-06fe-2771-4b47dee1cd8f@gmail.com>
References: <20190404123838.22162-1-andr2000@gmail.com>
 <4a852738-7dc1-09df-165b-a133486e3bb7@suse.com>
 <s5h4l7ec51l.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h4l7ec51l.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Juergen Gross <jgross@suse.com>
Cc: alsa-devel@alsa-project.org, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, perex@perex.cz, linux-kernel@vger.kernel.org, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: alsa-devel@alsa-project.org

On 4/4/19 3:45 PM, Takashi Iwai wrote:
> On Thu, 04 Apr 2019 14:42:44 +0200,
> Juergen Gross wrote:
>> On 04/04/2019 14:38, Oleksandr Andrushchenko wrote:
>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>
>>> This fixes the regression introduced while moving to Xen shared
>>> buffer implementation.
>>>
>>> Fixes: 58f9d806d16a ("ALSA: xen-front: Use Xen common shared buffer implementation")
>>>
>>> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>> Reviewed-by: Juergen Gross <jgross@suse.com>
> Applied now, thanks.
> I put Cc to stable since the bug was already in 5.0.
>
>
> Takashi
Thank you,
Oleksandr
