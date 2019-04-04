From: Juergen Gross <jgross@suse.com>
Subject: Re: [Xen-devel][PATCH] ALSA: xen-front: Do not use stream buffer size
 before it is set
Date: Thu, 4 Apr 2019 14:42:44 +0200
Message-ID: <4a852738-7dc1-09df-165b-a133486e3bb7@suse.com>
References: <20190404123838.22162-1-andr2000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190404123838.22162-1-andr2000@gmail.com>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Andrushchenko <andr2000@gmail.com>, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, perex@perex.cz, tiwai@suse.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: alsa-devel@alsa-project.org

On 04/04/2019 14:38, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> 
> This fixes the regression introduced while moving to Xen shared
> buffer implementation.
> 
> Fixes: 58f9d806d16a ("ALSA: xen-front: Use Xen common shared buffer implementation")
> 
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
