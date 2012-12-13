From: Devin Anderson <surfacepatterns@gmail.com>
Subject: Polling issues with the PCM multi plugin
Date: Wed, 12 Dec 2012 21:57:56 -0800
Message-ID: <CAG7zqTqPaLWy-1kN_4pbpbNTL4jAaEnDn6p-OT+-xsrFffpvjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
 [209.85.212.169])
 by alsa0.perex.cz (Postfix) with ESMTP id A24472615E6
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2012 06:57:56 +0100 (CET)
Received: by mail-wi0-f169.google.com with SMTP id hq12so3611310wib.2
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2012 21:57:56 -0800 (PST)
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

Hi all,

On the jack-devel list, we've been having a discussion about the ALSA
PCM multi plugin:

    http://thread.gmane.org/gmane.comp.audio.jackit/26571/focus=26571

I've been having some issues with setting up my 2 Echo Layla 3Gs as a
PCM multi.  In particular, I've found that there are times when
polling the file descriptors of the multi when poll() returns, but
there isn't actually a period of data available for capture/playback,
even though the poll descriptors indicate that the data should be
available.  After some debugging and learning about the PCM multi
driver:

1.) The PCM multi driver only returns poll descriptors for one of the
devices that makes up the multi
2.) When this happens, the device that's actually being polled *does*
have data available
3.) When this happens, the device that's not being polled does not yet
have a period's worth of data available

After making sure that I had word clock enabled and that my word clock
cable was working properly, I started delving into the problem some
more.  From what I can gather, the PCM multi device uses the function
`snd_pcm_link()` to sync its devices, and, for start, stop, drain,
pause, suspend, resume, reset, and prepare operations, this appears to
work fine; however, I can't find any evidence that a PCM device checks
to make sure that all of its linked slave devices have their poll
descriptors ready with events before indicating that events are
available.

Questions:

1.) Should `snd_pcm_link` make I/O availability indication dependent
on I/O availability of its linked slave devices?
2.) If not, how should this operation be handled?  I'm sure it *can*
be handled in userspace by bypassing the multi and polling the file
descriptors of all sound cards directly, but duplicating this code for
each application that wants to poll multiple sound cards seems wrong.

Thanks,

-- 
Devin Anderson
surfacepatterns (at) gmail (dot) com

blog - http://surfacepatterns.blogspot.com/
psinsights - http://psinsights.googlecode.com/
synthclone - http://synthclone.googlecode.com/
