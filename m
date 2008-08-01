From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 04/14] ASoC: Allow codecs to override
	register display
Date: Fri, 1 Aug 2008 12:27:27 -0400
Message-ID: <9e4733910808010927j1da77ed2q3bf7d8cfcf0108fe@mail.gmail.com>
References: <1217328155-30158-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<9e4733910807311841v3ebe98f5i327606d7d793f832@mail.gmail.com>
	<s5hk5f1jcl7.wl%tiwai@suse.de>
	<20080801100003.GA16420@rakim.wolfsonmicro.main>
	<9e4733910808010750x69e71cd2i21eb0b448e11544a@mail.gmail.com>
	<s5hiquk4v4g.wl%tiwai@suse.de> <20080801153538.GA11735@sirena.org.uk>
	<s5hfxpo4twd.wl%tiwai@suse.de>
	<9e4733910808010913x46a4f57fm316b013984ac6b1c@mail.gmail.com>
	<20080801161613.GA2076@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.155])
	by alsa0.perex.cz (Postfix) with ESMTP id C9645244BE
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Aug 2008 18:27:28 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so694624ywk.2
	for <alsa-devel@alsa-project.org>; Fri, 01 Aug 2008 09:27:27 -0700 (PDT)
In-Reply-To: <20080801161613.GA2076@rakim.wolfsonmicro.main>
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
To: Jon Smirl <jonsmirl@gmail.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 8/1/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Aug 01, 2008 at 12:13:52PM -0400, Jon Smirl wrote:
>
>  > Allow external register display to suppress sparse registers
>
>
> As I said when you originally proposed this I'm really not happy about
>  changing to that interface.
>
>  Adding explicit information about registers to skip and having this
>  function use it would be useful but munging it in makes the register
>  display function non-reusable and means that other parts of ASoC will be
>  unable to use the information about the void registers should they have
>  a use for it.
>

Why would ASoC care about the holes in my sparse register list? You
can't use this info for suspend/resume, my registers are variable
length too. I need quite a bit of information to build a cache of
sparse variable length registers.

/* Size and number of variable length entries in the cache */
#define TAS_CACHE_1_MAX 41
#define TAS_CACHE_2_MAX 16
#define TAS_CACHE_3_MAX 2
#define TAS_CACHE_4_MAX 8
#define TAS_CACHE_5_MAX 30
#define TAS_CACHE_6_MAX 4

