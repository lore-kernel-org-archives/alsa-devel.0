From: James Le Cuirot <chewi@aura-online.co.uk>
Subject: Re: [PATCH v3 0/5] ALSA: hda - hdmi: ATI/AMD
 multi-channel and HBR support
Date: Mon, 25 Nov 2013 15:32:12 +0000
Message-ID: <20131125153212.3c162da7@red>
References: <1382638238-25055-1-git-send-email-anssi.hannula@iki.fi>
 <loom.20131122T215246-90@post.gmane.org>
 <CAN8cciacG0fUyEuSOMF2iXp8CUzqyTAPDNpK1q6Lu0u+gtV6zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 873C9261AB7
 for <alsa-devel@alsa-project.org>; Mon, 25 Nov 2013 16:32:20 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 25 Nov 2013 23:07:09 +0800
Raymond Yau <superquad.vortex2@gmail.com> wrote:

> >
> > I have a Radeon 4670 (Sapphire
> > branded) connected to a Yamaha RX-V773. I am running the
> > sound/for-next kernel (82755ab) with your "missing PCM SAD" patch
> > applied.
> >
> > The new kernel has allowed ALSA to recognise the card as
> > multichannel and
> I
> > can issue the following speaker-test command but I still only hear
> > "Front Left" and "Front Right" and the Yahama seems to report the
> > signal as
> stereo.
> >
> > # speaker-test -Dhdmi:CARD=HDMI,DEV=0 -c6 -t wav
> 
> Why do you use -c6 when your HDMI codec only support stereo
> 
> Node 0x02 [Audio Output] wcaps 0x201: Stereo Digital
>    Converter: stream=1, channel=0
> Node 0x03 [Pin Complex] wcaps 0x400381: Stereo Digital

I was under the impression that this card, and all cards in the
Radeon 4000 series, are capable of 7.1 LPCM. Are you suggesting
otherwise? Either it really isn't, or this information is being wrongly
detected, and that could point to the source of the problem.

I was not aware of the significance of these lines before so thanks
for pointing this out. Before I tried the new kernel, ALSA wouldn't let
me do 6 channel output at all and PulseAudio detected the card as stereo
only. Now ALSA doesn't complain and PA detects it as 5.1 so I figured it
should work now. Having said that, I'm not sure why PA doesn't report
7.1 but I only have 5.1 speakers anyway.

Regards,
James
