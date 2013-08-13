From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v4 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Date: Tue, 13 Aug 2013 16:01:14 -0300
Message-ID: <CAOMZO5AqUcKYD8Rx_NV5=r3soBaScDY5PxD0SS_HEyYpf_PpbQ@mail.gmail.com>
References: <1376308870-14232-1-git-send-email-b42378@freescale.com>
 <1376308870-14232-2-git-send-email-b42378@freescale.com>
 <CAOMZO5A7noEb98yuCPY6o2mf-FikFcMYiDLpg3huPKHMO7Fwdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f41.google.com (mail-vb0-f41.google.com
 [209.85.212.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 11E6B2619D6
 for <alsa-devel@alsa-project.org>; Tue, 13 Aug 2013 21:01:15 +0200 (CEST)
Received: by mail-vb0-f41.google.com with SMTP id g17so6900685vbg.14
 for <alsa-devel@alsa-project.org>; Tue, 13 Aug 2013 12:01:15 -0700 (PDT)
In-Reply-To: <CAOMZO5A7noEb98yuCPY6o2mf-FikFcMYiDLpg3huPKHMO7Fwdw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, timur@tabi.org, rob.herring@calxeda.com, broonie@kernel.org, p.zabel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 13, 2013 at 2:58 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Mon, Aug 12, 2013 at 9:01 AM, Nicolin Chen <b42378@freescale.com> wrote:
>> +Required properties:
>> +
>> +  - compatible : Compatible list, contains "fsl,<chip>-spdif". Using general
>
> Can't we just use "fsl,fsl-spdif" instead?

Or maybe "fsl,imx35-spdif", since mx35 was the first imx SoC with this
spdif IP block.
