From: Tom Yan <tom.ty89@gmail.com>
Subject: Re: [PATCH 1/1] ALSA: virtuoso: add de-emphasis control
Date: Thu, 20 Dec 2018 02:46:33 +0800
Message-ID: <CAGnHSEmjq1wnb0-5pBkKQYX77fRGw7akdu1z+t8s6ajkyQAofQ@mail.gmail.com>
References: <6b7d5f70-5e5a-59b4-9daf-315937a49639@ladisch.de>
 <5c16909a.1c69fb81.2150c.9583@mx.google.com>
 <bab819ed-38a4-dd8f-5505-663539b80d20@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 54D482677C8
 for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2018 19:46:44 +0100 (CET)
Received: by mail-ed1-f50.google.com with SMTP id b14so17834512edt.6
 for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2018 10:46:44 -0800 (PST)
In-Reply-To: <bab819ed-38a4-dd8f-5505-663539b80d20@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Considering with my patch this is the only remaining usage of it, do
you think I should just change it into "PCM1796_DME_DISABLED" and keep
this manner (so that it is consistent with rolloff_get() /
PCM1796_FLT_SHARP)?
Or do you insist that I should use !! anyway?

On Thu, 20 Dec 2018 at 02:00, Clemens Ladisch <clemens@ladisch.de> wrote:
>
> tom.ty89@gmail.com wrote:
> > +             (data->pcm1796_regs[0][18 - PCM1796_REG_BASE] &
> > +              PCM1796_DME) != PCM1796_DMF_DISABLED;
>
> DME and DMF are different fields.  Just use !!.
>
> With this fixed:
> Acked-by: Clemens Ladisch <clemens@ladisch.de>
>
>
> Regards,
> Clemens
