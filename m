From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [Xen-devel][PATCH v2 2/3] drm/xen-front: Use Xen common shared
 buffer implementation
Date: Tue, 18 Dec 2018 20:48:41 +0200
Message-ID: <ee6401d6-0e36-11f0-785a-ef0e26e2f60b@gmail.com>
References: <20181130074205.20496-1-andr2000@gmail.com>
 <20181130074205.20496-2-andr2000@gmail.com>
 <75f3a715-94a0-a21d-04c1-aa3cf4cdb331@tronnes.org>
 <0f699d62-41be-33ec-d62c-6fce10f8fd30@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0f699d62-41be-33ec-d62c-6fce10f8fd30@oracle.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>, =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org, jgross@suse.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: alsa-devel@alsa-project.org


On 12/18/18 20:31, Boris Ostrovsky wrote:
> On 12/18/18 11:15 AM, Noralf Trønnes wrote:
>> Den 30.11.2018 08.42, skrev Oleksandr Andrushchenko:
>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>
>>> Use page directory based shared buffer implementation
>>> now available as common code for Xen frontend drivers.
>>>
>>> Remove flushing of shared buffer on page flip as this
>>> workaround needs a proper fix.
>>>
>>> Signed-off-by: Oleksandr Andrushchenko
>>> <oleksandr_andrushchenko@epam.com>
>>> ---
>> Reviewed-by: Noralf Trønnes <noralf@tronnes.org>
Thank you, Noralf!
>
> Now that all 3 have been acked/reviewed
>
> Applied to for-linus-4.21
Thank you, Boris, Juergen!
>
