From: Clemens Ladisch <cladisch@googlemail.com>
Subject: Re: [Alsa-user] How do I run arecord on raw digital
 mic buffer?
Date: Wed, 4 May 2016 10:21:32 +0200
Message-ID: <5729B10C.2050301@googlemail.com>
References: <CALAeOVPtQE3mHFPMP-48ADUJByp_b6vAo3vP8K53_edE=Hnakg@mail.gmail.com>
 <57286670.2060309@googlemail.com>
 <CALAeOVMVMi2qnx5CqtmVTUy2KK3GQFGDLJJUBzSb3U-K-pD_2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id D90F9260542
 for <alsa-devel@alsa-project.org>; Wed,  4 May 2016 10:21:36 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id n129so8881219wmn.1
 for <alsa-devel@alsa-project.org>; Wed, 04 May 2016 01:21:36 -0700 (PDT)
In-Reply-To: <CALAeOVMVMi2qnx5CqtmVTUy2KK3GQFGDLJJUBzSb3U-K-pD_2A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Nertney <rob@rob-otics.com>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Rob Nertney wrote:
>>> is the best method to build a sound card and a capture PCM?
>>
>> As compared to what?  Any other method will not allow your hardware to
>> be used for audio recording.
>
> As compared to my driver configuring the DMA to capture the data into
> a known buffer, and then directly accessing the buffer to wrap it in
> a WAV format. I should have rephrased my initial question as, "my goal
> is to simply wrap multichannel digital mic input in WAV format; is
> ALSA/arecord the most efficient way to do this?"

If you bypass ALSA, you have to write all the software yourself, and you
will not be able to use your hardware for anything else.

> I should make my buffer at least 2x the size of a period.

Yes.  (You don't need periods if you don't use interrupts to wait for
data being available.)

> I have a buffer ready, under which function does it get passed back to
> the ALSA framework?

Normally, ALSA knows about the buffer, and the driver just reports the
current position.

>   * dma completes/fires period-based IRQ
>   * <<question>> buffer is transferred in function X (?) to Y (?)

When a period is finished, you must call snd_pcm_period_elapsed().

ALSA will then call your .pointer callback to know where in the buffer
the hardware has finished writing.  (Please not that .pointer can also
be called at other times.)


Regards,
Clemens
