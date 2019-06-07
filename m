From: Tzung-Bi Shih <tzungbi@google.com>
Subject: Re: [PATCH v2 000/146] ASoC: modern dai_link style
	support
Date: Fri, 7 Jun 2019 23:32:02 +0800
Message-ID: <CA+Px+wVQ_MWL6wnycqxksD2K4iJ7OfQ3vCbBYrp86W0s_E5vKQ@mail.gmail.com>
References: <87h893mkvi.wl-kuninori.morimoto.gx@renesas.com>
 <CAOMZO5A=zi_6OtjwWXJcbHn+AKz3SvmKgQrSemd6qWjAePuqXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F22A5F896CE
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2019 17:32:16 +0200 (CEST)
Received: by mail-ot1-x343.google.com with SMTP id p4so2253493oti.0
 for <alsa-devel@alsa-project.org>; Fri, 07 Jun 2019 08:32:16 -0700 (PDT)
In-Reply-To: <CAOMZO5A=zi_6OtjwWXJcbHn+AKz3SvmKgQrSemd6qWjAePuqXQ@mail.gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 7, 2019 at 9:23 PM Fabio Estevam <festevam@gmail.com> wrote:
> We are seeing kernel crash in today's linux-next and it looks like it
> is related to this series:
> https://storage.kernelci.org/next/master/next-20190607/arm/imx_v6_v7_defconfig/gcc-8/lab-pengutronix/boot-imx53-qsrb.html
The kernel crash is caused by a merge conflict was not resolved
correctly.  See this series
https://mailman.alsa-project.org/pipermail/alsa-devel/2019-June/150747.html
