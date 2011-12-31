From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: pxa: Convert corgi to use
	snd_soc_register_card()
Date: Sat, 31 Dec 2011 08:16:25 +0800
Message-ID: <CAN1soZwCxJVCKxSwH=s2UNnp5MaoFCawRZL4SdhT7Cbo9E4nUg@mail.gmail.com>
References: <1325214804.2569.3.camel@phoenix> <1325215093.2569.8.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E41B103B0A
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2011 01:16:25 +0100 (CET)
Received: by vcbf13 with SMTP id f13so10047368vcb.38
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2011 16:16:25 -0800 (PST)
In-Reply-To: <1325215093.2569.8.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@marvell.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 30, 2011 at 11:18 AM, Axel Lin <axel.lin@gmail.com> wrote:
> Use snd_soc_register_card() instead of creating a "soc-audio" platform de=
vice.
>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> =A0arch/arm/mach-pxa/corgi.c | =A0 =A09 +++++++++
> =A0sound/soc/pxa/corgi.c =A0 =A0 | =A0 43 +++++++++++++++++++++++--------=
------------
> =A02 files changed, 32 insertions(+), 20 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
