From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/2] ASoC: New enum type for bitfield coded
	enums
Date: Mon,  5 Jan 2009 09:54:56 +0200
Message-ID: <1231142098-16886-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 37FEC2415A
	for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2009 08:55:08 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@sirena.org.uk, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hello,

The first patch adds new enum type to handle non enum coded enums.
The twl4030 codec for example have some of it's input/output mux settings
in a bitfiled, which can not be handled by the standard enum type.

The second patch converts the twl4030 bitfield enums to the new value_enum type.

Technically it could be possible to add the new members (mask, *values) to the
existing soc_enum structure, which could reduce the amount of new code needed to
handle this new type. At least the snd_soc_info_value_enum_double,
dapm_connect_value_mux, dapm_value_mux_update_power functions can be removed if
I modify the soc_enum instead of introducing the new soc_value_enum.

The new type is quite flexible: one can define the normal enum types also with
the VALUE_ENUM (although it does not make any sense):

/* Normal enum */
static const char *normal_mux_texts[] =
		{"Off", "mux1", "mux2", "mux3"};

static const unsigned int normal_mux_values[] =
		{0x0, 0x1, 0x2, 0x3};

static const struct soc_value_enum normal_mux_enum =
	SOC_VALUE_ENUM_SINGLE(REGISTER, 0, 0x3,
			ARRAY_SIZE(normal_mux_texts),
			normal_mux_texts,
			normal_mux_values);

But it makes more sense if one wants to handle the bitfiled
(from twl4030 codec):

/* PreDrive Right */
static const char *twl4030_predriver_texts[] =
		{"Off", "DACR1", "DACR2", "DACL2"};

static const unsigned int twl4030_predriver_values[] =
		{0x0, 0x1, 0x2, 0x4};

static const struct soc_value_enum twl4030_predriver_enum =
	SOC_VALUE_ENUM_SINGLE(TWL4030_REG_PREDR_CTL, 1, 0x7,
			ARRAY_SIZE(twl4030_predriver_texts),
			twl4030_predriver_texts,
			twl4030_predriver_values);

static const struct snd_kcontrol_new twl4030_dapm_predriver_control =
SOC_DAPM_VALUE_ENUM("Route", twl4030_predriver_enum);
