From: arun kumar <arun.esd@gmail.com>
Subject: Re: PCM substream
Date: Fri, 10 Aug 2012 10:16:15 +0530
Message-ID: <CABnBtVAg0QQVPxakC6+=uKtPocm3qYBMbC-01uHAsu-5Xyo36g@mail.gmail.com>
References: <CABnBtVCEP0z_2_1NaPyvMpq1C=6CM9fPcM=6znpjGMZaT8STNQ@mail.gmail.com>
 <CABnBtVDJQ_0nTLwfFrbMN1w16z7upNY3=ui1Oi1mZJmaHztiGQ@mail.gmail.com>
 <5023B1C3.40001@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 by alsa0.perex.cz (Postfix) with ESMTP id C38E32664A2
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 06:16:30 +0200 (CEST)
Received: by pbbro8 with SMTP id ro8so2051582pbb.38
 for <alsa-devel@alsa-project.org>; Thu, 09 Aug 2012 21:46:15 -0700 (PDT)
In-Reply-To: <5023B1C3.40001@ladisch.de>
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

Hi Clemens,

Thanks for the reply.So, if any application tries to open more than one
substream will it get the error? or alsa subsystem gives it one more
substream and helps in mixing of substreams considering my hardware has
only support for one substream.

regards,
Arun.
On Thu, Aug 9, 2012 at 6:19 PM, Clemens Ladisch <clemens@ladisch.de> wrote:

> arun kumar wrote:
> > From the last couple of days, I have been trying to understand the Linux
> > Alsa Subsystem.I have read the Alsa Driver API and Application API's.
> But I
> > could not understand the concept of PCM substreams,
>
> A PCM stream has one or more substreams.  Multiple substreams are used when
> the hardware can mix them together for one output.  This was used in old
> wavetable sound cards; nowadays, you almost always have one substream.
>
>
> Regards,
> Clemens
>
