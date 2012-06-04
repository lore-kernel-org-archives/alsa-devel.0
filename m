From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH v2] ASoC: Support TI Isabelle Audio driver
Date: Mon, 04 Jun 2012 11:49:16 +0100
Message-ID: <1338806956.15595.3.camel@odin>
References: <1338569514-18106-1-git-send-email-MR.Swami.Reddy@ti.com>
	<20120604103519.GE7538@opensource.wolfsonmicro.com>
	<4FCC9280.2090706@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog119.obsmtp.com (na3sys009aog119.obsmtp.com
	[74.125.149.246])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B0A92490F
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jun 2012 12:49:22 +0200 (CEST)
Received: by weyu7 with SMTP id u7so3429406wey.33
	for <alsa-devel@alsa-project.org>; Mon, 04 Jun 2012 03:49:18 -0700 (PDT)
In-Reply-To: <4FCC9280.2090706@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: MR Swami Reddy <MR.Swami.Reddy@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Deshpande A,
	Vishwas" <Vishwas.A.Deshpande@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Swami,

On Mon, 2012-06-04 at 16:18 +0530, MR Swami Reddy wrote:
> On Monday 04 June 2012 04:05 PM, Mark Brown wrote:
> > On Fri, Jun 01, 2012 at 10:21:54PM +0530, MR.Swami.Reddy@ti.com wrote:
> >
> >>    o Used dev_get_regmap and devm_regmap_init_i2c APIs.
> > This looks mostly good so I've applied it but please send an incremental
> > patch to remove the use of regmap_exit() - the major point of devm_ APIs
> > is that you don't need to explicitly clean things up, removing a class
> > of potential leaks.
> 
> Thank you.
> I will remove the regmap_exit() and send the next patch soon.
> Plz confirm, do I need to send full patch or only removing part for
> regmap_exit()?
> 

Please send an incremental patch. An incremental patch not be the full
driver patch, but will just be the changes for regmap_exit().

Regards

Liam
