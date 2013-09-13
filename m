From: Rajaram R <rajaram.officemail@gmail.com>
Subject: Re: USB Audio/ALSA
Date: Fri, 13 Sep 2013 11:57:41 +0530
Message-ID: <CAOiXhaKctOMJDzR5hu-PBcK2Di1hZfDwTYnCRRRx5gBCjxTK7w@mail.gmail.com>
References: <CAOiXha+sn0okoKFN9Q-C0PLmP1EqServFfFLSHsJT-NCq1+z=w@mail.gmail.com>
 <52320097.7050309@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f172.google.com (mail-ve0-f172.google.com
 [209.85.128.172])
 by alsa0.perex.cz (Postfix) with ESMTP id A502B26080A
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 08:27:42 +0200 (CEST)
Received: by mail-ve0-f172.google.com with SMTP id oz11so665409veb.3
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2013 23:27:41 -0700 (PDT)
In-Reply-To: <52320097.7050309@ladisch.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 12, 2013 at 11:27 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
>
> Rajaram R wrote:
> > I am trying to bring up Android Accessory Audio
>
> There are lots of bugs in various accessory firmware version; you need
> kernel 3.10 or the latest stable kernel on the host for a workaround.
>
> > But when I play song, I see nothing on the bus.  I can see an AOA
> > audio device entry in /proc/asound/cards.
>
> The important thing is whether you see an entry with "arecord -l".
>
> > The error i see when I play is "Sorry this player does not support this
> > type of audio file android".
>
> Is that on the Android device?  In that case, this has nothing to do
> with ALSA.

Yes I understand it is nothing to do with ALSA. I hope to get
attention of ALSA guys who worked on Samsung grand/Android platform
who would have definitely faced this issue.

>
>
> Regards,
> Clemens
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
