From: Nick Stoughton <nstoughton@aether.com>
Subject: [RFC] provide a simple mechanism to start playback at
	a given time
Date: Tue, 14 Oct 2014 16:31:27 +0200
Message-ID: <CADO7NSF=uneov2a9MShswbmpu1P=cwZ1dSkA-jJvoCvxsTFT3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f49.google.com (mail-la0-f49.google.com
 [209.85.215.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 220DE26069F
 for <alsa-devel@alsa-project.org>; Tue, 14 Oct 2014 16:31:28 +0200 (CEST)
Received: by mail-la0-f49.google.com with SMTP id q1so8665357lam.36
 for <alsa-devel@alsa-project.org>; Tue, 14 Oct 2014 07:31:27 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

As discussed at today's meeting, please find 2 patches (one to the 3.17
kernel, the other to alsa-lib) following this that implement a simple
interface to trigger playback at a given point in the future.

The API provides an absolute time, measured against a given clock, at which
to trigger DMA. If the point in the future appears to be less than 100ms
away, we fall back to the standard snd_pcm_start() behavior. This is
because this interface is designed to support networked devices
playing back in sync, and network latencies are likely to be over 100ms.
This value should probably be tunable ...

Also, we simply set up a timer and commence DMA when it expires. If the
devices to be synchronized have identical hardware, then there is no
problem. A future enhancement is to estimate the latency between the DMA
trigger and the codec driver (FIFO sizes etc) so that we can take that into
account.

Any comments gratefully accepted!
*______________________________*
*Nick Stoughton*
 *Aether Things Inc *
 *San Francisco*
  +1 (510) 388 1413
