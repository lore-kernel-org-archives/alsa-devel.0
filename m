From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v8 3/3] ASoC: da7210: Add support for line
 input and mic
Date: Sat, 22 Oct 2011 10:38:36 +0100
Message-ID: <20111022093836.GD3316@opensource.wolfsonmicro.com>
References: <1319204398.24621.274.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 32D122459D
	for <alsa-devel@alsa-project.org>;
	Sat, 22 Oct 2011 11:38:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1319204398.24621.274.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, lrg <lrg@ti.com>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 21, 2011 at 07:09:58PM +0530, Ashish Chavan wrote:
> DA7210 has three line inputs (AUX1 Left, AUX1 Right and AUX2) and
> a stereo MIC. This patch adds gain controls for MIC, AUX1, AUX2 as
> well as INPGA. It also adds a control to set  MIC BIAS voltage.

Applied, though the last comment is inaccurate (the micbias should be
managed by kernel code, you removed the control in an earlier revision).