/* Size and offset of specific  entries in the cache */
static struct {
	u8 size;
	u8 offset;
} cache_map[] = {
[0x00]=	{1, 0xff},	/* TAS_REG_CLOCK_CONTROL */
[0x01]=	{1, 0xff},	/* TAS_REG_GENERAL_STATUS */
[0x02]=	{1, 0xff},	/* TAS_REG_ERROR_STATUS */
[0x03]=	{1, 0},		/* TAS_REG_SYS_CONTROL_1 */
[0x04]=	{1, 1},		/* TAS_REG_SYS_CONTROL_2 */
[0x05]=	{1, 2},		/* TAS_REG_CH_CONFIG_1 */
[0x06]=	{1, 3},		/* TAS_REG_CH_CONFIG_2 */
[0x0b]=	{1, 4},		/* TAS_REG_CH_CONFIG_3 */
[0x0c]=	{1, 5},		/* TAS_REG_CH_CONFIG_4 */
[0x0d]=	{1, 6},		/* TAS_REG_HP_CONFIG */
[0x0e]=	{1, 0xff},	/* TAS_REG_SERIAL_CONTROL */
[0x0f]=	{1, 7},		/* TAS_REG_SOFT_MUTE */
[0x14]=	{1, 8},		/* TAS_REG_AUTO_MUTE */
[0x15]=	{1, 9},		/* TAS_REG_AUTO_MUTE_PWM */
[0x16]=	{1, 10},	/* TAS_REG_MODULATE_LIMIT */
[0x1b]=	{1, 11},	/* TAS_REG_IC_DELAY_1 */
[0x1c]=	{1, 12},	/* TAS_REG_IC_DELAY_2 */
[0x21]=	{1, 13},	/* TAS_REG_IC_DELAY_3 */
[0x22]=	{1, 14},	/* TAS_REG_IC_DELAY_4 */
[0x23]=	{1, 15},	/* TAS_REG_IC_OFFSET */
[0x40]=	{1, 16},	/* TAS_REG_BANK_SWITCH */
[0x41]=	{8, 1,},	/* TAS_REG_IN8X4_1 */
[0x42]=	{8, 2,},	/* TAS_REG_IN8X4_2 */
[0x47]=	{8, 3,},	/* TAS_REG_IN8X4_3 */
[0x48]=	{8, TAS_CACHE_2_MAX,},	/* TAS_REG_IN8X4_4 */
[0x49]=	{1, 17},	/* TAS_REG_IPMIX_1_TO_CH4 */
[0x4a]=	{1, 18},	/* TAS_REG_IPMIX_2_TO_CH4 */
[0x4b]=	{1, 19},	/* TAS_REG_IPMIX_3_TO_CH2 */
[0x4c]=	{1, 20},	/* TAS_REG_CH3_BP_BQ2 */
[0x4d]=	{1, 21},	/* TAS_REG_CH3_BP */
[0x4e]=	{1, 22},	/* TAS_REG_IPMIX_4_TO_CH12 */
[0x4f]=	{1, 23},	/* TAS_REG_CH4_BP_BQ2 */
[0x50]=	{1, 24},	/* TAS_REG_CH4_BP */
[0x51]=	{5, 1,},	/* TAS_REG_CH1_BQ_1 */
[0x52]=	{5, 2,},	/* TAS_REG_CH1_BQ_2 */
[0x53]=	{5, 3,},	/* TAS_REG_CH1_BQ_3 */
[0x54]=	{5, 4,},	/* TAS_REG_CH1_BQ_4 */
[0x55]=	{5, 5,},	/* TAS_REG_CH1_BQ_5 */
[0x56]=	{5, 6,},	/* TAS_REG_CH1_BQ_6 */
[0x57]=	{5, 7,},	/* TAS_REG_CH1_BQ_7 */
[0x58]=	{5, 8,},	/* TAS_REG_CH2_BQ_1 */
[0x59]=	{5, 9,},	/* TAS_REG_CH2_BQ_2	 */
[0x5a]=	{5, 10,},	/* TAS_REG_CH2_BQ_3 */
[0x5b]=	{5, 11,},	/* TAS_REG_CH2_BQ_4 */
[0x5c]=	{5, 12,},	/* TAS_REG_CH2_BQ_5 */
[0x5d]=	{5, 13,},	/* TAS_REG_CH2_BQ_6 */
[0x5e]=	{5, 14,},	/* TAS_REG_CH2_BQ_7 */
[0x7b]=	{5, 15,},	/* TAS_REG_CH3_BQ_1 */
[0x7c]=	{5, 16,},	/* TAS_REG_CH3_BQ_2 */
[0x7d]=	{5, 17,},	/* TAS_REG_CH3_BQ_3 */
[0x7e]=	{5, 18,},	/* TAS_REG_CH3_BQ_4 */
[0x7f]=	{5, 19,},	/* TAS_REG_CH3_BQ_5 */
[0x80]=	{5, 20,},	/* TAS_REG_CH3_BQ_6 */
[0x81]=	{5, 21,},	/* TAS_REG_CH3_BQ_7 */
[0x82]=	{5, 22,},	/* TAS_REG_CH4_BQ_1 */
[0x83]=	{5, 23,},	/* TAS_REG_CH4_BQ_2 */
[0x84]=	{5, 24,},	/* TAS_REG_CH4_BQ_3 */
[0x85]=	{5, 25,},	/* TAS_REG_CH4_BQ_4 */
[0x86]=	{5, 26,},	/* TAS_REG_CH4_BQ_5 */
[0x87]=	{5, 27,},	/* TAS_REG_CH4_BQ_6 */
[0x88]=	{5, 28,},	/* TAS_REG_CH4_BQ_7 */
[0x89]=	{2, 1,},	/* TAS_REG_BT_BYPASS_CH1 */
[0x8a]=	{2, 2,},	/* TAS_REG_BT_BYPASS_CH2 */
[0x8f]=	{2, 3,},	/* TAS_REG_BT_BYPASS_CH3 */
[0x90]=	{2, 4,},	/* TAS_REG_BT_BYPASS_CH4 */
[0x91]=	{1, 25,},	/* TAS_REG_LOUDNESS_LG */
[0x92]=	{2, 5,},	/* TAS_REG_LOUDNESS_LO */
[0x93]=	{1, 26,},	/* TAS_REG_LOUDNESS_G */
[0x94]=	{2, 6,},	/* TAS_REG_LOUDNESS_O */
[0x95]=	{5, 29,},	/* TAS_REG_LOUDNESS_BQ */
[0x96]=	{1, 27,},	/* TAS_REG_DRC1_CNTL_123 */
[0x97]=	{1, 28,},	/* TAS_REG_DRC2_CNTL_4 */
[0x98]=	{2, 7,},	/* TAS_REG_DRC1_ENERGY */
[0x99]=	{4, 3,},	/* TAS_REG_DRC1_THRESHOLD */
[0x9a]=	{3, 1,},	/* TAS_REG_DRC1_SLOPE */
[0x9b]=	{4, 4,},	/* TAS_REG_DRC1_OFFSET */
[0x9c]=	{4, 5,},	/* TAS_REG_DRC1_ATTACK */
[0x9d]=	{2, 8,},	/* TAS_REG_DRC2_ENERGY */
[0x9e]=	{4, 6,},	/* TAS_REG_DRC2_THRESHOLD */
[0x9f]=	{2, TAS_CACHE_3_MAX,},	/* TAS_REG_DRC2_SLOPE */
[0xa0]=	{4, 7,},	/* TAS_REG_DRC2_OFFSET */
[0xa1]=	{4, TAS_CACHE_2_MAX,},	/* TAS_REG_DRC2_ATTACK */
[0xa2]=	{2, 9,},	/* TAS_REG_DRC_BYPASS_1 */
[0xa3]=	{2, 10,},	/* TAS_REG_DRC_BYPASS_2 */
[0xa8]=	{2, 11,},	/* TAS_REG_DRC_BYPASS_3 */
[0xa9]=	{2, 12,},	/* TAS_REG_DRC_BYPASS_4 */
[0xaa]=	{2, 13,},	/* TAS_REG_SEL_OP14_S */
[0xab]=	{2, 14,},	/* TAS_REG_SEL_OP14_T */
[0xb0]=	{2, 15,},	/* TAS_REG_SEL_OP14_Y */
[0xb1]=	{2, TAS_CACHE_2_MAX,},	/* TAS_REG_SEL_OP14_Z */
[0xcf]=	{5, TAS_CACHE_5_MAX,},	/* TAS_REG_VOLUME_BQ */
[0xd0]=	{1, 29},	/* TAS_REG_VOL_TB_SLEW */
[0xd1]=	{1, 30},	/* TAS_REG_VOL_CH1 */
[0xd2]=	{1, 31},	/* TAS_REG_VOL_CH2 */
[0xd7]=	{1, 32},	/* TAS_REG_VOL_CH3 */
[0xd8]=	{1, 33},	/* TAS_REG_VOL_CH4 */
[0xd9]=	{1, 34},	/* TAS_REG_VOL_MASTER */
[0xda]=	{1, 35},	/* TAS_REG_BASS_SET */
[0xdb]=	{1, 36},	/* TAS_REG_BASS_INDEX */
[0xdc]=	{1, 37},	/* TAS_REG_TREBLE_SET */
[0xdd]=	{1, 38},	/* TAS_REG_TREBLE_INDEX */
[0xde]=	{1, 39},	/* TAS_REG_AM_MODE */
[0xdf]=	{1, 40},	/* TAS_REG_PSVC */
[0xe0]=	{1, TAS_CACHE_1_MAX,},	/* TAS_REG_GENERAL_CONTROL */
};

