From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: soc.h macros
Date: Sat, 26 Jul 2008 00:26:13 -0400
Message-ID: <9e4733910807252126q4c4a045bp146452d9789fa8de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.231])
	by alsa0.perex.cz (Postfix) with ESMTP id 793042462C
	for <alsa-devel@alsa-project.org>;
	Sat, 26 Jul 2008 06:26:14 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 36so2572410wra.24
	for <alsa-devel@alsa-project.org>; Fri, 25 Jul 2008 21:26:13 -0700 (PDT)
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
To: ALSA-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Can you help me document these macros?

For example what does TLV stand for? I know it supplies a decibel range.
R really mean two registers. What does EXT do?
How about S8?

#define SOC_SINGLE(xname, reg, shift, max, invert)
#define SOC_SINGLE_TLV(xname, reg, shift, max, invert, tlv_array)
#define SOC_DOUBLE(xname, xreg, shift_left, shift_right, xmax, xinvert)
#define SOC_DOUBLE_R(xname, reg_left, reg_right, xshift, xmax, xinvert)
#define SOC_DOUBLE_TLV(xname, xreg, shift_left, shift_right, xmax,
xinvert, tlv_array)
#define SOC_DOUBLE_R_TLV(xname, reg_left, reg_right, xshift, xmax,
xinvert, tlv_array)
#define SOC_DOUBLE_S8_TLV(xname, xreg, xmin, xmax, tlv_array)
#define SOC_ENUM(xname, xenum)
#define SOC_SINGLE_EXT(xname, xreg, xshift, xmax, xinvert,
xhandler_get, xhandler_put)
#define SOC_SINGLE_EXT_TLV(xname, xreg, xshift, xmax, xinvert,
xhandler_get, xhandler_put, tlv_array)
#define SOC_SINGLE_BOOL_EXT(xname, xdata, xhandler_get, xhandler_put)
#define SOC_ENUM_EXT(xname, xenum, xhandler_get, xhandler_put)

SOC_ENUM("3D Function", wm8753_enum[5]),
SOC_ENUM seems really inefficient tracking those enum numbers.
Could you declare the enum in place?

#define SOC_ENUM_SINGLE(xname, xreg, xshift, xmax, xtexts) \
{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname,\
	.info = snd_soc_info_enum_double, \
	.get = snd_soc_get_enum_double, .put = snd_soc_put_enum_double, \
	.private_value = (unsigned long) &(struct soc_enum) \
	.reg = xreg, .shift_l = xshift, .shift_r = xshift, \
	.max = xmax, .texts = xtexts }

Is it possible to turn all of these macros into inline functions? Can
an inline initialize a structure? Making them inlines would get us
syntax checking without expansion.

I'm having some success getting 32b wide controls working.

-- 
Jon Smirl
jonsmirl@gmail.com
