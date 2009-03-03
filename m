From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH 2/4] ASoC: UDA1380: DATAI is slave only
Date: Tue, 3 Mar 2009 16:56:58 +0100
Message-ID: <74d0deb30903030756m270dc300q335f38d896de096f@mail.gmail.com>
References: <1236093054-1952-1-git-send-email-philipp.zabel@gmail.com>
	<1236093054-1952-2-git-send-email-philipp.zabel@gmail.com>
	<20090303155054.GA19642@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f158.google.com (mail-gx0-f158.google.com
	[209.85.217.158])
	by alsa0.perex.cz (Postfix) with ESMTP id DF628103849
	for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2009 16:56:59 +0100 (CET)
Received: by gxk2 with SMTP id 2so5510650gxk.8
	for <alsa-devel@alsa-project.org>; Tue, 03 Mar 2009 07:56:59 -0800 (PST)
In-Reply-To: <20090303155054.GA19642@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 3, 2009 at 4:50 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Mar 03, 2009 at 04:10:52PM +0100, Philipp Zabel wrote:
>
>> - =A0 =A0 if ((fmt & SND_SOC_DAIFMT_MASTER_MASK) =3D=3D SND_SOC_DAIFMT_C=
BM_CFM)
>> - =A0 =A0 =A0 =A0 =A0 =A0 iface |=3D R01_SIM;
>> + =A0 =A0 /* DATAI is slave only, so in single-link mode, this has to be=
 slave */
>> + =A0 =A0 if ((fmt & SND_SOC_DAIFMT_MASTER_MASK) !=3D SND_SOC_DAIFMT_CBS=
_CFS)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>
> Hrm, is R01_SIM not required to be set? =A0I've no idea what it does so
> quite possibly.

R01_SIM sets the UDA1380's digital output interface to master.
This is not allowed if both input and output use a single DAI
(uda1380_set_dai_fmt_both), because the input interface is slave only.

Only uda1380_set_dai_fmt_capture should accept the CBM_CFM setting.

regards
Philipp
