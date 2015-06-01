From: Jun Nie <jun.nie@linaro.org>
Subject: Re: [PATCH v3 6/6] ASoC: zx: add zx296702 hdmi codec
Date: Mon, 1 Jun 2015 09:42:34 +0800
Message-ID: <CABymUCNvM=k4tWJutpzoK-VFvKhBC4EGjh_OzWYMMRppUqvSOA@mail.gmail.com>
References: <1432906281-27698-1-git-send-email-jun.nie@linaro.org>
 <1432906281-27698-7-git-send-email-jun.nie@linaro.org>
 <5568736E.5090801@metafoo.de>
 <20150529151806.GO21577@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f44.google.com (mail-la0-f44.google.com
 [209.85.215.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BE38261606
 for <alsa-devel@alsa-project.org>; Mon,  1 Jun 2015 03:42:35 +0200 (CEST)
Received: by laei3 with SMTP id i3so3048697lae.3
 for <alsa-devel@alsa-project.org>; Sun, 31 May 2015 18:42:34 -0700 (PDT)
In-Reply-To: <20150529151806.GO21577@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, "wan.zhijun" <wan.zhijun@zte.com.cn>, Liam Girdwood <lgirdwood@gmail.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

2015-05-29 23:18 GMT+08:00 Mark Brown <broonie@kernel.org>:
> On Fri, May 29, 2015 at 04:10:54PM +0200, Lars-Peter Clausen wrote:
>> On 05/29/2015 03:31 PM, Jun Nie wrote:
>
>> >Add zx296702 hdmi codec to enable SPDIF and I2S output
>> >via HDMI. The SPDIF/I2S route is exclusive with current
>> >software config and need specify which is valid in
>> >defconfig.
>
>> That's an issue, the hardware configuration should not depend on kernel
>> configuration setting. This makes it impossible to run the same kernel on
>> platforms with conflicting settings. It should be possible to configure this
>> dynamically at boot time based on platform_data/devicetree, etc.
>
>> But is this device real hardware anyway?
It is a ready hardware with HDMI audio configured either from internal
SPDIF or I2S interface. Because DAI and CODEC are totally independent
in ASoC design, so CODEC does not know what DAI interface is active. I
guess I can add a dts property to indicate that from machine dts
config.
>
> See previous discussions - the SoC has an internal HDMI encoder
> connected to a S/PDIF IP which can also be brought out directly as that.
> The solution suggested in the previous discussions was to represent the
> HDMI IP as a CODEC and connect the S/PDIF IP up to it with a machine
> driver, I've not looked at this patch yet though.

So I need implement dai link in machine audio card driver, while not
use simple card and device tree initialization. In this way, I surely
can embed HDMI audio codec in HDMI driver. Is that right?

I had try to initialize audio all from dts, so need a HDMI codec dt
node to connect with DAI. However, I cannot find a way to create an
independent HDMI CODEC dt node because it is brought up from HDMI
driver. If my above understanding is correct, a machine level DAI link
shall resolve this issue with dropping simple card and DAI link in
dts. Thanks for your comments!

BTW: HDMI driver is far from mature, so you did not see HDMI function
implementation in this patch serial.

Jun
