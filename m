From: Daniel Mack <zonque@gmail.com>
Subject: Re: Usb audio - unsuported sampling rates
Date: Tue, 10 Jul 2012 23:33:02 +0200
Message-ID: <4FFC9F8E.6090004@gmail.com>
References: <CADPOxSii6AGmyBmEYkBSs24Zd7fwasutf=HxTrB0xNqo4vuhXg@mail.gmail.com>
	<4FFBD182.9040503@gmail.com>
	<CADPOxSis1apDxiFn6A6g-Rdi22sOgeMqCe+vOsDXy3odvjALAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 9331C24365
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jul 2012 23:33:06 +0200 (CEST)
Received: by bkcjk13 with SMTP id jk13so401407bkc.38
	for <alsa-devel@alsa-project.org>; Tue, 10 Jul 2012 14:33:06 -0700 (PDT)
In-Reply-To: <CADPOxSis1apDxiFn6A6g-Rdi22sOgeMqCe+vOsDXy3odvjALAg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Gordon Dilan <gordon.dilan@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Gordon,

On 10.07.2012 20:57, Gordon Dilan wrote:
           0
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        2
>       bAlternateSetting       1
>       bNumEndpoints           1
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol      0
>       iInterface              0
>       AudioStreaming Interface Descriptor:
>         bLength                 7
>         bDescriptorType        36
>         bDescriptorSubtype      1 (AS_GENERAL)
>         bTerminalLink           2
>         bDelay                  1 frames
>         wFormatTag              1 PCM
>       AudioStreaming Interface Descriptor:
>         bLength                11
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             1 (FORMAT_TYPE_I)
>         bNrChannels             4
>         bSubframeSize           2
>         bBitResolution         16
>         bSamFreqType            1 Discrete
>         tSamFreq[ 0]        16000

The interface only reports this single sample rate. If the vendor claims
that there are in fact more, it would be good to know which ones.

Then we can add a quirk to parse_audio_format_rates_v1() in
sound/usb/format.c - that shouldn't be too hard.


Daniel
