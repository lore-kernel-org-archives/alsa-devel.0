From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH RESEND1 00/12] ALSA: vsnd: Add Xen
 para-virtualized frontend driver
Date: Fri, 18 Aug 2017 14:43:19 +0900
Message-ID: <e5d52c8a-09e0-2823-dcff-e595868c7dee@sakamocchi.jp>
References: <1502108577-8099-1-git-send-email-andr2000@gmail.com>
 <7e62a406-7dcd-b5c9-b2de-ea52e1d2afd0@sakamocchi.jp>
 <b9e34f0e-4a9a-9ccf-6165-04cd22a070ac@gmail.com>
 <CACvf2oU4puqSuNj2k5REpmFJdvWcTWY+AaNEJtknLP4XMPdbsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 2424326648D
 for <alsa-devel@alsa-project.org>; Fri, 18 Aug 2017 07:43:22 +0200 (CEST)
In-Reply-To: <CACvf2oU4puqSuNj2k5REpmFJdvWcTWY+AaNEJtknLP4XMPdbsg@mail.gmail.com>
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
To: Oleksandr Grytsov <al1img@gmail.com>, Oleksandr Andrushchenko <andr2000@gmail.com>, clemens@ladisch.de
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, alsa-devel@alsa-project.org, tiwai@suse.com, linux-kernel@vger.kernel.org, xen-devel@lists.xen.org
List-Id: alsa-devel@alsa-project.org

On Aug 17 2017 19:05, Oleksandr Grytsov wrote:
> So, from the above we think that period elapsed event derived in the described
> ways may not improve latency and will complicate the system. So, for that
> reason we are thinking of the option 2) (Positions of actual data transmission
> in any serial sound interfaces of actual hardwares.)

Please declare the way to enable stuffs on DomU to get the positions 
from actual hardware.


Regards

Takashi Sakamoto
