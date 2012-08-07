From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Connecting a codec to McASP in Linux 2.6.37
Date: Tue, 7 Aug 2012 09:51:42 +0000
Message-ID: <A551BDF323A45B48ACE6A404AA16A1C41278419F@TOP-EX01.TOPIC.LOCAL>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp102.mer-nm.internl.net (smtp102.mer-nm.internl.net
 [217.149.192.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 44D7E26031C
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 11:24:12 +0200 (CEST)
Received: from amavisd-new (mailscanner6.mer-nm.internl.net [217.149.192.58])
 by smtp102.mer-nm.internl.net (Postfix) with ESMTP id EED1C3FCF0
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 11:53:57 +0200 (CEST)
Received: from smtp102.mer-nm.internl.net ([217.149.192.138])
 by amavisd-new (mailscanner6.mer-nm.internl.net [217.149.192.159])
 (amavisd-new, port 10024)
 with ESMTP id ZNBA4FOY3BtU for <alsa-devel@alsa-project.org>;
 Tue,  7 Aug 2012 11:53:57 +0200 (CEST)
Received: from TOP-EX02.topic.local (82-204-13-181.dsl.bbeyond.nl
 [82.204.13.181]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by smtp102.mer-nm.internl.net (Postfix) with ESMTPS
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 11:53:57 +0200 (CEST)
Content-Language: nl-NL
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

We are using the (Arago) linux kernel 2.6.37 (also labelled v2.6.37_DAVINCIPSP_03.21.00.04). There are several TLV320AIC3256 codec connected to an OMAP-L138 SoM board via I2C and McASP. The board is based on the DA850 EVM.

To support the codec, I've backported the tlv320aic32x4 driver from the 2.6.39 linux kernel.

The I2C part is configured correctly, and I can get and set mixer components and other settings via I2C to the codec.

However, setting up the McASP data path is a complete riddle, and I need help to get this to work.

In the board files, the following structs "glue" the codec to the audio data transfer unit:

static struct snd_soc_dai_link da8xx_evm_dai[] = {
        {
                .name = "TLV320AIC3X-1",
                .stream_name = "AIC3X-1",
                .cpu_dai_name= "davinci-mcasp.0",
                .codec_dai_name = "tlv320aic32x4-hifi",
                .codec_name = "tlv320aic32x4.11-0018",
                .platform_name = "davinci-pcm-audio",
                .init = evm_aic3x_init_analog,
                .ops = &evm_ops,
        },
        {
                .name = "TLV320AIC3X-2",
                .stream_name = "AIC3X-2",
                .cpu_dai_name= "davinci-mcasp.0",
                .codec_dai_name = "tlv320aic32x4-hifi",
                .codec_name = "tlv320aic32x4.12-0018",
                .platform_name = "davinci-pcm-audio",
                .init = evm_aic3x_init_analog,
                .ops = &evm_ops,
        },

I cannot determine what "stream_name" is supposed to do. Documentation in "dapm.txt" claims that "the stream name must match the corresponding stream name in your codec snd_soc_codec_dai", but that appears to be untrue, because in the existing SoC drivers, they never match. Also, "snd_soc_codec_dai" seems to be a typo in the documentation, because it only appears in the alsa soc documentation and nowhere else in the kernel.

The string "davinci-mcasp.0" refers to the struct in sound/soc/davinci/davinci-mcasp.c:

static struct snd_soc_dai_driver davinci_mcasp_dai[] = {
        {
                .name           = "davinci-mcasp.0",
                .playback       = {
                        .channels_min   = 2,
                        .channels_max   = 2,
                        .rates          = DAVINCI_MCASP_RATES,
                        .formats        = SNDRV_PCM_FMTBIT_S8 |
                                                SNDRV_PCM_FMTBIT_S16_LE |
                                                SNDRV_PCM_FMTBIT_S32_LE,
                },
                .capture        = {
                        .channels_min   = 2,
                        .channels_max   = 2,
                        .rates          = DAVINCI_MCASP_RATES,
                        .formats        = SNDRV_PCM_FMTBIT_S8 |
                                                SNDRV_PCM_FMTBIT_S16_LE |
                                                SNDRV_PCM_FMTBIT_S32_LE,
                },
                .ops            = &davinci_mcasp_dai_ops,

        },

And in the board config files, there is also a struct that configures the McASP ports:

static u8 da850_iis_serializer_direction[] = {
        INACTIVE_MODE,  INACTIVE_MODE,  INACTIVE_MODE,  INACTIVE_MODE,
        INACTIVE_MODE,  INACTIVE_MODE,  RX_MODE,        TX_MODE,
        INACTIVE_MODE,  INACTIVE_MODE,  INACTIVE_MODE,  INACTIVE_MODE,
        INACTIVE_MODE,  INACTIVE_MODE,  INACTIVE_MODE,  INACTIVE_MODE,
};

static struct snd_platform_data da850_evm_snd_data = {
        .tx_dma_offset  = 0x2000,
        .rx_dma_offset  = 0x2000,
        .op_mode        = DAVINCI_MCASP_IIS_MODE,
        .num_serializer = ARRAY_SIZE(da850_iis_serializer_direction),
        .tdm_slots      = 2,
        .serial_dir     = da850_iis_serializer_direction,
        .asp_chan_q     = EVENTQ_1,
        .version        = MCASP_VERSION_2,
        .txnumevt       = 1,
        .rxnumevt       = 1,
};

...
da8xx_register_mcasp(0, &da850_evm_snd_data);

Now this part is a complete mystery. To have multiple CODECs, do i need to register multiple instances of the McASP driver and fill in the serializer structs for each? And if not, how does it know which input is for which codec? And what are all the fields? There's no documentation whatsoever, so the above was my best guess to get at least one codec functioning. It sort of seems to do something, but all samples are zero and I get lots of overrun errors when using arecord to capture data from it.

If there's more you need to know in order to help, don't hesitate to ask, I'll be happy to supply whatever information you need on this.

Mike.


Met vriendelijke groet / kind regards,

Mike Looijmans

TOPIC Embedded Systems
Eindhovenseweg 32-C, NL-5683 KH Best
Postbus 440, NL-5680 AK Best
Telefoon: (+31) - (0)499 - 33.69.79
Telefax: (+31) - (0)499 - 33.69.70
E-mail: mike.looijmans@topic.nl
Website: www.topic.nl

Dit e-mail bericht en de eventueel daarbij behorende bijlagen zijn uitsluitend bestemd voor de geadresseerde, zoals die blijkt uit het e-mail bericht en/of de bijlagen. Er kunnen gegevens met betrekking tot een derde instaan. Indien u als niet-geadresseerde dit bericht en de bijlagen ontvangt, terwijl u niet bevoegd of gemachtigd bent om dit bericht namens de geadresseerde te ontvangen, wordt u verzocht de afzender hierover direct te informeren en het e-mail bericht met de bijlagen te vernietigen. Ieder gebruik van de inhoud van het e-mail bericht, waaronder de daarbij behorende bijlagen, door een ander dan de geadresseerde is onrechtmatig jegens ons dan wel de eventueel in het e-mail bericht of de bijlagen voorkomende andere personen. TOPIC Embedded Systems is niet aansprakelijk voor enig
 erlei schade voortvloeiend uit het gebruik en/of acceptatie van dit e-mail bericht of de daarbij behorende bijlagen.

The contents of this message, as well as any enclosures, are addressed personally to, and thus solely intended for the addressee. They may contain information regarding a third party. A recipient who is neither the addressee, nor empowered to receive this message on behalf of the addressee, is kindly requested to immediately inform the sender of receipt, and to destroy the message and the enclosures. Any use of the contents of this message and/or the enclosures by any other person than the addressee or person who is empowered to receive this message, is illegal towards the sender and/or the aforementioned third party. TOPIC Embedded Systems is not  liable for any damage as a result of the use and/or acceptance of this message and as well as any enclosures.
