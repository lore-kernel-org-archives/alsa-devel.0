From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH] ASoC: fsl_ssi: Remove unneeded 'i2s-slave'
	property
Date: Fri, 19 Sep 2014 18:49:18 -0500
Message-ID: <541CC0FE.7050600@tabi.org>
References: <1411063877-1552-1-git-send-email-fabio.estevam@freescale.com>
 <20140918183251.GE6432@Asurada> <541B2678.8000401@tabi.org>
 <1411065995187.3341@freescale.com> <20140918194342.GA3173@Alpha>
 <541B78EC.5050702@tabi.org> <20140919041749.GA5840@Asurada>
 <541C26E2.4060605@tabi.org> <20140919172438.GA1736@Asurada>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BB4D26535F
 for <alsa-devel@alsa-project.org>; Sat, 20 Sep 2014 01:49:22 +0200 (CEST)
In-Reply-To: <20140919172438.GA1736@Asurada>
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
Cc: "Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Nicolin Chen wrote:
> I thought only the backward compatibility for DT is demanded.....

I have higher standards :-)

> But I still don't get why people would use new DT without updating
> kernel. It's pretty fair to use old DT with newer kernel because
> they want bug-fix patches.

The device tree is shipped with the kernel, so some people say that 
backwards compatibility is not needed anywhere.  I think it's important 
to provide backwards compatibility both ways.

I generally prefer some kind of transition period, where you can use new 
or old kernel with a new or old device tree.

However, let me look at Fabio's patches some more.
