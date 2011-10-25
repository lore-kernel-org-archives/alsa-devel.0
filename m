From: "Ashish P. Chavan" <Ashish.Chavan@kpitcummins.com>
Subject: Re: [PATCH v8 3/3] ASoC: da7210: Add support for line
 input and mic
Date: Tue, 25 Oct 2011 03:59:35 +0000
Message-ID: <E3DB41DBD579A349B4BC7C95EADB061620445548@KCHJEXMB02.kpit.com>
References: <1319204398.24621.274.camel@matrix>,
	<20111022093836.GD3316@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
	by alsa0.perex.cz (Postfix) with ESMTP id CA23F2452A
	for <alsa-devel@alsa-project.org>;
	Tue, 25 Oct 2011 05:59:48 +0200 (CEST)
In-Reply-To: <20111022093836.GD3316@opensource.wolfsonmicro.com>
Content-Language: en-US
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

> DA7210 has three line inputs (AUX1 Left, AUX1 Right and AUX2) and
> a stereo MIC. This patch adds gain controls for MIC, AUX1, AUX2 as
> well as INPGA. It also adds a control to set  MIC BIAS voltage.
>
> Applied, though the last comment is inaccurate (the micbias should
> be managed by kernel code, you removed the control in an earlier 
> revision).

Yes, my mistake!

Is it possible for you to correct it? Or should I send a new patch
with correct commit message?
