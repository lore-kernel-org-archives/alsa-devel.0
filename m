From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Subject: Re: [Xen-devel][PATCH v2 2/3] drm/xen-front: Use Xen common shared
 buffer implementation
Date: Tue, 18 Dec 2018 17:15:55 +0100
Message-ID: <75f3a715-94a0-a21d-04c1-aa3cf4cdb331@tronnes.org>
References: <20181130074205.20496-1-andr2000@gmail.com>
 <20181130074205.20496-2-andr2000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181130074205.20496-2-andr2000@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Andrushchenko <andr2000@gmail.com>, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org, jgross@suse.com, boris.ostrovsky@oracle.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: alsa-devel@alsa-project.org


Den 30.11.2018 08.42, skrev Oleksandr Andrushchenko:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>
> Use page directory based shared buffer implementation
> now available as common code for Xen frontend drivers.
>
> Remove flushing of shared buffer on page flip as this
> workaround needs a proper fix.
>
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---

Reviewed-by: Noralf Trønnes <noralf@tronnes.org>
