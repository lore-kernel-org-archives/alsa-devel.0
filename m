From: Wente Wang <wente.wang@nxp.com>
Subject: Re: [PATCH 0/2] Support non-ssi cpu-dai for sgtl5000
Date: Tue, 30 Aug 2016 12:31:00 +0000
Message-ID: <AM3PR04MB5299DB1A46C9EB79B5131BA8FE00@AM3PR04MB529.eurprd04.prod.outlook.com>
References: <1472467915-21317-1-git-send-email-wente.wang@nxp.com>
 <CAOMZO5B3FDPxm301Hwb+ZVOwYDAMU0vjcVAG0hH36Rf2+s0VDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00076.outbound.protection.outlook.com [40.107.0.76])
 by alsa0.perex.cz (Postfix) with ESMTP id 15F6A266C28
 for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2016 14:31:02 +0200 (CEST)
In-Reply-To: <CAOMZO5B3FDPxm301Hwb+ZVOwYDAMU0vjcVAG0hH36Rf2+s0VDA@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Fabio Estevam [mailto:festevam@gmail.com]
> Subject: Re: [PATCH 0/2] Support non-ssi cpu-dai for sgtl5000
> 
> On Mon, Aug 29, 2016 at 7:51 AM, Winter Wang <wente.wang@nxp.com> wrote:
> > These patches support sgtl5000 to be attached to other non-ssi cpu-dais
> like SAI.
> 
> Do we really need this?
> 
> We can use SAI with sgtl5000 just fine via simple card. Take a look at:
> https://git.kernel.org/cgit/linux/kernel/git/shawnguo/linux.git/commit/arch/
> arm/boot/dts/imx6ul-14x14-
> evk.dts?h=imx/fixes&id=bf3251e112a0139c8dec796c9f12f2e8f01a73ca

Thanks, that's another approach. 
This patch set is not needed.
