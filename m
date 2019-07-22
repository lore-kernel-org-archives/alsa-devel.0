From: Angus Ainslie <angus@akkea.ca>
Subject: Re: [PATCH 3/3] ASoC: fsl_sai: add i.MX8M support
Date: Mon, 22 Jul 2019 06:41:24 -0700
Message-ID: <0b25c90b0a9bd77849ae76e1fe06340e@akkea.ca>
References: <20190717105635.18514-1-l.stach@pengutronix.de>
 <20190717105635.18514-4-l.stach@pengutronix.de>
 <18b4d49b410248766e834f3a0444e106@akkea.ca>
 <CAEnQRZBXjXPq6UL2tPshOtoRu4SJ3XZ8DRVnw13fyi3SL_EqXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from node.akkea.ca (node.akkea.ca [192.155.83.177])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9D231F8015B
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 15:41:26 +0200 (CEST)
In-Reply-To: <CAEnQRZBXjXPq6UL2tPshOtoRu4SJ3XZ8DRVnw13fyi3SL_EqXA@mail.gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, patchwork-lst@pengutronix.de, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

Hi Daniel,

On 2019-07-22 03:39, Daniel Baluta wrote:
> On Thu, Jul 18, 2019 at 1:36 PM Angus Ainslie <angus@akkea.ca> wrote:
>> 
>> On 2019-07-17 04:56, Lucas Stach wrote:
>> > The SAI block on the i.MX8M moved the register layout, as 2 version
>> > registers were added at the start of the register map. We deal with
>> > this by moving the start of the regmap, so both register layouts
>> > look the same to accesses going through the regmap.
>> >
>> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>> 
>> checkpatch has a complaint about mixing code and device tree bindings.
> 
> Hello Angus, Lucas,
> 
> What imx-sdma firmware have you used to test this with linux-next? I've
> finished my changes but aplay gets stuck sending the first audio frame.
> 

I'm just using the ROM firmware, I have no additional firmware in the 
filesystem.

Angus

> Daniel.
