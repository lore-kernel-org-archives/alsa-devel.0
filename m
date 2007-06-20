From: "Paul Kavan" <pkavan@gmail.com>
Subject: at91 SoC Modifications
Date: Wed, 20 Jun 2007 16:21:35 -0500
Message-ID: <61c0054e0706201421x3725f809g80822d32d78d216e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 3ACE9243D0
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jun 2007 23:21:36 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id o2so436046uge
	for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2007 14:21:35 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Frank Mandarino <fmandarino@endrelia.com>, Liam Girdwood <lg@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hello:

Okay, so after probing the various pcm lines, I think I see that the format
used for the pcm is a little bit off of what my codec likes to play nice. In
my machine/codec driver, I see that I have some lines:

    /* set cpu DAI configuration */
    ret = cpu_dai->dai_ops.set_fmt(cpu_dai, SND_SOC_DAIFMT_DSP_A |
        SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);

I believe this is where it is selecting the format. In at91-ssc.c, I see
that this format is given as:

    case SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_CBS_CFS:
        /*
         * DSP/PCM Mode A format, SSC provides BCLK and LRC clocks.
         *
         * The SSC transmit and receive clocks are generated from the
         * MCK divider, and the BCLK signal is output on the SSC TK line.
         */
        rcmr =      (( ssc_p->rcmr_period        << 24) & AT91_SSC_PERIOD)
            | (( 1                << 16) & AT91_SSC_STTDLY)
            | (( AT91_SSC_START_RISING_RF         ) & AT91_SSC_START)
            | (( AT91_SSC_CK_RISING             ) & AT91_SSC_CKI)
            | (( AT91_SSC_CKO_NONE             ) & AT91_SSC_CKO)
            | (( AT91_SSC_CKS_DIV             ) & AT91_SSC_CKS);

        rfmr =      (( AT91_SSC_FSEDGE_POSITIVE         ) & AT91_SSC_FSEDGE)
            | (( AT91_SSC_FSOS_POSITIVE         ) & AT91_SSC_FSOS)
            | (( 0                << 16) & AT91_SSC_FSLEN)
            | (((channels - 1)        <<  8) & AT91_SSC_DATNB)
            | (( 1                <<  7) & AT91_SSC_MSBF)
            | (( 0                <<  5) & AT91_SSC_LOOP)
            | (((bits - 1)            <<  0) & AT91_SSC_DATALEN);

        tcmr =      (( ssc_p->tcmr_period        << 24) & AT91_SSC_PERIOD)
            | (( 1                << 16) & AT91_SSC_STTDLY)
            | (( AT91_SSC_START_RISING_RF        ) & AT91_SSC_START)
            | (( AT91_SSC_CK_RISING             ) & AT91_SSC_CKI)
            | (( AT91_SSC_CKO_CONTINUOUS         ) & AT91_SSC_CKO)
            | (( AT91_SSC_CKS_DIV             ) & AT91_SSC_CKS);

        tfmr =      (( AT91_SSC_FSEDGE_POSITIVE         ) & AT91_SSC_FSEDGE)

            | (( 0                << 23) & AT91_SSC_FSDEN)
            | (( AT91_SSC_FSOS_POSITIVE         ) & AT91_SSC_FSOS)
            | (( 0                << 16) & AT91_SSC_FSLEN)
            | (((channels - 1)        <<  8) & AT91_SSC_DATNB)
            | (( 1                <<  7) & AT91_SSC_MSBF)
            | (( 0                <<  5) & AT91_SSC_DATDEF)
            | (((bits - 1)            <<  0) & AT91_SSC_DATALEN);



            break;

I should have caught this before--I spent enough time dealing with the HW
registers. The simple ssc pcm driver I wrote sets the regs a little
differently to get the peak performance out of the codec, e.g.

In RCMR, I have STTDLY=0, AT91_SSC_CKI_FALLING, AT91_SSC_CKS_PIN.

In RFMR everything looks okay except that I have FSOS_NONE as I borrow it
from TF0

In TCMR the STTDLY=0 in mine

In TFMR I do nothing with the FSEDGE and FSDEN and I have FSLEN=7 and
DATADEF=1.

So, I left with a decision. Do I add a mode or do I modify DSP A to fit my
needs? I am not sure how much coding it would take to add a mode--I *do*
know it would take little time to modify DSP A, but I am reluctant to make a
change to something that is probably 'standard'.

Any thoughts on this?

Paul

-- 
***************************************
Paul David Kavan
Project Engineer
GRH Electronics, Inc.
402-734-4900
pkavan@gmail.com
***************************************
