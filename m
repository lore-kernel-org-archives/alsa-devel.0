From: Gordon Dilan <gordon.dilan@gmail.com>
Subject: Re: Usb audio - unsuported sampling rates
Date: Sat, 14 Jul 2012 05:01:40 -0400
Message-ID: <CADPOxSi7ijOCobfyRVoTBPenY-gJBnPivaJF1pY8jnrgVgmxsg@mail.gmail.com>
References: <CADPOxSii6AGmyBmEYkBSs24Zd7fwasutf=HxTrB0xNqo4vuhXg@mail.gmail.com>
	<4FFBD182.9040503@gmail.com>
	<CADPOxSis1apDxiFn6A6g-Rdi22sOgeMqCe+vOsDXy3odvjALAg@mail.gmail.com>
	<4FFC9F8E.6090004@gmail.com> <4FFE8062.5040101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 7C2872433A
	for <alsa-devel@alsa-project.org>;
	Sat, 14 Jul 2012 11:01:41 +0200 (CEST)
Received: by vbip1 with SMTP id p1so2683978vbi.38
	for <alsa-devel@alsa-project.org>; Sat, 14 Jul 2012 02:01:40 -0700 (PDT)
In-Reply-To: <4FFE8062.5040101@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Daniel,

Thank you very much for your help and sorry for the late answer. I was
without internet access for the last few days.

I have tried the patch that you sent me(with a minor modification:
fp->rate_max(instead of min) = 48000; ).
If I try to record using 48kHz and then playback, it will playback in "fast
speed", voices being recorded as "chipmunks".
Only at 16000Hz it records at "normal speed".

So it seems that the recording is still done in fact at 16kHz, even though
now the driver appears to support sampling rates between 16000-48000Hz.

Dmesg is also showing me this everytime I try to record using the
microphone(These messages appeared even without the driver modification):
[  165.364728] ALSA clock.c:242 current rate 175902 is different from the
runtime rate 48000
[  171.838509] ALSA clock.c:242 current rate 51816 is different from the
runtime rate 48000
[  206.950822] ALSA clock.c:242 current rate 281039 is different from the
runtime rate 48000
[  968.713856] ALSA clock.c:242 current rate 6096811 is different from the
runtime rate 48000

Once again, thank you very much for your support!

Best Regards,
Gordon

On Thu, Jul 12, 2012 at 3:44 AM, Daniel Mack <zonque@gmail.com> wrote:

> On 10.07.2012 23:33, Daniel Mack wrote:
> > Hi Gordon,
> >
> > On 10.07.2012 20:57, Gordon Dilan wrote:
> >            0
> >>     Interface Descriptor:
> >>       bLength                 9
> >>       bDescriptorType         4
> >>       bInterfaceNumber        2
> >>       bAlternateSetting       1
> >>       bNumEndpoints           1
> >>       bInterfaceClass         1 Audio
> >>       bInterfaceSubClass      2 Streaming
> >>       bInterfaceProtocol      0
> >>       iInterface              0
> >>       AudioStreaming Interface Descriptor:
> >>         bLength                 7
> >>         bDescriptorType        36
> >>         bDescriptorSubtype      1 (AS_GENERAL)
> >>         bTerminalLink           2
> >>         bDelay                  1 frames
> >>         wFormatTag              1 PCM
> >>       AudioStreaming Interface Descriptor:
> >>         bLength                11
> >>         bDescriptorType        36
> >>         bDescriptorSubtype      2 (FORMAT_TYPE)
> >>         bFormatType             1 (FORMAT_TYPE_I)
> >>         bNrChannels             4
> >>         bSubframeSize           2
> >>         bBitResolution         16
> >>         bSamFreqType            1 Discrete
> >>         tSamFreq[ 0]        16000
> >
> > The interface only reports this single sample rate. If the vendor claims
> > that there are in fact more, it would be good to know which ones.
> >
> > Then we can add a quirk to parse_audio_format_rates_v1() in
> > sound/usb/format.c - that shouldn't be too hard.
>
> Something like the patch below could help. Can you try this?
>
>
> Daniel
>
