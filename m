From: Jamey Drennan <jamey.drennan@gmail.com>
Subject: VOIP xrun problem
Date: Mon, 22 Oct 2012 16:40:15 -0400
Message-ID: <CAJqUV39Mg8+Cd_ogFGL1vjagwpmBYCC+avWkQaBtPpQz0zZkTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f179.google.com (mail-vc0-f179.google.com
 [209.85.220.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 68AE2265265
 for <alsa-devel@alsa-project.org>; Mon, 22 Oct 2012 22:40:16 +0200 (CEST)
Received: by mail-vc0-f179.google.com with SMTP id f13so3240766vcb.38
 for <alsa-devel@alsa-project.org>; Mon, 22 Oct 2012 13:40:15 -0700 (PDT)
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

A quick background:  I'm developing a VOIP program for an embedded system.
In the first phase of the program everything was event driven.  Basically
ask ALSA for samples, encode them, and send them via UDP to the connected
client.  On the other end, receive the packet, decode, play the samples.
After setting the correct value for the start_threshold function everything
worked great no xruns at all.
Now in the second phase, events are timed due to specification
requirements.  The same Alsa setup code is used yet xruns (mostly
underruns) are all over the place.  The underruns are periodic and can be
reduced by increasing the period size and number of periods (this also
increases the latency obviously and is undersirable) but never removed
completely.

My question is how to reduce/remove the xruns.  I am not currently at a
point where installing a real-time OS or patching to get these features is
possible.  Also, when aplay/arecord is run on the system, no xruns occur.
Finally, the CPU is not being overloaded, actually in the second phase the
CPU usage is much less.  Any help/suggestions are greatly appreciated.
Thanks in advance!
