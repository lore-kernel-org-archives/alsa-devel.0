From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASOC: wm8991: fix wrong usage of
 DECLARE_TLV_DB_LINEAR()
Date: Tue, 27 Sep 2016 09:48:39 +0100
Message-ID: <20160927084839.GX21682@localhost.localdomain>
References: <1474932329-10640-1-git-send-email-o-takashi@sakamocchi.jp>
 <1474932329-10640-2-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id B5667266CB9
 for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2016 10:48:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1474932329-10640-2-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 27, 2016 at 08:25:27AM +0900, Takashi Sakamoto wrote:
> As long as reading datasheet of WM8991, this driver includes wrong usage
> of DECLARE_TLV_DB_LINEAR().
> 
> In "Table 6 Input PGA Volume Range", volume is represented in 5 bits by
> 1.5 dB/step between -16.5/30.0 dB. Thus, 'in_pga_tlv' should be dB step
> representation.
> 
> In "Table 34 LOMIX and ROMIX Volume Range", volume is represented in three
> bits by -3 dB/step from 0 to -21 dB. Thus, 'out_mix_tlv' should be dB step
> represenation.
> 
> In "Table 36 LOPGA, ROPGA, LOUT, ROUT and SPKVOL Volume Range", volume is
> represented in 7 bits by 1 dB/step from -73 to 6 dB, including mute. Thus,
> 'out_pga_tlv' should be dB step representation.
> 
> In "Table 26 Digital Volume Range", volume is represented in 8 bits by
> 3/8 dB/step from -71.625 to 0 dB. Thus, 'out_dac_tlv' should be dB step
> representation.
> 
> In "Table 16 ADC Digital Volume Range", volume is represented in 8 bits by
> 3/8 dB/step from -71.625 to 17.625 dB. Thus, 'in_adc_tlv' should be dB step
> representation.
> 
> In "Table 23 Digital Sidetone Volume", volume is represented in 5 bits by
> 3 dB/step from -36 to 0 dB. Thus, 'out_sidetone_tlv' should be dB step
> representation.
> 
> In "Table 12 Left Input Mixer Volume Control", volume is represented in
> 3 bits by 3 dB/step from -12 to 6 dB
> 
> Totally, current implementation includes misuse of TLV-related macro.
> 
> This commit replaces usage of DECLARE_TLV_DB_LINEAR() with proper macros,
> to give proper information to applications in user land.
> 
> Fixes: 203db220718c ("ASoC: WM8991: Add initial WM8991 driver")
> Cc: patches@opensource.wolfsonmicro.com
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
