From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: fsl_sai: add i.MX8M support
Date: Mon, 22 Jul 2019 13:39:44 +0300
Message-ID: <CAEnQRZBXjXPq6UL2tPshOtoRu4SJ3XZ8DRVnw13fyi3SL_EqXA@mail.gmail.com>
References: <20190717105635.18514-1-l.stach@pengutronix.de>
 <20190717105635.18514-4-l.stach@pengutronix.de>
 <18b4d49b410248766e834f3a0444e106@akkea.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1C178F800F5
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 12:39:55 +0200 (CEST)
Received: by mail-wr1-x443.google.com with SMTP id r1so38864814wrl.7
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 03:39:55 -0700 (PDT)
In-Reply-To: <18b4d49b410248766e834f3a0444e106@akkea.ca>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Angus Ainslie <angus@akkea.ca>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, patchwork-lst@pengutronix.de, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 18, 2019 at 1:36 PM Angus Ainslie <angus@akkea.ca> wrote:
>
> On 2019-07-17 04:56, Lucas Stach wrote:
> > The SAI block on the i.MX8M moved the register layout, as 2 version
> > registers were added at the start of the register map. We deal with
> > this by moving the start of the regmap, so both register layouts
> > look the same to accesses going through the regmap.
> >
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>
> checkpatch has a complaint about mixing code and device tree bindings.

Hello Angus, Lucas,

What imx-sdma firmware have you used to test this with linux-next? I've
finished my changes but aplay gets stuck sending the first audio frame.

Daniel.
