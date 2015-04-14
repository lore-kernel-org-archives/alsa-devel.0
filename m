From: "Johannes Lorenz" <johannes89@mailueberfall.de>
Subject: Re: parallel, real time safe waiting?
Date: Tue, 14 Apr 2015 20:39:21 +0200
Message-ID: <trinity-2fe2e26e-7e13-48a5-90f7-959800b5d1ed-1429036761827@3capp-gmx-bs63>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 44A64265050
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2015 20:39:22 +0200 (CEST)
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

> >   1.) Let each thread open a handle using snd_seq_open()
> >   2.) Call snd_pcm_wait() in each thread
> > 
> > Are these functions
> > 
> >   a) real time safe?
> 
> snd_seq_open() is not, but why would that matter?
> Don't you call it from the GUI thread?

Ah, indeed, seq_open() is part of the initialization, so for this one, it does not matter.

> >   b) race-condition free, assuming I'll use pairwise different handles
> >   each thread
> Yes.

You're really 100 percent sure that this is guaranteed to work? Sorry for asking this :) I was expecting a "No, of course not.".

Also, this will probably work for all handle-based-functions, as long as you keep using pairwise different handles?

Regards,
Johannes
