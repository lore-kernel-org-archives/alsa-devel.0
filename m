From: bruce <brucep@netspace.net.au>
Subject: Re: Can't get capturing from RME Hammerfall MADI card
 to work: sound loops & silcence
Date: Fri, 27 Sep 2013 17:07:07 +1000
Message-ID: <CAGqxWvJQPFd_v_iN0eyVG1qCCUxeYpcOP0YU961Gn2JGdN3RgA@mail.gmail.com>
References: <CANYi0v7OD_AFC9-jFeH4MGLZQGsPX91S5NdjqDsmZ_9pOR0hPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f41.google.com (mail-vb0-f41.google.com
 [209.85.212.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B36726501B
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 09:07:07 +0200 (CEST)
Received: by mail-vb0-f41.google.com with SMTP id g17so1579620vbg.14
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 00:07:07 -0700 (PDT)
In-Reply-To: <CANYi0v7OD_AFC9-jFeH4MGLZQGsPX91S5NdjqDsmZ_9pOR0hPg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Niels Laukens <niels.laukens@innovatie.vrt.be>, alsa-devel@alsa-project.org, Andrew Martin <vk3oe@bigpond.com>
List-Id: alsa-devel@alsa-project.org

Hi Niels,

Similar issues here, but can add it all seems to work absolutely fine with
alsa 1.0.15, but fails with 1.0.18+.
Alsamixer must be used to setup the card and Madi.
96k sampling also works if you set the madi into double-speed mode (on the
older alsa).
Can't compile 1.0.15 with later kernels unfortunately; some hooks seem to
have changed !

Got no reply on rme Linux forum.
On 27 Sep 2013 16:09, "Niels Laukens" <niels.laukens@innovatie.vrt.be>
wrote:

> Hi,
>
> I'm trying to capture audio from an RME Hammerfall MADI card (PCI ID
> 10ee:3fc6). The setup previously worked fine on Windows, so I'm currently
> assuming that the card and the input signal is OK.
>
> I wrote a very simple ALSA-application that simply opens the device, sets
> the access format to NONINTERLEAVED (which seems to be the only option the
> card likes), selects 32bit sampling (although the audio is 24bit, ALSA
> rejects this option), 48kHz sampling and 64 channels (also, the only
> option the card accepts). Next, it loops with snd_pcm_readn() to get 100ms
> worth of audio, and dumps channel 10 to file. (Full source in attachement)
>
> The result is strange for various reasons:
>
> * The second half of every buffer returned by snd_pcm_readn() is always
> zero's.
>
> * The call seems to return way to fast: I would expect to get 48000
> frames/second, but judging from the timing of the snd_pcm_readn() call,
> it's more like 1536000 frames/second (i.e. 32 fold faster).
>
> * When playing back the resulting file, I do recognize some music, but it
> sounds like it's the same part over and over again. Also, restarting the
> capture program minutes later, returns the same (at least as far as my
> ears & brain can recall) fragment of audio.
>
> What am I doing wrong here? (Samples of the PCM-file are available upon
> request)
>
>
> I've also tried a related test with `arecord`, with similar but different
> results:
>
> * The audio was also interspersed with silence
>
> * The capture duration did not match the requested '-d' option: the
> recording was a factor of 2 shorter than requested.
>
> * There was more audio in the recording: if I manually cut out the silent
> parts, the audio sounded reasonable.
>
> What am I missing here?
>
>
> Is this the right place to ask? Or should this go to the RME forum?
>
>
> Thanks in advance,
> Niels
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