/* location of each variable length segment in the cache array */
#define TAS_CACHE_1_BASE 0
#define TAS_CACHE_2_BASE TAS_CACHE_1_BASE + (TAS_CACHE_1_MAX + 1)
#define TAS_CACHE_3_BASE TAS_CACHE_2_BASE + (TAS_CACHE_2_MAX + 1) * 2
#define TAS_CACHE_4_BASE TAS_CACHE_3_BASE + (TAS_CACHE_3_MAX + 1) * 3
#define TAS_CACHE_5_BASE TAS_CACHE_4_BASE + (TAS_CACHE_4_MAX + 1) * 4
#define TAS_CACHE_8_BASE TAS_CACHE_5_BASE + (TAS_CACHE_5_MAX + 1) * 5
#define TAS_CACHE_MAX TAS_CACHE_8_BASE + (TAS_CACHE_5_MAX + 1) * 8

/* tas5504 driver private data */
struct tas5504_priv {
	struct i2c_client *client;
	struct snd_soc_codec codec;

	/* performance shadow of i2c registers */
	u32 reg_cache[TAS_CACHE_MAX];
	u8 valid[TAS_CACHE_MAX];
};

/* these are using custom controls */
static const struct snd_kcontrol_new tas5504_snd_controls[] = {
	TAS_CTL_1R(0x00, 0, 0, "Clock Control"),
	TAS_CTL_1R(0x01, 0, 0, "General Status"),
	TAS_CTL_1(0x02, 0, 0, "Error Status"),
	TAS_CTL_1(0x03, 0, 0, "System Control 1"),
	TAS_CTL_1(0x04, 0, 0, "System Control 2"),
	TAS_CTL_1(0x05, 1, 0, "General Config"),
	TAS_CTL_1(0x06, 2, 0, "General Config"),
	TAS_CTL_1(0x0b, 3, 0, "General Config"),
	TAS_CTL_1(0x0c, 4, 0, "General Config"),
	TAS_CTL_1(0x0d, 0, 0, "Headphone Config"),
	TAS_CTL_1R(0x0e, 0, 0, "Serial Data Interface"),
	TAS_CTL_1(0x0f, 0, 0, "Soft Mute"),
	TAS_CTL_1(0x14, 0, 0, "Auto Mute"),
	TAS_CTL_1(0x15, 0, 0, "Auto Mute PWM"),
	TAS_CTL_1R(0x16, 0, 0, "Modulation"),
	TAS_CTL_1(0x1b, 1, 0, "Interchannel Delay"),
	TAS_CTL_1(0x1c, 2, 0, "Interchannel Delay"),
	TAS_CTL_1(0x21, 3, 0, "Interchannel Delay"),
	TAS_CTL_1(0x22, 4, 0, "Interchannel Delay"),
	TAS_CTL_1(0x23, 0, 0, "Interchannel Offset"),
	TAS_CTL_1(0x40, 4, 0, "Bank Switching"),
	TAS_CTL_8(0x41, 1, 0, "Input Mixer"),
	TAS_CTL_8(0x42, 2, 0, "Input Mixer"),
	TAS_CTL_8(0x47, 3, 0, "Input Mixer"),
	TAS_CTL_8(0x48, 4, 0, "Input Mixer"),
	TAS_CTL_1(0x49, 0, 0, "Bass ipmix_1_to_ch4"),
	TAS_CTL_1(0x4a, 0, 0, "Bass ipmix_2_to_ch4"),
	TAS_CTL_1(0x4b, 0, 0, "Bass ipmix_3_to_ch12"),
	TAS_CTL_1(0x4c, 0, 0, "Bass ch3_bp_bq2"),
	TAS_CTL_1(0x4d, 0, 0, "Bass ch3_bq2"),
	TAS_CTL_1(0x4e, 0, 0, "Bass ipmix_4_to_ch12"),
	TAS_CTL_1(0x4f, 0, 0, "Bass ch4_bp_bq2"),
	TAS_CTL_1(0x50, 0, 0, "Bass ch4_bq2"),
	TAS_CTL_5(0x51, 1, 1, "Biquad"),
	TAS_CTL_5(0x52, 1, 2, "Biquad"),
	TAS_CTL_5(0x53, 1, 3, "Biquad"),
	TAS_CTL_5(0x54, 1, 4, "Biquad"),
	TAS_CTL_5(0x55, 1, 5, "Biquad"),
	TAS_CTL_5(0x56, 1, 6, "Biquad"),
	TAS_CTL_5(0x57, 1, 7, "Biquad"),
	TAS_CTL_5(0x58, 2, 1, "Biquad"),
	TAS_CTL_5(0x59, 2, 2, "Biquad"),
	TAS_CTL_5(0x5a, 2, 3, "Biquad"),
	TAS_CTL_5(0x5b, 2, 4, "Biquad"),
	TAS_CTL_5(0x5c, 2, 5, "Biquad"),
	TAS_CTL_5(0x5d, 2, 6, "Biquad"),
	TAS_CTL_5(0x5e, 2, 7, "Biquad"),
	TAS_CTL_5(0x7b, 3, 1, "Biquad"),
	TAS_CTL_5(0x7c, 3, 2, "Biquad"),
	TAS_CTL_5(0x7d, 3, 3, "Biquad"),
	TAS_CTL_5(0x7e, 3, 4, "Biquad"),
	TAS_CTL_5(0x7f, 3, 5, "Biquad"),
	TAS_CTL_5(0x80, 3, 6, "Biquad"),
	TAS_CTL_5(0x81, 3, 7, "Biquad"),
	TAS_CTL_5(0x82, 4, 1, "Biquad"),
	TAS_CTL_5(0x83, 4, 2, "Biquad"),
	TAS_CTL_5(0x84, 4, 3, "Biquad"),
	TAS_CTL_5(0x85, 4, 4, "Biquad"),
	TAS_CTL_5(0x86, 4, 5, "Biquad"),
	TAS_CTL_5(0x87, 4, 6, "Biquad"),
	TAS_CTL_5(0x88, 4, 7, "Biquad"),
	TAS_CTL_2(0x89, 1, 0, "Bass/Treble Bypass"),
	TAS_CTL_2(0x8a, 2, 0, "Bass/Treble Bypass"),
	TAS_CTL_2(0x8f, 3, 0, "Bass/Treble Bypass"),
	TAS_CTL_2(0x90, 4, 0, "Bass/Treble Bypass"),
	TAS_CTL_1(0x91, 0, 0, "Loudness Log2 Gain"),
	TAS_CTL_1_64(0x92, 0, 0, "Loudness Log2 Offset"),
	TAS_CTL_1(0x93, 0, 0, "Loudness Gain"),
	TAS_CTL_1_64(0x94, 0, 0, "Loudness Offset"),
	TAS_CTL_5(0x95, 0, 0, "Loudness Biquad"),
	TAS_CTL_1(0x96, 0, 0, "DRC Control 1-3"),
	TAS_CTL_1(0x97, 0, 0, "DRC Control 4"),
	TAS_CTL_2(0x97, 0, 0, "DRC Energy"),
	TAS_CTL_2_64(0x97, 0, 0, "DRC Threshold"),
	TAS_CTL_3(0x97, 0, 0, "DRC Slope"),
	TAS_CTL_2_64(0x97, 0, 0, "DRC Offset"),
	TAS_CTL_4(0x97, 0, 0, "DRC Attack/Delay"),
	TAS_CTL_2(0x9d, 4, 0, "DRC Energy"),
	TAS_CTL_2_64(0x9e, 4, 0, "DRC Threshold"),
	TAS_CTL_3(0x9f, 4, 0, "DRC Slope"),
	TAS_CTL_2_64(0xa0, 4, 0, "DRC Offset"),
	TAS_CTL_4(0xa1, 4, 0, "DRC Attack/Delay"),
	TAS_CTL_2(0xa2, 1, 0, "DRC Bypass"),
	TAS_CTL_2(0xa3, 2, 0, "DRC Bypass"),
	TAS_CTL_2(0xa8, 3, 0, "DRC Bypass"),
	TAS_CTL_2(0xa9, 4, 0, "DRC Bypass"),
	TAS_CTL_2(0xaa, 1, 0, "Output Mixer"),
	TAS_CTL_2(0xab, 2, 0, "Output Mixer"),
	TAS_CTL_3(0xb0, 3, 0, "Output Mixer"),
	TAS_CTL_3(0xb1, 4, 0, "Output Mixer"),
	TAS_CTL_5(0xcf, 0, 0, "Volume Biquad"),
	TAS_CTL_1(0xd0, 0, 0, "Volume Slew"),
	TAS_CTL_1(0xd1, 1, 0, "Volume"),
	TAS_CTL_1(0xd2, 2, 0, "Volume"),
	TAS_CTL_1(0xd7, 3, 0, "Volume"),
	TAS_CTL_1(0xd8, 4, 0, "Volume"),
	SOC_SINGLE("PCM Playback Volume", 0xd9, 0, 0x3ff, 1),
	TAS_CTL_1(0xda, 0, 0, "Bass Filter Set"),
	TAS_CTL_1(0xdb, 0, 0, "Bass Filter Index"),
	TAS_CTL_1(0xdc, 0, 0, "Treble Filter Set"),
	TAS_CTL_1(0xdd, 0, 0, "Treble Filter Index"),
	TAS_CTL_1(0xde, 0, 0, "AM Mode"),
	TAS_CTL_1(0xdf, 0, 0, "PSCV Range"),
	TAS_CTL_1(0xe0, 0, 0, "General Control"),
};

