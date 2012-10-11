From: kartik natarajan <kartik8n8@gmail.com>
Subject: Re: Arecord issue
Date: Thu, 11 Oct 2012 20:14:41 +0530
Message-ID: <CAAe3XR37zm=JBX+14RKSn28=xKcwnvx=dp9zBBw3u0dtn2w5bw@mail.gmail.com>
References: <CAAe3XR3rDQb4U8EUq5COCHH5oAtXR2tVcFROBVTN0rsZvJdt+Q@mail.gmail.com>
 <5076C46E.5070009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
 [209.85.223.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 170D4265176
 for <alsa-devel@alsa-project.org>; Thu, 11 Oct 2012 16:44:42 +0200 (CEST)
Received: by mail-ie0-f179.google.com with SMTP id c10so2970148ieb.38
 for <alsa-devel@alsa-project.org>; Thu, 11 Oct 2012 07:44:42 -0700 (PDT)
In-Reply-To: <5076C46E.5070009@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks!
          At about the same time I check the behaviour on the oscilloscope
and inferred the same that there is no clock on the bus when arecord is
executed.
A little digging further, I see that the codec chip is set to master in
both cases, aplay and arecord. But somehow it drives the clock in the
former case and not in the other.
So this problem is not related to either of aplay/ arecord but more of the
PCM level behaviour, as it is at this level the master for the bus is
decided.
I'll get back with any information I get on this.
Your mail has just made my findings easier. Thanks again.


On Thu, Oct 11, 2012 at 6:36 PM, Daniel Mack <zonque@gmail.com> wrote:

> On 11.10.2012 14:54, kartik natarajan wrote:
> >     I am working on a 2.6.37 kernel and on a DM365 davinci board with a
> > tlv320aic3254 audio codec (i2c control lines, i2s data transfer)
> > I wanted to get the audio up on my board so got the alsa-lib and
> alsa-utils
> > 1.0.25 compiled them and got the aplay to work fine.
> > When I got to working on the arecord things haven't worked fine. I have
> > traced all the calls and have reached so far;
> > codec gets set properly
> > davinci_pcm_trigger executes with success
> > snd_pcm_sw_params() executes successfully.
> > aplay calls begin_wave()
> > aplay calls pcm_read() that invokes  snd_pcm_readi()
> > Finally my app seems to not go beyond the snd_pcm_start()
>
> I've been working on a custom AM33xx boards lately which features the
> same digital audio interface than the Davincis do.
>
> I've been running into similar issues when I tested the recording
> channels, and hooking up a logic analyzer showed that the clocks were
> not driven by the CPU. That causes the DMA engine not receive any
> samples (as the frame and bit clocks are missing), which will eventually
> lead to a timeout.
>
> This issue was worked around for now by starting the playback first and
> then the record. Unfortunately though, a simply "arecord | aplay" does
> not suffice, as aplay won't start before it received any samples from
> its input side, so you have a deadlock here.
>
> So I wrote a very simple test tool in order to prove that the overall
> system is working and published it here:
>
>   https://github.com/zonque/simple-alsa-loop
>
> For the application of this board I'm working on, there's no case where
> we would record anything but not use the output, so this workaround will
> do for me. If you have other requirements, you might need to dig deeper.
> Note that the driver has seem quite some refactorization in 3.7.
>
>
> Daniel
>
>


-- 
Believe in your dreams, they have a strange way of coming true!!!
