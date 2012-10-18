From: Prasant J <pj0585@gmail.com>
Subject: Re: Interleaved or Non-interleaved?
Date: Thu, 18 Oct 2012 15:27:48 +0530
Message-ID: <CAA2DH4ttnAbxPCYBrNktbsAJS4zgBA5PG+qsD+r5cRLc6kMNiw@mail.gmail.com>
References: <CAA2DH4sexxhLRRZzA6_-nFbY2P+VBLXX_aqcb6u5=13NJAKTaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
 [209.85.217.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 5318F2652C8
 for <alsa-devel@alsa-project.org>; Thu, 18 Oct 2012 11:57:49 +0200 (CEST)
Received: by mail-lb0-f179.google.com with SMTP id c1so5273905lbg.38
 for <alsa-devel@alsa-project.org>; Thu, 18 Oct 2012 02:57:49 -0700 (PDT)
In-Reply-To: <CAA2DH4sexxhLRRZzA6_-nFbY2P+VBLXX_aqcb6u5=13NJAKTaQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 18, 2012 at 2:04 PM, Prasant J <pj0585@gmail.com> wrote:
> hi,
>
> My sound hardware supports only interleaved audio.
>
> I'm writing an alsa application. Which access method will be more
> performing : interleaved or non-interleaved? (Or it does not make a
> difference?)
>
> -Prasant

@Clemens:
What I wanted to know : right now my application is doing the audio
sample demux/separation (capture) & mux (playback), because I my
access method is interleaved. Will I get any performance benefit if I
access in non-interleaved method ad let alsa do the work?

-Prasant
