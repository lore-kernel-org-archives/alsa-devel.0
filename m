From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v1 3/5] ASOC: mmp: add sspa support
Date: Fri, 8 Jun 2012 21:28:12 +0800
Message-ID: <CAMj5Bkg7cSaEHm+mz-9ah85J83rQFiw1QNxMP5RBa8BiYJhoqw@mail.gmail.com>
References: <1338791851-21038-1-git-send-email-zhangfei.gao@marvell.com>
	<1338791851-21038-4-git-send-email-zhangfei.gao@marvell.com>
	<20120607221019.GA14525@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id ED85124433
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Jun 2012 15:28:12 +0200 (CEST)
Received: by lagw12 with SMTP id w12so1158648lag.38
	for <alsa-devel@alsa-project.org>; Fri, 08 Jun 2012 06:28:12 -0700 (PDT)
In-Reply-To: <20120607221019.GA14525@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Leo Yan <leoy@marvell.com>, Vinod Koul <vinod.koul@intel.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, alsa-devel@vger.kernel.org, Qiao Zhou <zhouqiao@marvell.com>, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@ti.com>, Chao Xie <cxie4@marvell.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 8, 2012 at 6:10 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Jun 04, 2012 at 02:37:29PM +0800, Zhangfei Gao wrote:
>> The SSPA is a configurable multi-channel audio serial (TDM) interface.
>> It's configurable at runtime to support up to 128 channels and the
>> number of bits per sample: 8, 12, 16, 20, 24 and 32 bits. It also
>> support stereo format: I2S, left-justified or right-justified.
>
> This looks mostly good (though you want to check your indentation a bit)
> but...
>
>> +static int __init mmp_sspa_modinit(void)
>> +{
>> + =A0 =A0 audio_clk =3D clk_get(NULL, "mmp-audio");
>> + =A0 =A0 if (IS_ERR(audio_clk))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(audio_clk);
>> +
>> + =A0 =A0 sysclk =3D clk_get(NULL, "mmp-sysclk");
>> + =A0 =A0 if (IS_ERR(sysclk))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(sysclk);
>> + =A0 =A0 clk_enable(audio_clk);
>
> You should be doing this stuff from the driver, not from the module init
> (and ideally you'd be managing the audio clock dynamically). =A0Even if
> it's the same clock every time in current silicon it's still a good idea
> to do this from a quality of implementation point of view.

Thanks, will remove the module init, and move clk staff to probe.
However, dynamically control audio_clk make audio subsystem works abnormall=
y.
