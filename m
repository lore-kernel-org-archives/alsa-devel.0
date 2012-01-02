From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [PATCH v8 3/3 RESEND] ASoC: da7210: Add support
 for line input and mic
Date: Mon, 2 Jan 2012 17:46:09 +0530
Message-ID: <1325506569.12508.15.camel@matrix>
References: <1325505952.12508.12.camel@matrix>
	<20120102120024.GH2899@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE007.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) by alsa0.perex.cz (Postfix) with ESMTP id EF101244B1
	for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2012 13:04:28 +0100 (CET)
In-Reply-To: <20120102120024.GH2899@opensource.wolfsonmicro.com>
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
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, lrg <lrg@ti.com>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2012-01-02 at 12:00 +0000, Mark Brown wrote:
> On Mon, Jan 02, 2012 at 05:35:52PM +0530, Ashish Chavan wrote:
> > DA7210 has three line inputs (AUX1 Left, AUX1 Right and AUX2) and
> > a stereo MIC. This patch adds gain controls for MIC, AUX1, AUX2 as
> > well as INPGA.
> 
> Where are patches 1 and 2?

They are already merged.

Here is short summary of those patches,

Patch#1 ASoC: da7210: Add support for DAPM
Patch#2 ASoC: da7210: Add support for line out and DAC
