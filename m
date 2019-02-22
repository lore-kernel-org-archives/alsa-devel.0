From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: simple-audio-card,mclk-fs
Date: Fri, 22 Feb 2019 17:16:46 +0200
Message-ID: <CAEnQRZDpJu27_pB=-ZYQjsNPC8eA4-Ur-36niT2hCosMWtC7jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 95F94F807B6
 for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2019 16:16:58 +0100 (CET)
Received: by mail-ed1-x535.google.com with SMTP id d9so2004635edh.12
 for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2019 07:16:58 -0800 (PST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, dl-linux-imx <linux-imx@nxp.com>
List-Id: alsa-devel@alsa-project.org

Hello Morimoto-san,

Do you have any plans on adding support for multiple mclk-fs values
in simple-card?

Usually one constant mclk-fs value is not enough because usually codecs
have different value depending on rate.

For example, for wm8524 [1] one can use
mclk-fs = 256 for rates between 8kHz and 96kHz
but it needs to change mclk-fs = 128 for 176.4hHz
and 192kHz.

I am thinking of something like this:

--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -44,6 +44,8 @@
                compatible = "simple-audio-card";
                simple-audio-card,name = "wm8524-audio";
                simple-audio-card,format = "i2s";
+               simple-audio-card,lrclk-fs = <8000>, <32000>, <44100>
<48000>, <96000>, <176400>, <192000>;
+               simple-audio-card,mclk-fs = <256>, <256>, <256>,
<256>, <256>, <128>, <128>;

Let me know if this would be a good direction and I will send a patch.

thanks,
Daniel.
[1] https://www.cirrus.com/products/wm8524/
