From: Alex Wiggins <alex.d.wiggins@gmail.com>
Subject: Re: [PATCH - oss plugin update revised 1/2] oss: Add
 support of 32-bit and other formats
Date: Sun, 30 Jun 2013 09:03:35 +0100
Message-ID: <CACwMDQqZn=Pq50OV4H1+pzaWTsaw6+99TU7QjCowCCUpMAxpzw@mail.gmail.com>
References: <51cf8030.0867b40a.36ac.ffffad56@mx.google.com>
 <CAN8cciZ_FXDDJn-yLba0kDfKno-pZhhxhGVfjoXkHDEH7TxOTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f44.google.com (mail-la0-f44.google.com
 [209.85.215.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 61548261AC1
 for <alsa-devel@alsa-project.org>; Sun, 30 Jun 2013 10:03:36 +0200 (CEST)
Received: by mail-la0-f44.google.com with SMTP id er20so3474749lab.17
 for <alsa-devel@alsa-project.org>; Sun, 30 Jun 2013 01:03:35 -0700 (PDT)
In-Reply-To: <CAN8cciZ_FXDDJn-yLba0kDfKno-pZhhxhGVfjoXkHDEH7TxOTQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This part of the patch (oss plugin update revised 1/2) allows OSS emulation
to work with audio formats other than 8-bit and 16-bit. Specifically, it
allows this OSS emulation plugin to play 24-bit and 32-bit hires audio
(provided that the OSS driver / soundcard supports it).

The other part of the patch (oss plugin update revised 2/2) allows the user
to set the OSS buffer / period size config via the ALSA conf file. This was
found to be useful during testing to improve performance (without setting
this the default chosen values caused occasional empty buffer glitches, by
choosing more optimal values these glitches were removed). The previous
default behaviour (restrict to period size of power of 2) can be reinstated
by setting period_size to negative. The new default behaviour is to query
this period_size from OSS (and also check if it is a power of 2). Finally
the user is able to force the period_size, periods and buffer_size (to any
value) by specifying the variables in the ALSA conf file.



On 30 June 2013 02:13, Raymond Yau <superquad.vortex2@gmail.com> wrote:

> >
> > Added support of 32-bit and other audio formats via 3 changes:
> >
> >  - Additional audio format definitions
> >    at the top of the file (if required);
> >
> >  - Additional audio formats in oss_hw_params
> >    (to allow as input to pass to OSS);
> >
> >  - Additional audio formats in oss_hw_constraint
> >    (to allow to report to ALSA).
> >
> > Signed-off-by: Alex Wiggins <alex.d.wiggins@gmail.com>
> >
>
> Do you mean that this patch allow  OSS 4.0 enumlation if period size other
> than power 2 is supported ?
>
