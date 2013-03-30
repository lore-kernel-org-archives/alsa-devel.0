From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: [PATCH] salsa-lib: Fix error on jack compilation
 with	salsa
Date: Sat, 30 Mar 2013 12:11:27 -0700
Message-ID: <515738DF.3040301@gmail.com>
References: <CAD-m0i9iOmziNL=d0xGaVhb-mj-YjpeHBaitDHUYEgp7yQ5BDw@mail.gmail.com>
 <s5hr4jagh8v.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f42.google.com (mail-pb0-f42.google.com
 [209.85.160.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FF2026164B
 for <alsa-devel@alsa-project.org>; Sat, 30 Mar 2013 20:11:46 +0100 (CET)
Received: by mail-pb0-f42.google.com with SMTP id xb4so651646pbc.15
 for <alsa-devel@alsa-project.org>; Sat, 30 Mar 2013 12:11:45 -0700 (PDT)
In-Reply-To: <s5hr4jagh8v.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mihail Zenkov <mihail.zenkov@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/20/2013 09:37 AM, Takashi Iwai wrote:
> At Sun, 17 Mar 2013 15:13:00 +0000,
> Mihail Zenkov wrote:
>>
>> Fix error on jack compilation with salsa:
>> /usr/include/alsa/ctl_macros.h:251:48: error: invalid conversion from
>> 'void*' to 'snd_ctl_elem_id_t* {aka snd_ctl_elem_id*}' [-fpermissive]
>
> I don't get it.  Is it C++?  But I thought the code is in extern "C"
> region?

Yes, it's C++.  'extern "C"' only declares the linkage convention.  It 
does not affect casting rules/conventions.

-gabriel
