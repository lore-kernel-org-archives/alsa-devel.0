From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: Re: [PATCH v2] sound: pci: asihpi: hpifunc.c: Remove
	some unused functions
Date: Wed, 31 Dec 2014 18:07:36 +0100
Message-ID: <CAKXHbyPEr+HOAXB8ibtpYidh_GVD0qAgcQK3A4kXpgVWgLbtQA@mail.gmail.com>
References: <1420039022-10018-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <s5h7fx7hkga.wl-tiwai@suse.de>
 <CAKXHbyOEp=juzjaqsNt9RXn02VYDJXvESK4o_vAhMtFGmK=dHA@mail.gmail.com>
 <s5hvbkrg44c.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f179.google.com (mail-ig0-f179.google.com
 [209.85.213.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 72C1A26042D
 for <alsa-devel@alsa-project.org>; Wed, 31 Dec 2014 18:07:38 +0100 (CET)
Received: by mail-ig0-f179.google.com with SMTP id r2so13978367igi.6
 for <alsa-devel@alsa-project.org>; Wed, 31 Dec 2014 09:07:37 -0800 (PST)
Received: from mail-ie0-f178.google.com (mail-ie0-f178.google.com.
 [209.85.223.178])
 by mx.google.com with ESMTPSA id r18sm20564248ioi.28.2014.12.31.09.07.36
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Wed, 31 Dec 2014 09:07:36 -0800 (PST)
Received: by mail-ie0-f178.google.com with SMTP id vy18so13342877iec.37
 for <alsa-devel@alsa-project.org>; Wed, 31 Dec 2014 09:07:36 -0800 (PST)
In-Reply-To: <s5hvbkrg44c.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, eliot@blennerhassett.gen.nz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

2014-12-31 17:45 GMT+01:00 Takashi Iwai <tiwai@suse.de>:

> At Wed, 31 Dec 2014 17:41:33 +0100,
> Rickard Strandqvist wrote:
> >
> > 2014-12-31 17:07 GMT+01:00 Takashi Iwai <tiwai@suse.de>:
> >
> > > At Wed, 31 Dec 2014 16:17:02 +0100,
> > > Rickard Strandqvist wrote:
> > > >
> > > > Removes some functions that are not used anywhere:
> > >
> > > See Eliot's previous reply.  There will be some code changes, so this
> > > action is no-go as of now.
> > >
> > >
> > > thanks,
> > >
> > > Takashi
> > >
> >
> >
> > Hi Takashi
> >
> > I have restored the function hpi_adapter_set_property() that Eliot
> wanted.
> > And I also have diff the files against the linux-next, but that there are
> > some notable differences.
> >
> > What is it you do not like about my current patch?
>
> More code changes may land in near future, so removing functions isn't
> good at all at this moment.  We need to wait until the all things are
> settled down.  IOW, forget about this for a while :)
>
> And please add Eliot to Cc at the next time.
>
>
> thanks,
>
> Takashi
>


+ Eliot

Hi

Strange, because I ask specifically if it was just one function Eliot objected
to, and I therefore could resend the patch.


Kind regards
Rickard Strandqvist
