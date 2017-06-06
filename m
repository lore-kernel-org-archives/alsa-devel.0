From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v3 1/2] ASoC: add es8316 codec driver
Date: Wed, 7 Jun 2017 00:02:28 +0900
Message-ID: <f49354f4-3705-681c-d52d-709c9a25c8a2@sakamocchi.jp>
References: <20170605201637.4901-1-drake@endlessm.com>
 <79daa67f-64f1-46b1-fd2d-cb925c02b381@sakamocchi.jp>
 <CAD8Lp47tmZUa6MiMs2nf_mHRv0+x1ktobamXKjbTQzb37Kg9-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id DF3ED266F7B
 for <alsa-devel@alsa-project.org>; Tue,  6 Jun 2017 17:02:35 +0200 (CEST)
In-Reply-To: <CAD8Lp47tmZUa6MiMs2nf_mHRv0+x1ktobamXKjbTQzb37Kg9-Q@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Drake <drake@endlessm.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>, Linux Upstreaming Team <linux@endlessm.com>, yangxiaohua <yangxiaohua@everest-semi.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Jul 6 2017 22:59, Daniel Drake wrote:
> Thanks for the the info here! Based on the datasheet and newer headers
> I have updated it to:
> 
> static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(adc_pga_gain_tlv,
>      0, 0, TLV_DB_SCALE_ITEM(-3500, 0, 0),
>      1, 1, TLV_DB_SCALE_ITEM(0, 0, 0),
>      2, 2, TLV_DB_SCALE_ITEM(250, 0, 0),
>      3, 3, TLV_DB_SCALE_ITEM(450, 0, 0),
>      4, 4, TLV_DB_SCALE_ITEM(700, 0, 0),
>      5, 5, TLV_DB_SCALE_ITEM(1000, 0, 0),
>      6, 6, TLV_DB_SCALE_ITEM(1300, 0, 0),
>      7, 7, TLV_DB_SCALE_ITEM(1600, 0, 0),
>      8, 8, TLV_DB_SCALE_ITEM(1800, 0, 0),
>      9, 9, TLV_DB_SCALE_ITEM(2100, 0, 0),
>      10, 10, TLV_DB_SCALE_ITEM(2400, 0, 0),
> );

This is valid data as TLV of DB_RANGE type (11 entries).

> I believe the final entry means 24dB and does not have the large value
> that you have interpreted.

Exactly. I sent my previous message with the mistake. Unit of the first 
field of SNDRV_CTL_TLVD_DB_SCALE_ITEM is 0.01 dB, therefore it's 24.0 
dB, as you realized.

> There are many other drivers using similar values like this from rt5616.c:
> 
> /* {0, +20, +24, +30, +35, +40, +44, +50, +52} dB */
> static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(bst_tlv,
>      0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
>      1, 1, TLV_DB_SCALE_ITEM(2000, 0, 0),
>      2, 2, TLV_DB_SCALE_ITEM(2400, 0, 0),
>      3, 5, TLV_DB_SCALE_ITEM(3000, 500, 0),
>      6, 6, TLV_DB_SCALE_ITEM(4400, 0, 0),
>      7, 7, TLV_DB_SCALE_ITEM(5000, 0, 0),
>      8, 8, TLV_DB_SCALE_ITEM(5200, 0, 0),
> );
> 
> I'll test this change and wait for any further review comments before
> sending a v4. I've also noticed that hpout_vol_tlv can be corrected
> and simplified.

The data is valid. In this case, the table is:

Linear range: dB range: coeff: mute
  0 <-> 0:    0 <->    0:   0: 0
(0 <-> 1:    0 <-> 2000:2000: 0)
  1 <-> 1: 2000 <-> 2000:   0: 0
(1 <-> 2: 2000 <-> 2400: 400: 0)
  2 <-> 2: 2400 <-> 2400:   0: 0
(2 <-> 3: 2400 <-> 3000: 600: 0)
  3 <-> 5: 3000 <-> 4000: 500: 0
(5 <-> 6: 4000 <-> 4400: 400: 0)
  6 <-> 6: 4400 <-> 4400:   0: 0
(6 <-> 7: 4400 <-> 5000: 600: 0)
  7 <-> 7: 5000 <-> 5000:   0: 0
