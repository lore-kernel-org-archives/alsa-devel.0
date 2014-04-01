From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Invalid PCM pointer with CMI8738 and pcm.c buffer
	underuns
Date: Wed, 2 Apr 2014 06:58:56 +0800
Message-ID: <CAN8cciZpK4Opd7LAKg1quBYxKyD7+U3KhHXhFxJ4Ty+6AiGPaw@mail.gmail.com>
References: <CAAvHfitJ2B1sr7_6h=ww_SVGgsuy4iNLGc3CjDyiNtwdpJTSUw@mail.gmail.com>
 <533AA4F9.4040508@ladisch.de>
 <loom.20140401T193432-364@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f46.google.com (mail-qa0-f46.google.com
 [209.85.216.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C83C265482
 for <alsa-devel@alsa-project.org>; Wed,  2 Apr 2014 00:58:58 +0200 (CEST)
Received: by mail-qa0-f46.google.com with SMTP id i13so10132633qae.19
 for <alsa-devel@alsa-project.org>; Tue, 01 Apr 2014 15:58:57 -0700 (PDT)
In-Reply-To: <loom.20140401T193432-364@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: andoru <andoru.blah@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
> >
> > Andoru wrote:
> > > The last time you replied you said that it's a hardware error. If it
> > > is that way then how come the card otherwise works flawlessly in
> > > Windows, and this doesn't happen on Debian when watching videos or
> > > with certain programs?

The Linux driver seem sharing two Dma channels with at least two playback
devices and capture device

The logic seem allow

front and rear playing different audio but no capture
Multi channel playback but no capture

open three terminals and try different combination of

speaker-test -c2 -t wav -D front

speaker-test -c2 -t wav -D rear

arecord -f dat -D plughw:0,0

speaker-test -c4 -t wav -D surround40

speaker-test -c6 -t wav -D surround51
