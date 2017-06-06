From: Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH v3 1/2] ASoC: add es8316 codec driver
Date: Tue, 6 Jun 2017 07:59:43 -0600
Message-ID: <CAD8Lp47tmZUa6MiMs2nf_mHRv0+x1ktobamXKjbTQzb37Kg9-Q@mail.gmail.com>
References: <20170605201637.4901-1-drake@endlessm.com>
 <79daa67f-64f1-46b1-fd2d-cb925c02b381@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f49.google.com (mail-oi0-f49.google.com
 [209.85.218.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A2BF2668E2
 for <alsa-devel@alsa-project.org>; Tue,  6 Jun 2017 15:59:44 +0200 (CEST)
Received: by mail-oi0-f49.google.com with SMTP id o65so154271999oif.1
 for <alsa-devel@alsa-project.org>; Tue, 06 Jun 2017 06:59:44 -0700 (PDT)
In-Reply-To: <79daa67f-64f1-46b1-fd2d-cb925c02b381@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>, Linux Upstreaming Team <linux@endlessm.com>, yangxiaohua <yangxiaohua@everest-semi.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On Mon, Jun 5, 2017 at 6:30 PM, Takashi Sakamoto
<o-takashi@sakamocchi.jp> wrote:
> To me, the array of 'adc_pga_gain_tlv' includes invalid members as
> 'SNDRV_CTL_TLVT_DB_RANGE'. In your code, the array represents below table:
>
> Linear range: dB range: coeff: mute
> 0 <-> 0:    0 <->    0: 0: 0
> 1 <-> 1:  300 <->  300: 0: 0
> 2 <-> 2:  600 <->  600: 0: 0
> 3 <-> 3:  900 <->  900: 0: 0
> 4 <-> 4: 1200 <-> 1200: 0: 0
> 5 <-> 5: 1500 <-> 1500: 0: 0
> 6 <-> 6: 1800 <-> 1800: 0: 0
> 7 <-> 7: 2100 <-> 2100: 0: 0
> 8 <-> 8: 2400 <-> 2400: 0: 0
>
> Can I ask you to ensure that your hardware has jumps for current dB value
> against given linear value and investigate the reason that maximum value in
> this table has too large value (2,400) as dB representation.

Thanks for the the info here! Based on the datasheet and newer headers
I have updated it to:

static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(adc_pga_gain_tlv,
    0, 0, TLV_DB_SCALE_ITEM(-3500, 0, 0),
    1, 1, TLV_DB_SCALE_ITEM(0, 0, 0),
    2, 2, TLV_DB_SCALE_ITEM(250, 0, 0),
    3, 3, TLV_DB_SCALE_ITEM(450, 0, 0),
    4, 4, TLV_DB_SCALE_ITEM(700, 0, 0),
    5, 5, TLV_DB_SCALE_ITEM(1000, 0, 0),
    6, 6, TLV_DB_SCALE_ITEM(1300, 0, 0),
    7, 7, TLV_DB_SCALE_ITEM(1600, 0, 0),
    8, 8, TLV_DB_SCALE_ITEM(1800, 0, 0),
    9, 9, TLV_DB_SCALE_ITEM(2100, 0, 0),
    10, 10, TLV_DB_SCALE_ITEM(2400, 0, 0),
);

I believe the final entry means 24dB and does not have the large value
that you have interpreted.
There are many other drivers using similar values like this from rt5616.c:

/* {0, +20, +24, +30, +35, +40, +44, +50, +52} dB */
static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(bst_tlv,
    0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
    1, 1, TLV_DB_SCALE_ITEM(2000, 0, 0),
    2, 2, TLV_DB_SCALE_ITEM(2400, 0, 0),
    3, 5, TLV_DB_SCALE_ITEM(3000, 500, 0),
    6, 6, TLV_DB_SCALE_ITEM(4400, 0, 0),
    7, 7, TLV_DB_SCALE_ITEM(5000, 0, 0),
    8, 8, TLV_DB_SCALE_ITEM(5200, 0, 0),
);

I'll test this change and wait for any further review comments before
sending a v4. I've also noticed that hpout_vol_tlv can be corrected
and simplified.

Thanks
Daniel
