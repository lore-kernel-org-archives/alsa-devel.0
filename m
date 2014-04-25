From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [PATCH v2] Fix forward/rewind support in iec958
 plugin
Date: Fri, 25 Apr 2014 12:00:03 +0600
Message-ID: <5359F9E3.10107@gmail.com>
References: <5358F356.3020701@canonical.com>	<1398350406-10347-1-git-send-email-patrakov@gmail.com>
 <CAN8cciadq+=36DcMufwDD=M5=0EAdnkUxPv8b9Ga5JHWqg1-Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f170.google.com (mail-lb0-f170.google.com
 [209.85.217.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 31A25260851
 for <alsa-devel@alsa-project.org>; Fri, 25 Apr 2014 08:03:06 +0200 (CEST)
Received: by mail-lb0-f170.google.com with SMTP id s7so2757542lbd.29
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 23:03:05 -0700 (PDT)
In-Reply-To: <CAN8cciadq+=36DcMufwDD=M5=0EAdnkUxPv8b9Ga5JHWqg1-Hg@mail.gmail.com>
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
Cc: Raymond Yau <superquad.vortex2@gmail.com>, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

25.04.2014 05:02, Raymond Yau wrote:
>
>
> >
> > When forwarding or rewinding, the frame counter was not updated. This
> > could result in corrupted channel status words or misplaced Z-type
> > preamble.
>
> Do you mean it is the responsibility for a52 and dca plugin to return 
> the SAFE value returned by snd_pcm_rewindable and snd_pcm_forwardable 
> since they enocde the audio and padding zeros and write to IEC958 ?
>

Sorry, I don't understand the question, please reask differently if I am 
answering something else than what you mean here.

Neither a52 nor dca plugins use seeking under normal operation (when 
they themselves are not being seeked), they just write zeros when needed 
due to the IEC 61937-5 wrapping. Their implementations are in fact not 
seekable (they only pretend), and I will e-mail patches that enforce this.

What I mean in the patch is the following scenario involving an 
application that writes stereo data directly to the iec958 plugin.

1. Write 1920 samples.
2. Rewind 1919 samples.
3. Write 1919 samples.

Let's suppose that the counter was 0 initially, and the application 
pointer points at sample 0. Then, while encoding this to iec958 
subframes, the plugin would start the preamble sequence with Z. Result: 
ZYXYXYXYXY... in the output buffer after step 1. Z repeats every 192 
frames, as required by the standard. And the first subframe (with Z) now 
contains the first bit of the first status word. After writing 1920 
samples, the counter is still at 0, because it counts modulo 192.

After step 2, the application pointer points at sample 1, but the 
counter is 0 in the unpatched version and 1 in the patched one.

After step 3, the unpatched version writes the Z preamble and the first 
bit of the first status word. Result: ZYZYXYXYXY... The patched version 
writes the second bit of the first status word, i.e. just what should be 
in the buffer. Also, it puts the X preamble. Result: ZYXYXYXYXY..., just 
what there should be.

So, after the patch, the iec958 plugin properly supports arbitrary 
seeking, just like a normal hardware device, and should be just as 
usable by hypothetical seekable versions of the a52 and dca plugins.

-- 
Alexander E. Patrakov
