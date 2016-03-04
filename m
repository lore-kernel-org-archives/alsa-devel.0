From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v3] ASoC: imx-wm8958: add imx-wm8958
 machine driver
Date: Fri, 4 Mar 2016 10:39:09 -0800
Message-ID: <20160304183908.GA19471@Asurada-Nvidia>
References: <9b1b024d840efa5e4b2af200a1522f22a54a85ce.1456986762.git.zidan.wang@freescale.com>
 <20160303184057.GB19755@Asurada-Nvidia>
 <AM3PR04MB14126EE74869807A6B82AE489ABE0@AM3PR04MB1412.eurprd04.prod.outlook.com>
 <20160304074025.GA3417@Asurada-CZ80>
 <AM3PR04MB141215C4579299C18BF68C679ABE0@AM3PR04MB1412.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 by alsa0.perex.cz (Postfix) with ESMTP id DC86C2657B4
 for <alsa-devel@alsa-project.org>; Fri,  4 Mar 2016 19:38:56 +0100 (CET)
Received: by mail-pa0-f52.google.com with SMTP id bj10so39255662pad.2
 for <alsa-devel@alsa-project.org>; Fri, 04 Mar 2016 10:38:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AM3PR04MB141215C4579299C18BF68C679ABE0@AM3PR04MB1412.eurprd04.prod.outlook.com>
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

On Fri, Mar 04, 2016 at 08:54:10AM +0000, Zidan Wang wrote:
> On Friday, March 04, 2016 3:40 PM,  Nicolin Chen wrote:
> 
> > > > cpu-dai1	: The phandle of an CPU DAI controller for AIF1
> > > > cpu-dai2	: The phandle of an CPU DAI controller for AIF2
> > > > cpu-dai3	: The phandle of an CPU DAI controller for AIF3
> > > >
> > > > > +	data->card.num_links = DAI_LINK_NUM;
> > > > > +	data->card.dai_link = data->dai_link;
> > > >
> > > > Then, rather than hard coding the total DAI link number and creating
> > > > useless dummy links, you may create the links dynamically according
> > > > to the presence of the three properties above.
> > >
> > > I don't know how to using cpu-dai1/2/3. There don't have voice and bt
> > controller on the IMX cpu, don't have such cpu nodes.
> > > Do you means our hardware connection are wrong, and we must have voice
> > and bt controller on the cpu?
> > 
> > Okay. I was trying to give you an excuse to have all three aifs included,
> > as I thought you might eventually need them to *connect* something via DT.
> > If you think you don't have any idea to pre-allocate these links, you
> > probably should ignore my suggestion here and just follow Mark's comments:
> 
>  I am just confused by our hardward connection. If dummy cpu dai is not ok, I think I should follow your suggestion.
> 
>  If we want to keep our hardware connection, which bt and voice directly connect to codec, and don't have bt and voice controller.
>  What's the best way? 

The only way to keep them while not having BT and voice controllers
is just what I suggested you to make it through DT. Devicetree is a
script to reflect your exact hardware connections. You can dis-link
them for now in the DT as they are not "connected" in your current
design and then link them whenever you get them connected -- I think
there should be connections since you are using a validation board.
You just don't have the extension board or something. So you may
try to reach your hardware team, especially designer, for detail.

The idea here is similar to the ASRC links in fsl-asoc-card driver:
users can drop ASRC by merely removing the asrc phandle in the DT,
depending on their board design or requirement.

The drawback of this way is that you need to figure out an accurate
DT binding: you might need to figure out a better name rather than
"cpu-dai" because it sounds like WM8958 may not act as a Codec at
all when it connects your BT route. That means WM8958 will become a
cpu-dai somehow? You can send a patch with a decent DT binding. I
believe Mark will give some better advice.
