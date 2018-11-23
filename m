From: Juergen Gross <jgross@suse.com>
Subject: Re: [Xen-devel][PATCH 2/3] drm/xen-front: Use Xen common shared
 buffer implementation
Date: Fri, 23 Nov 2018 09:24:59 +0100
Message-ID: <0e9bde68-3f4c-7471-1d8d-89b145e65b54@suse.com>
References: <20181122100230.14976-1-andr2000@gmail.com>
 <20181122100230.14976-2-andr2000@gmail.com>
 <20181122143354.GG4266@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122143354.GG4266@phenom.ffwll.local>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Andrushchenko <andr2000@gmail.com>, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org, boris.ostrovsky@oracle.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: alsa-devel@alsa-project.org

On 22/11/2018 15:33, Daniel Vetter wrote:
> On Thu, Nov 22, 2018 at 12:02:29PM +0200, Oleksandr Andrushchenko wrote:
>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>
>> Use page directory based shared buffer implementation
>> now available as common code for Xen frontend drivers.
>>
>> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>> ---
>>  drivers/gpu/drm/xen/Kconfig               |   1 +
>>  drivers/gpu/drm/xen/Makefile              |   1 -
>>  drivers/gpu/drm/xen/xen_drm_front.c       |  60 ++--
>>  drivers/gpu/drm/xen/xen_drm_front_gem.c   |   1 -
>>  drivers/gpu/drm/xen/xen_drm_front_shbuf.c | 414 ----------------------
>>  drivers/gpu/drm/xen/xen_drm_front_shbuf.h |  64 ----
>>  6 files changed, 30 insertions(+), 511 deletions(-)
>>  delete mode 100644 drivers/gpu/drm/xen/xen_drm_front_shbuf.c
>>  delete mode 100644 drivers/gpu/drm/xen/xen_drm_front_shbuf.h
> Anyway, I'm all for code duplication removal, so if the Xen folks are
> happy with patch 1, this one here has my ack. Might also be best to merge
> all three through the Xen tree. Fallback would be xen folks sending a
> topic pull request with these 3 patches to drm-misc and takashi's sound
> tree.

I'm fine with taking it through the Xen tree.


Juergen
