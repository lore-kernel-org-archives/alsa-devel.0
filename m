From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 4/9] ASoC: da7210: Add support for mute
 and zero cross controls
Date: Thu, 13 Oct 2011 17:32:09 +0100
Message-ID: <20111013163208.GL5193@opensource.wolfsonmicro.com>
References: <1318515113.12107.481.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4FD9E10382A
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Oct 2011 18:32:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1318515113.12107.481.camel@matrix>
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

On Thu, Oct 13, 2011 at 07:41:53PM +0530, Ashish Chavan wrote:

> +	SOC_SINGLE("DAC Mute Switch", DA7210_DAC_HPF, 2, 1, 0),

Digital Playback Switch so it matches up with the corresponding Volume
control, though I rather expect that this should in fact be controlled
by the digital_mute() callback for the DAI rather than a control.

Anything called "Foo Mute Switch" is probably doing something wrong as a
switch is already an on/off control.
