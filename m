From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v3] ASoC: imx-wm8958: add imx-wm8958
 machine driver
Date: Thu, 3 Mar 2016 23:40:26 -0800
Message-ID: <20160304074025.GA3417@Asurada-CZ80>
References: <9b1b024d840efa5e4b2af200a1522f22a54a85ce.1456986762.git.zidan.wang@freescale.com>
 <20160303184057.GB19755@Asurada-Nvidia>
 <AM3PR04MB14126EE74869807A6B82AE489ABE0@AM3PR04MB1412.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f170.google.com (mail-pf0-f170.google.com
 [209.85.192.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 01C3B265475
 for <alsa-devel@alsa-project.org>; Fri,  4 Mar 2016 08:40:32 +0100 (CET)
Received: by mail-pf0-f170.google.com with SMTP id x188so7147492pfb.2
 for <alsa-devel@alsa-project.org>; Thu, 03 Mar 2016 23:40:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AM3PR04MB14126EE74869807A6B82AE489ABE0@AM3PR04MB1412.eurprd04.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@nxp.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, Zidan Wang <zidan.wang@freescale.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 04, 2016 at 07:15:44AM +0000, Zidan Wang wrote:

> > cpu-dai1	: The phandle of an CPU DAI controller for AIF1
> > cpu-dai2	: The phandle of an CPU DAI controller for AIF2
> > cpu-dai3	: The phandle of an CPU DAI controller for AIF3
> > 
> > > +	data->card.num_links = DAI_LINK_NUM;
> > > +	data->card.dai_link = data->dai_link;
> > 
> > Then, rather than hard coding the total DAI link number and creating
> > useless dummy links, you may create the links dynamically according to
> > the presence of the three properties above.
> 
> I don't know how to using cpu-dai1/2/3. There don't have voice and bt controller on the IMX cpu, don't have such cpu nodes.
> Do you means our hardware connection are wrong, and we must have voice and bt controller on the cpu?

Okay. I was trying to give you an excuse to have all three
aifs included, as I thought you might eventually need them
to *connect* something via DT. If you think you don't have
any idea to pre-allocate these links, you probably should
ignore my suggestion here and just follow Mark's comments:

[ Why are you mapping in dummy DAIs?  If these devices aren't connected
  then they're not connected and you shouldn't represent them.  If they
  are connected to something then describe those connections, possibly in
  followup patches if you have other devices you need to support upstream
  first. ]
