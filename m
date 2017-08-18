From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [PATCH RESEND1 00/12] ALSA: vsnd: Add Xen
 para-virtualized frontend driver
Date: Fri, 18 Aug 2017 10:23:05 +0300
Message-ID: <b129960e-b38f-ea94-3e4a-3cd409f7a707@gmail.com>
References: <1502108577-8099-1-git-send-email-andr2000@gmail.com>
 <7e62a406-7dcd-b5c9-b2de-ea52e1d2afd0@sakamocchi.jp>
 <b9e34f0e-4a9a-9ccf-6165-04cd22a070ac@gmail.com>
 <CACvf2oU4puqSuNj2k5REpmFJdvWcTWY+AaNEJtknLP4XMPdbsg@mail.gmail.com>
 <e5d52c8a-09e0-2823-dcff-e595868c7dee@sakamocchi.jp>
 <2a2fd222-fc54-1709-bfc8-a530efc3f307@gmail.com>
 <ad4f2201-bfab-415d-0120-308989653628@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f67.google.com (mail-lf0-f67.google.com
 [209.85.215.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 37663266884
 for <alsa-devel@alsa-project.org>; Fri, 18 Aug 2017 09:23:14 +0200 (CEST)
Received: by mail-lf0-f67.google.com with SMTP id x16so5736352lfb.4
 for <alsa-devel@alsa-project.org>; Fri, 18 Aug 2017 00:23:14 -0700 (PDT)
In-Reply-To: <ad4f2201-bfab-415d-0120-308989653628@sakamocchi.jp>
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
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, Oleksandr Grytsov <al1img@gmail.com>, clemens@ladisch.de
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, alsa-devel@alsa-project.org, tiwai@suse.com, linux-kernel@vger.kernel.org, xen-devel@lists.xen.org
List-Id: alsa-devel@alsa-project.org


On 08/18/2017 10:17 AM, Takashi Sakamoto wrote:
> On Aug 18 2017 14:56, Oleksandr Andrushchenko wrote:
>> Taking into account the fact that the backend we have is a user-space 
>> application
>> running on top of ALSA/PulseAudio we cannot get HW pointers from actual
>> hardware by any means (PulseAudio use-case is the most tough thing in 
>> equation)
>
> You mean that any alsa-lib or libpulse applications run on Dom0 as a
> backend driver for the frontend driver on DomU?
>
No, the sound backend [1] is a user-space application (ALSA/PulseAudio 
client)
which runs as a Xen para-virtual backend in Dom0 and serves all the
frontends running in DomU(s).
Other ALSA/PulseAudio clients in Dom0 are also allowed to run at the
same time.
>
> Regards
>
> Takashi Sakamoto
Thank you,
Oleksandr

[1] https://github.com/xen-troops/snd_be
