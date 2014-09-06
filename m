From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: How to properly handle variable samplerate?
Date: Sat, 06 Sep 2014 16:33:06 +0600
Message-ID: <540AE2E2.3050000@gmail.com>
References: <5409E2DA.2090403@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f41.google.com (mail-la0-f41.google.com
 [209.85.215.41])
 by alsa0.perex.cz (Postfix) with ESMTP id EC547264F09
 for <alsa-devel@alsa-project.org>; Sat,  6 Sep 2014 12:33:08 +0200 (CEST)
Received: by mail-la0-f41.google.com with SMTP id s18so4053926lam.14
 for <alsa-devel@alsa-project.org>; Sat, 06 Sep 2014 03:33:08 -0700 (PDT)
In-Reply-To: <5409E2DA.2090403@barix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <petr@barix.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

05.09.2014 22:20, Petr Kulhavy wrote:
> Hi,
>
> I'm developing an audio stream player application with ALSA output, the
> player has a large software buffer. The trouble is that the stream can
> potentially change the sampling rate (e.g. streaming RTP from a VLC
> playlist created from different MP3 songs). How to properly handle this?
>
> I'm thinking of the following concept:
> The codec feeds data into the software buffer together with markers for
> sample rate changes. The ALSA playback is asynchronous, using a callback
> function feeding the data from the software buffer into ALSA. If a
> samplerate marker is hit the new rate is set.
>
> Can the sample rate be set from a callback? What other constraints are
> there? And how does the HW FIFO handle samplerate changes?
> Or is there a better way of implementing?

ALSA does not support variable sample rate at all. So you either have to 
do the variable-rate resampling yourself in your player, or depend on 
PulseAudio which does support this feature.

-- 
Alexander E. Patrakov
