From: Mina Almasry <almasrymina@google.com>
Subject: Re: Getting notification of sound card load
Date: Tue, 8 Sep 2015 17:28:44 -0700
Message-ID: <CAHS8izNgnWC2YyHp5=iAg5qFSW=4yQkb98ccr9Cuk4GP2dAZOA@mail.gmail.com>
References: <CAHS8izNFuofTe1Ud7Oa=L0RTtdT-KqnTdoO81ffMjDwH9RiyEQ@mail.gmail.com>
 <55EF1AC3.20000@spectralbird.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f172.google.com (mail-io0-f172.google.com
 [209.85.223.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 206342650F7
 for <alsa-devel@alsa-project.org>; Wed,  9 Sep 2015 02:28:46 +0200 (CEST)
Received: by iofb144 with SMTP id b144so4231305iof.1
 for <alsa-devel@alsa-project.org>; Tue, 08 Sep 2015 17:28:45 -0700 (PDT)
In-Reply-To: <55EF1AC3.20000@spectralbird.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Seeber <markus.seeber@spectralbird.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks,

Is there an alternative however? The reason I'm asking:

- I don't want to add libudev as a dependency.
- The kernel we're using has some CONFIGs turned off and I might have to
turn them on to mean libudev requirements and I would rather not do that
(if it's even possible).

Thanks,

Mina

On Tue, Sep 8, 2015 at 10:28 AM, Markus Seeber <
markus.seeber@spectralbird.de> wrote:

> On 09/08/2015 07:09 PM, Mina Almasry wrote:
> > Hi,
> >
> > I'd like to get a notification when a new sound card becomes available in
> > my system.
>
> You may have a look at udev, especially the monitoring interface of
> libudev.
>
> I don't know if this is outdated, but maybe have a look here:
> http://www.signal11.us/oss/udev/
>
> Best Regards,
>   Markus
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