(7 <-> 8: 5000 <-> 5200: 200: 0)
  8 <-> 8: 5200 <-> 5299:   0: 0

We can use an alternate representation of the TLV data with brackets, like:

static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(bst_tlv,
      0, 1, SNDRV_CTL_TLVD_DB_SCALE_ITEM(0,    1000, 0),
      1, 2, SNDRV_CTL_TLVD_DB_SCALE_ITEM(2000,  400, 0),
      2, 3, SNDRV_CTL_TLVD_DB_SCALE_ITEM(2400,  600, 0),
      3, 5, SNDRV_CTL_TLVD_DB_SCALE_ITEM(3000,  500, 0),
      5, 6, SNDRV_CTL_TLVD_DB_SCALE_ITEM(4000,  400, 0), 

      6, 7, SNDRV_CTL_TLVD_DB_SCALE_ITEM(4400,  600, 0), 

      7, 8, SNDRV_CTL_TLVD_DB_SCALE_ITEM(5000,  200, 0), 

);


Well, in your case, the hardware supports between -35 dB and 24 dB with 
variable 10 steps and the table can also be:

0 <->  1: -3500 <->    0: 3500: 0
1 <->  2:     0 <->  250:  250: 0
2 <->  3:   250 <->  450:  200: 0
3 <->  4:   450 <->  700:  250: 0
4 <->  7:   700 <-> 1600:  300: 0
7 <->  8:  1600 <-> 1800:  200: 0
8 <-> 10:  1800 <-> 2400:  300: 0

Therefore, we can also use an alternate representation, below.

static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(adc_pga_gain_tlv,
     0,  1, SNDRV_CTL_TLVD_DB_SCALE_ITEM(-3500, 3500, 0),
     1,  2, SNDRV_CTL_TLVD_DB_SCALE_ITEM(    0,  250, 0),
     2,  3, SNDRV_CTL_TLVD_DB_SCALE_ITEM(  250,  200, 0),
     3,  4, SNDRV_CTL_TLVD_DB_SCALE_ITEM(  450,  250, 0),
     4,  7, SNDRV_CTL_TLVD_DB_SCALE_ITEM(  700,  300, 0),
     7,  8, SNDRV_CTL_TLVD_DB_SCALE_ITEM( 1600,  200, 0),
     8, 10, SNDRV_CTL_TLVD_DB_SCALE_ITEM( 1800,  300, 0),
);

In alsa-lib, there's a sample program for user-defined control element 
set[1]. It includes some examples of TLV data. 
allocate_int64_elem_set_tlv() adds TLV data similar to your case. This 
data can be parsed by alsa-lib, like:

$ amixer contents
...
numid=4566,iface=MIXER,name='userspace-control-element-INTEGER64',index=896
   ; type=INTEGER64,access=rw---RW-,values=64,min=0,max=10000,step=1
   : 
values=1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
   | dBrange-
     rangemin=0,,rangemax=4
       | dBscale-min=-59.40dB,step=0.44dB,mute=1
     rangemin=4,,rangemax=22
       | dBscale-min=-56.36dB,step=0.60dB,mute=0
     rangemin=22,,rangemax=33
       | dBscale-min=-45.56dB,step=0.76dB,mute=0
     rangemin=33,,rangemax=37
       | dBscale-min=-40.72dB,step=0.44dB,mute=0
     rangemin=37,,rangemax=48
       | dBscale-min=-38.32dB,step=0.76dB,mute=0
     rangemin=48,,rangemax=66
       | dBscale-min=-29.96dB,step=0.60dB,mute=0
     rangemin=66,,rangemax=84
       | dBscale-min=-22.04dB,step=0.44dB,mute=0
     rangemin=84,,rangemax=95
       | dBscale-min=-8.36dB,step=0.60dB,mute=0
     rangemin=95,,rangemax=99
       | dBscale-min=-1.76dB,step=0.76dB,mute=0
     rangemin=100,,rangemax=10000
       | dBscale-min=0.00dB,step=0.00dB,mute=0
...

Both way of representation is valid. For your information.


[1] user-ctl-element-set.c
http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=test/user-ctl-element-set.c


Regards

Takashi Sakamoto
