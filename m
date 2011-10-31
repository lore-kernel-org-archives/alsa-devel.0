From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [PATCH v8 3/3] ASoC: da7210: Add support for line
 input and mic
Date: Mon, 31 Oct 2011 14:55:39 +0530
Message-ID: <1320053139.4064.8.camel@matrix>
References: <1319204398.24621.274.camel@matrix>
	<20111022093836.GD3316@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 96BA5103807
	for <alsa-devel@alsa-project.org>; Mon, 31 Oct 2011 10:15:00 +0100 (CET)
In-Reply-To: <20111022093836.GD3316@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, linux-kernel <linux-kernel@vger.kernel.org>, David@alsa-project.org, Chen <david.chen@diasemi.com>, lrg <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sat, 2011-10-22 at 10:38 +0100, Mark Brown wrote:
> On Fri, Oct 21, 2011 at 07:09:58PM +0530, Ashish Chavan wrote:
> > DA7210 has three line inputs (AUX1 Left, AUX1 Right and AUX2) and
> > a stereo MIC. This patch adds gain controls for MIC, AUX1, AUX2 as
> > well as INPGA. It also adds a control to set  MIC BIAS voltage.
> 
> Applied, though the last comment is inaccurate (the micbias should be
> managed by kernel code, you removed the control in an earlier revision).
> 

Is this really applied? I am looking at both for-3.2 and for-3.3
branches of linux-2.6-asoc.git and can only see commits till previous
one (i.e. ASoC: da7210: Add support for line out and DAC). I couldn't
find commit corresponding to this patch!

Is there any other place to look for?


Thanks,

-- Ashish (GNU Fan)