root@phyCORE-MPC5200B-tiny:/sys cat ./devices/platform/soc-audio.0/codec_reg
tas5504 registers
 0:  54
 1:  03
 2:  78
 3:  90
 4:  00
 5:  e0
 6:  e0
 b:  e0
 c:  e0
 d:  00
 e:  05
 f:  00
14:  84
15:  05
16:  02
1b:  80
1c:  00
21:  e0
22:  60
23:  00
40:  0000ff00
41:  fffffff6 000000cf c3809000 c39e9e90 c01df494 c0338890 00000001 000000cf
42:  00000ae3 c3052000 c3809004 c39e9eb0 00000000 00000000 00000000 00000000
47:  00000000 00000000 00000000 00000000 00000000 00000000 00800000 00000000
48:  00000000 00000000 00000000 00000000 00000000 00000000 00000000 00800000
49:  00000000
4a:  00000000
4b:  00000000
4c:  00000000
4d:  00800000
4e:  00000000
4f:  00000000
50:  00800000
51:  fffffff6 000000a0 c3809000 00000000 00000000
52:  00800000 00000000 00000000 00000000 00000000
53:  00800000 00000000 00000000 00000000 00000000
54:  00800000 00000000 00000000 00000000 00000000
55:  00800000 00000000 00000000 0000883f 007f77c0
56:  00000056 003fffa8 c39e9e70 c01324a4 03000000
57:  c39e9e78 c39e9e50 c38ebfc0 a1052000 00000000
58:  00000000 fffffff6 000000a1 c3809000 00000000
59:  00800000 00000000 00000000 00000000 00000000
5a:  00800000 00000000 00000000 00000000 00000000
5b:  00800000 00000000 00000000 00000000 00000000
5c:  00800000 00000000 00000000 00000000 00000000
5d:  00800000 00000000 00000000 00000000 00000000
5e:  00800000 00000000 00000000 00000000 00000000
7b:  00800000 00000000 00000000 00000000 00000000
7c:  00800000 00000000 00000000 00000000 00000000
7d:  00800000 00000000 00000000 00000000 00000000
7e:  00800000 00000000 00000000 00000000 00000000
7f:  00800000 00000000 00000000 00000000 00000000
80:  00800000 00000000 00000000 00000000 00000000
81:  00800000 00000000 00000000 00000000 00000000
82:  00800000 00000000 00000000 00000000 00000000
83:  00800000 00000000 00000000 00000000 00000000
84:  00800000 00000000 00000000 00000000 00000000
85:  00800000 00000000 00000000 00000000 00000000
86:  00800000 00000000 00000000 00000000 00000005
87:  00800000 00000000 00000000 00000000 00000000
88:  00800000 00000000 00000000 00000000 00000000
89:  00800000 00000000
8a:  00400000 0fc00000
8f:  00000005 00000028
90:  00800000 00000000
91:  0fc00000
92:  00000000 00000000
93:  00000000
94:  00000000 00000000
95:  0000d513 00000000 0fff2aed 00fe5045 0f81aa27
96:  00000000
97:  00000000
98:  0000883f 007f77c0
99:  00000000 0b20e2b2 00000000 06f9de58
9a:  00400000 0fc00000 0f900000
9b:  0000ffff ff823098 00000000 0195b2c0
9c:  0000883f 007f77c0 00000056 003fffa8
9d:  0000883f 007f77c0
9e:  00000000 0b20e2b2 00000000 06f9de58
9f:  00400000 0fc00000
a0:  0000ffff ff823098 00000000 0195b2c0
a1:  0000883f 007f77c0 00000056 003fffa8
a2:  00800000 00000000
a3:  00800000 00000000
a8:  00800000 00000000
a9:  00800000 00000000
aa:  00800000 00000000
ab:  10800000 00000000
b0:  60800000 00000000
b1:  70800000 00000000
cf:  00800000 00000000 00000000 00000000 00000000
d0:  0000013f
d1:  00000048
d2:  00000048
d7:  00000048
d8:  00000048
d9:  00000245
da:  03030303
db:  12121212
dc:  03030303
dd:  12121212
de:  00000000
df:  00000002
e0:  00000000
root@phyCORE-MPC5200B-tiny:/sys



-- 
Jon Smirl
jonsmirl@gmail.com
