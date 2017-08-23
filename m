From: Oleksandr Grytsov <al1img@gmail.com>
Subject: Re: [PATCH RESEND1 00/12] ALSA: vsnd: Add Xen
 para-virtualized frontend driver
Date: Wed, 23 Aug 2017 17:51:20 +0300
Message-ID: <CACvf2oUJtxVTuV0qu4z4kV=aSOH5O_8v=UjH_3tr4wCJdXuEjw@mail.gmail.com>
References: <1502108577-8099-1-git-send-email-andr2000@gmail.com>
 <7e62a406-7dcd-b5c9-b2de-ea52e1d2afd0@sakamocchi.jp>
 <b9e34f0e-4a9a-9ccf-6165-04cd22a070ac@gmail.com>
 <CACvf2oU4puqSuNj2k5REpmFJdvWcTWY+AaNEJtknLP4XMPdbsg@mail.gmail.com>
 <e5d52c8a-09e0-2823-dcff-e595868c7dee@sakamocchi.jp>
 <2a2fd222-fc54-1709-bfc8-a530efc3f307@gmail.com>
 <ad4f2201-bfab-415d-0120-308989653628@sakamocchi.jp>
 <b129960e-b38f-ea94-3e4a-3cd409f7a707@gmail.com>
 <3f8e535b-8607-6b15-6e17-da755a06cc1e@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f181.google.com (mail-io0-f181.google.com
 [209.85.223.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B81F267782
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 16:51:22 +0200 (CEST)
Received: by mail-io0-f181.google.com with SMTP id o196so1319998ioe.0
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 07:51:22 -0700 (PDT)
In-Reply-To: <3f8e535b-8607-6b15-6e17-da755a06cc1e@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, Oleksandr Andrushchenko <andr2000@gmail.com>, clemens@ladisch.de, tiwai@suse.com, linux-kernel@vger.kernel.org, xen-devel@lists.xen.org
List-Id: alsa-devel@alsa-project.org

Hi,

Thank you for detailed explanation.

We understand that emulated interrupt on the frontend side is completely not
acceptable and definitely we need to provide some feedback mechanism from
Dom0 to DomU.

In our case it is technically impossible to provide precise period interrupt
(mostly because our backend is a user space application).
The best we can implement it is provide number of frames (time, bytes etc.)
consumed by real HW. This info will be outdated due to different delays but
we can provide precise timestamps when this info was acquired.

Would this info be useful to update the frontend driver state?

If you have in mind any other solution we would appreciate.

-- 
Best Regards,
Oleksandr Grytsov.
