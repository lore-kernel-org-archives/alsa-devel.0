From: Zidan Wang <zidan.wang@freescale.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: add wm8960 support
Date: Fri, 14 Aug 2015 15:38:16 +0800
Message-ID: <20150814073758.GB11145@shlinux2>
References: <dc4e5a52a90982cea95445e27a30f2ad6cb73513.1439349623.git.zidan.wang@freescale.com>
 <20150812034257.GA2980@Asurada-CZ80>
 <20150812044505.GA21786@shlinux2>
 <20150812064053.GA2807@Asurada-CZ80>
 <20150812073859.GB21786@shlinux2>
 <20150812222735.GA57015@Asurada-CZ80>
 <20150814022116.GA11145@shlinux2> <20150814035805.GA2180@Asurada>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0101.outbound.protection.outlook.com [157.56.110.101])
 by alsa0.perex.cz (Postfix) with ESMTP id 547542650F5
 for <alsa-devel@alsa-project.org>; Fri, 14 Aug 2015 10:49:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150814035805.GA2180@Asurada>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, tiwai@suse.com, timur@tabi.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 13, 2015 at 08:58:06PM -0700, Nicolin Chen wrote:
> On Fri, Aug 14, 2015 at 10:21:18AM +0800, Zidan Wang wrote:
> 
> > > And there is a crucial problem I can imagine:
> > >   Is it okay to set this bit while setting SD1_CLK PAD as one
> > >   of other functions rather than SAI MCLK? -- Customers might
> > >   keep your code as they also use SAI2 while using SD1_CLK PAD
> > >   as a GPIO input.
> 
> > I just add a gpr node in device tree, if customer want to use SD1_CLK
> > PAD as a GPIO input, remove the gpr node.
> 
> My question was whether setting this bit would cause a hardware
> damage -- Customers might not notice your gpr node in the Device
> Tree at all, not to mention the possibility of an accidental wrong
> configurations.
> 
> And another reason I asked that is to find out if we can set these
> bits anyway in the SoC level driver of imx6ul when this bit would
> not cause anything dangerous and when there's no extra clock MUX
> for the SAI MCLK between internal CCM and external clock source.
> 
This bit will not cause any hardware damage. 

ccm ----->1------------------>2<------------>3
	  |                   |
    	  |                   |		
	  4 SAIx MCLK1        5 SAIx MCLK2

If this bit is set, the clock route is ccm->1->2->3, 2 to 5 is disconnect.
If this bit is clear, the clock route is 3->2->5, 1 to 2 is disconnect.

Best Regards,
Zidan Wang

> Nicolin
