From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH v3 0/5] ALSA: hda - hdmi: ATI/AMD
 multi-channel and HBR support
Date: Mon, 25 Nov 2013 21:35:56 +0200
Message-ID: <5293A69C.7060706@iki.fi>
References: <1382638238-25055-1-git-send-email-anssi.hannula@iki.fi>
 <loom.20131122T215246-90@post.gmane.org>
 <CAN8cciacG0fUyEuSOMF2iXp8CUzqyTAPDNpK1q6Lu0u+gtV6zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tulikuusama.dnainternet.net (tulikuusama.dnainternet.net
 [83.102.40.132])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D040261B11
 for <alsa-devel@alsa-project.org>; Mon, 25 Nov 2013 20:36:00 +0100 (CET)
In-Reply-To: <CAN8cciacG0fUyEuSOMF2iXp8CUzqyTAPDNpK1q6Lu0u+gtV6zQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org, James Le Cuirot <chewi@aura-online.co.uk>
List-Id: alsa-devel@alsa-project.org

25.11.2013 17:07, Raymond Yau kirjoitti:
>>
>> I have a Radeon 4670 (Sapphire
>> branded) connected to a Yamaha RX-V773. I am running the sound/for-next
>> kernel (82755ab) with your "missing PCM SAD" patch applied.
>>
>> The new kernel has allowed ALSA to recognise the card as multichannel and
> I
>> can issue the following speaker-test command but I still only hear "Front
>> Left" and "Front Right" and the Yahama seems to report the signal as
> stereo.
>>
>> # speaker-test -Dhdmi:CARD=HDMI,DEV=0 -c6 -t wav
> 
> Why do you use -c6 when your HDMI codec only support stereo
> 
> Node 0x02 [Audio Output] wcaps 0x201: Stereo Digital
>    Converter: stream=1, channel=0
> Node 0x03 [Pin Complex] wcaps 0x400381: Stereo Digital

All ATI/AMD HDMI codecs report stereo only here, their multichannel
support is non-standard (probably predates the HDA spec).

-- 
Anssi Hannula
