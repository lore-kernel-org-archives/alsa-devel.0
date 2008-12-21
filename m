From: naveenkrishna.ch <naveenkrishna.ch@gmail.com>
Subject: Re: patch 1/1: ASoC,
	DMA crash with application- resolved
Date: Sun, 21 Dec 2008 21:37:21 +0530
Message-ID: <ef0d8a250812210807h5fe861a0s5f62c4b728578022@mail.gmail.com>
References: <ef0d8a250812202322i3fe62ed2n2d1e09ab830e27dd@mail.gmail.com>
	<bd7b27490812210136m710dc896j43c060e14bc5fb4a@mail.gmail.com>
	<ef0d8a250812210138q3cad7dbay21611e2088a1525b@mail.gmail.com>
	<bd7b27490812210142q708842aai94a02f28d99cdf97@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by alsa0.perex.cz (Postfix) with ESMTP id D06CE24413
	for <alsa-devel@alsa-project.org>; Sun, 21 Dec 2008 17:07:22 +0100 (CET)
Received: by an-out-0708.google.com with SMTP id b2so538739ana.2
	for <alsa-devel@alsa-project.org>; Sun, 21 Dec 2008 08:07:21 -0800 (PST)
In-Reply-To: <bd7b27490812210142q708842aai94a02f28d99cdf97@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: tony@atomide.com, alsa-devel@alsa-project.org, jarkko.nikula@nokia.com
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 21, 2008 at 3:12 PM, Jarkko Nikula <jhnikula@gmail.com> wrote:

> On Sun, Dec 21, 2008 at 11:38 AM, naveenkrishna. ch <
> naveenkrishna.ch@gmail.com> wrote:
>
>>
>>
>>> This looks a bit familiar, I hope so. Is this from linux-omap, mainline
>>> or in-house kernel?
>>>
>> This is what i have seen in the alsa-kernel
>>
>>>
>>>
> Ok. Does it get fixed if you pick this second patch from linux-omap?

 To solve the DMA crashes i have sent a patch, it worked i dint found any
patches related to this issue,
I tried it on alsa kernel git...

commit 55502f74b56f609a84d8919b9b29390b2e0147ff
Author: Jarkko Nikula <jarkko.nikula@nokia.com>
Date:   Mon Aug 18 12:28:22 2008 +0300

    ARM: OMAP: DMA: Fix uninitialized channel flags

    This has similar symptoms than 66c23551b1b774e2be3c7bdf91c0ebf2c7a3519e
    where just omap_request_dma, omap_dma_link_lch and omap_dma_unlink_lch
    can cause incorrect dump_stack(). Here it can happen if channel has been
    used before and the channel flags variable holds old status.


Jarkko
>



-- 
Thanks,
keep smiling...
keep winning...

(: Naveen Krishna Ch :)
