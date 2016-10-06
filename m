From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Audio on mx6q udoo
Date: Thu, 6 Oct 2016 19:59:17 -0300
Message-ID: <CAOMZO5DPCBquq3m61nxvjaQ0=Lg9wsytn4aW_+YF89cbd5dCYA@mail.gmail.com>
References: <CAOMZO5DdwgYBbOG7sik-Wc34zEqfttOc3EZwsisFgzwtcbDPNA@mail.gmail.com>
 <57F6644F.3070500@maciej.szmigiero.name>
 <CAOMZO5DtJG6Otw8rfZQQymsoZJ4UhB2idgDCXgWN69OMyQc_Ww@mail.gmail.com>
 <57F6D452.3020306@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f180.google.com (mail-ua0-f180.google.com
 [209.85.217.180])
 by alsa0.perex.cz (Postfix) with ESMTP id C49A3266ABC
 for <alsa-devel@alsa-project.org>; Fri,  7 Oct 2016 00:59:19 +0200 (CEST)
Received: by mail-ua0-f180.google.com with SMTP id r64so31241779uar.3
 for <alsa-devel@alsa-project.org>; Thu, 06 Oct 2016 15:59:19 -0700 (PDT)
In-Reply-To: <57F6D452.3020306@maciej.szmigiero.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Maciej,

On Thu, Oct 6, 2016 at 7:46 PM, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:

> On kernel 4.7.6:
> 1) Vanilla kernel - AC'97 codec misdetected, no sound.
>
> 2) After applying
> "regmap: cache: Fix num_reg_defaults computation from reg_defaults_raw"
> (commit b2c7f5d9c939a37c1ce7f86a642de70e3033ee9e) the codec is
> detected properly and the sound is output properly.

Just applied this patch against 4.7.6 and still get no audio. Also put
the volumes to the maximum in alsamixer.

> However, since this commit is present in linux-next it can't
> explain why you aren't getting any sound there.

Yes, I was not able to get mainline to output sound on my udoo board yet.

Thanks
