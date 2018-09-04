From: Mark Farrugia <mark.farrugia@fiberdyne.com.au>
Subject: Re: Possibility of routing at the kernel level
Date: Tue, 4 Sep 2018 10:39:10 +1000
Message-ID: <CAPWhKM=AkNqkYGY3vs6N4dq80=fGEOuGEmJVLZj2ufO0MmBeDw@mail.gmail.com>
References: <CAPWhKMn_4SukFcaLEMGTa8R70c3q0VjufvnFzFeMg=Gpn+T9AA@mail.gmail.com>
 <CAPWhKM=qtg9knqFBdG9167GJg3Q=kpzudzk95pLCTX9nYpPTFg@mail.gmail.com>
 <s5hftyqhh0j.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f66.google.com (mail-it0-f66.google.com
 [209.85.214.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D139267668
 for <alsa-devel@alsa-project.org>; Tue,  4 Sep 2018 02:39:22 +0200 (CEST)
Received: by mail-it0-f66.google.com with SMTP id 139-v6so2765637itf.0
 for <alsa-devel@alsa-project.org>; Mon, 03 Sep 2018 17:39:22 -0700 (PDT)
In-Reply-To: <s5hftyqhh0j.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org, Tharindu De Silva <Tharindu.DeSilva@fiberdyne.com.au>, Fulup Ar Foll <fulup.arfoll@iot.bzh>, James O'Shannessy <James.OShannessy@fiberdyne.com.au>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 3, 2018 at 11:01 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 27 Aug 2018 07:57:00 +0200,
> Mark Farrugia wrote:
> >
> > Hi all,
> >
> > Following my initial proposition on Friday for kernel-space audio
> > routing, we at Fiberdyne Systems have since published our initial
> > source for such a solution, which we are calling ALSA Virtual Driver,
> > or simply AVIRT.
> >
> > Please find the source here for your perusal:
> > https://github.com/fiberdyne/avirt
> >
> > Currently we use module parameters for the kernel module, however, we
> > will be porting configuration to another system, such as
> > configfs/sysfs.
> >
> > We are completely open to suggestions and constructive criticism.
>
> Did you try snd-aloop driver?  I'm not advocating it (as it doesn't
> mean a better latency), but it's often an option.
>
>
> thanks,
>
> Takashi

We have tried snd-aloop, and this would otherwise be our adopted
solution, if not for the following issues:
1. The latency involved when looping back to user-space. We would
prefer to avoid unnecessary latency altogether if possible.
2. We wish to hold each input in a different SMACK security context -
aloop does not give a PCM device per input, but rather one PCM device,
with a substream per input. This is an issue since SMACK can only
apply one label per PCM device.
3. We want to dynamically construct the sound card PCM devices based
on user configuration.
