From: Trent Reed <treed0803@gmail.com>
Subject: Re: SND_PCM_STREAM_CAPTURE and SND_PCM_NONBLOCK
	producing strange artifacts
Date: Sat, 2 Jul 2016 14:58:28 -0700
Message-ID: <CAL6pMWqXvZk0ZSQ+rPNRxjA5h8QT6nU_-NT_Gqh2AMUwjRGqJQ@mail.gmail.com>
References: <CAL6pMWpW4VMPkaeqUS3DaU4d+fUB2s1i9kpTPkfNPeNjW4gHpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f169.google.com (mail-qk0-f169.google.com
 [209.85.220.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E1C8265326
 for <alsa-devel@alsa-project.org>; Sat,  2 Jul 2016 23:58:31 +0200 (CEST)
Received: by mail-qk0-f169.google.com with SMTP id t127so241097865qkf.1
 for <alsa-devel@alsa-project.org>; Sat, 02 Jul 2016 14:58:31 -0700 (PDT)
In-Reply-To: <CAL6pMWpW4VMPkaeqUS3DaU4d+fUB2s1i9kpTPkfNPeNjW4gHpQ@mail.gmail.com>
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

(Ping)

I'm afraid I still don't understand why this is failing. I found that a
call to sdn_pcm_wait() when -EAGAIN is returned fixes the problem because
it waits for samples to be ready, but I don't understand why it is a
problem in the first place. Much of the sample code is written in a way
that suggests that the call to snd_pcm_wait() is optional, and only
required when directly reading/writing from the device (MMAP, I'm not doing
this).

I'm just wondering what is wrong with basically looping over a call to
snd_pcm_readi() in non-blocking mode, reacting to errors, and capturing
frames. This produces awful static (which is basically garbage samples), is
it a requirement that I call snd_pcm_wait() when -EAGAIN is passed back to
wait for a full period to be ready?

Thanks,
- Trent Reed


On Tue, Jun 28, 2016 at 7:27 PM, Trent Reed <treed0803@gmail.com> wrote:

> Hey All,
>
> I've been banging my head against the wall for about a week on this bug.
> The following gist shows my sample reproduction code:
> https://gist.github.com/TReed0803/985c5d5c3d295245e19006a27be447c3
>
> I'm simply opening up a non-blocking PCM capture stream and writing the
> contents of the reads to stdout.
> (Originally, I was writing to the playback stream, but I was hearing this
> strange static occasionally!)
>
> It's the static I'm trying to debug. It doesn't happen every time. In
> fact, sometimes I'll go a few consecutive executions without hearing it.
> I was able to capture some of the bad data, and I loaded it up in Audacity
> for visualization:
>
> https://drive.google.com/file/d/0B-1aumGKQcQTcUJoZzIwRWhYSFE/view?usp=sharing
>
> It looks like the internal buffer occasionally is sending me more data
> than it actually captured, and I end up either reading old PCM data from
> the internal ring buffer, or (at the very beginning) a bunch of zeros.
>
> Can anyone help me understand what is going on? What could cause these
> definitely incorrect samples to be recorded? (I get the same effect
> regardless of hardware, but I will list hardware just in case.)
>
> I hope I have all the information you might need:
> Hardware: Samson Meteor Mic (USB-Audio, USB Mixer) [Though, it even
> happens with my built-in microphone]
> ALSA version: Advanced Linux Sound Architecture Driver Version
> k4.4.0-28-generic.
> apt-cache policy (installed alsa-lib version): 1.1.0-0ubuntu1
>
> Thanks,
> - Trent Reed
>
