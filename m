From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: [PATCH 0/2] arm64: allwinner: a64: Rename hpvcc-supply
 to cpvdd-supply
Date: Wed, 13 Feb 2019 15:04:55 +0800
Message-ID: <20190213070457.26049-1-wens@csie.org>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBBIMDR7RQKGQEWYG6BIQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi everyone,

This is a small series to fix the CPVDD regulator supply name for the
A64 codec. The datasheet specifies the name "CPVDD" for the supply rail
for the audio codec's internal headphone amp charge pump.

Somehow I managed to write "CPVDD" in the commit message and the device
tree binding, but used "HPVCC" (which is the name used by the A33) in
the device tree files and the device driver. (facepalm)

This feature was just introduced in v5.0-rc1, so if we could merge this
as fixes for v5.0 that would be great.

Thanks, and sorry for the blunder on my part.


Regards
ChenYu


Chen-Yu Tsai (2):
  ASoC: sunxi: sun50i-codec-analog: Rename hpvcc regulator supply to
    cpvdd
  arm64: dts: allwinner: a64: Rename hpvcc-supply to cpvdd-supply

 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts       | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts     | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi      | 2 +-
 sound/soc/sunxi/sun50i-codec-analog.c                     | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.20.1
