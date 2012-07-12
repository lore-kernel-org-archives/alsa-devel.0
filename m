From: Daniel Mack <zonque@gmail.com>
Subject: Re: Usb audio - unsuported sampling rates
Date: Thu, 12 Jul 2012 09:44:34 +0200
Message-ID: <4FFE8062.5040101@gmail.com>
References: <CADPOxSii6AGmyBmEYkBSs24Zd7fwasutf=HxTrB0xNqo4vuhXg@mail.gmail.com>
	<4FFBD182.9040503@gmail.com>
	<CADPOxSis1apDxiFn6A6g-Rdi22sOgeMqCe+vOsDXy3odvjALAg@mail.gmail.com>
	<4FFC9F8E.6090004@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060700070904070901020706"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id B2FAD244C0
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Jul 2012 09:44:37 +0200 (CEST)
Received: by bkcjk13 with SMTP id jk13so1424025bkc.38
	for <alsa-devel@alsa-project.org>; Thu, 12 Jul 2012 00:44:37 -0700 (PDT)
In-Reply-To: <4FFC9F8E.6090004@gmail.com>
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

This is a multi-part message in MIME format.
--------------060700070904070901020706
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 10.07.2012 23:33, Daniel Mack wrote:
> Hi Gordon,
> 
> On 10.07.2012 20:57, Gordon Dilan wrote:
>            0
>>     Interface Descriptor:
>>       bLength                 9
>>       bDescriptorType         4
>>       bInterfaceNumber        2
>>       bAlternateSetting       1
>>       bNumEndpoints           1
>>       bInterfaceClass         1 Audio
>>       bInterfaceSubClass      2 Streaming
>>       bInterfaceProtocol      0
>>       iInterface              0
>>       AudioStreaming Interface Descriptor:
>>         bLength                 7
>>         bDescriptorType        36
>>         bDescriptorSubtype      1 (AS_GENERAL)
>>         bTerminalLink           2
>>         bDelay                  1 frames
>>         wFormatTag              1 PCM
>>       AudioStreaming Interface Descriptor:
>>         bLength                11
>>         bDescriptorType        36
>>         bDescriptorSubtype      2 (FORMAT_TYPE)
>>         bFormatType             1 (FORMAT_TYPE_I)
>>         bNrChannels             4
>>         bSubframeSize           2
>>         bBitResolution         16
>>         bSamFreqType            1 Discrete
>>         tSamFreq[ 0]        16000
> 
> The interface only reports this single sample rate. If the vendor claims
> that there are in fact more, it would be good to know which ones.
> 
> Then we can add a quirk to parse_audio_format_rates_v1() in
> sound/usb/format.c - that shouldn't be too hard.

Something like the patch below could help. Can you try this?


Daniel

--------------060700070904070901020706
Content-Type: text/x-patch;
 name="playstation-eye-samplerates.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="playstation-eye-samplerates.diff"

diff --git a/sound/usb/format.c b/sound/usb/format.c
index ddfef57..ce64a5b 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -158,6 +158,17 @@ static int parse_audio_format_rates_v1(struct snd_usb_audio *chip, struct audiof
 		return -1;
 	}
 
+	/* 
+	 * Sony's "Playstation Eye" microphone only reports one sample rate,
+	 * but can in fact handle more.
+	 */
+	if (chip->usb_id == USB_ID(0x1415, 0x2000) && fp->altsetting == 1) {
+		fp->rates = SNDRV_PCM_RATE_CONTINUOUS;
+		fp->rate_min = 16000;
+		fp->rate_min = 48000;
+		return 0;
+	}
+
 	if (nr_rates) {
 		/*
 		 * build the rate table and bitmap flags

--------------060700070904070901020706
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------060700070904070901020706--
