From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [Xen-devel] [PATCH v2 2/3] drm/xen-front: Use Xen
 common shared buffer implementation
Date: Mon, 17 Dec 2018 09:52:24 -0500
Message-ID: <ce52ec2e-1b22-8a2f-7f99-d90fcfdbfebd@oracle.com>
References: <20181130074205.20496-1-andr2000@gmail.com>
 <20181130074205.20496-2-andr2000@gmail.com>
 <3c69d924-11e1-7037-bfa5-276d22b245fe@gmail.com>
 <27491aa5-3548-4c39-13a2-132c738fae14@gmail.com>
 <71920419-f0ef-8489-35ff-ff8375cb7361@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by alsa0.perex.cz (Postfix) with ESMTP id A76B9267944
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 15:52:37 +0100 (CET)
In-Reply-To: <71920419-f0ef-8489-35ff-ff8375cb7361@gmail.com>
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

On 12/17/18 5:19 AM, Oleksandr Andrushchenko wrote:
> Hello, Juergen, Boris!
>
> As this DRM part of the series is the only one which needs ack/nack
>
> (and it might take quite some time to complete) could we please
>
> merge the patches 1 and 3 now that already have ack/r-b?
>



TBH I am not sure it makes sense to do this without the second patch.
Refactoring (and IIUIC this series is purely refactoring --- is it not?)
is done to reduce amount of code, and with only first and third patch we
end up with quite a significant increase in the number of LoC. (I am
going purely by diffstat)

Of course, the other reason for refactoring is to eliminate code
duplication, but without second patch that will not happen.

-boris
