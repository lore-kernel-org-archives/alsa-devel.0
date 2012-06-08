From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v1 4/5] ASoC: add mmp brownstone support
Date: Fri, 8 Jun 2012 21:24:19 +0800
Message-ID: <CAMj5BkhB+ifYpV5Cv0w_sp-eGdmBhbtJdmdGPfpZygyHfzQBAQ@mail.gmail.com>
References: <1338791851-21038-1-git-send-email-zhangfei.gao@marvell.com>
	<1338791851-21038-5-git-send-email-zhangfei.gao@marvell.com>
	<20120607221325.GB14525@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
	[209.85.212.173])
	by alsa0.perex.cz (Postfix) with ESMTP id E114E24429
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Jun 2012 15:24:20 +0200 (CEST)
Received: by wibhj6 with SMTP id hj6so458499wib.2
	for <alsa-devel@alsa-project.org>; Fri, 08 Jun 2012 06:24:20 -0700 (PDT)
In-Reply-To: <20120607221325.GB14525@opensource.wolfsonmicro.com>
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

On Fri, Jun 8, 2012 at 6:13 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Jun 04, 2012 at 02:37:30PM +0800, Zhangfei Gao wrote:
>
> One small thing here...
>
>> + =A0 =A0 ret =3D snd_soc_add_card_controls(dapm->card, brownstone_dapm_=
control,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ARRAY_S=
IZE(brownstone_dapm_control));
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>
> You can just set these up with the controls member of the card struct.

Great, it will make it easier, thanks.

>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
