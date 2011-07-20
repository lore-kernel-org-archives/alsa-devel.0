From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/2] ASoC: davinci: fix codec start and
	stop functions
Date: Wed, 20 Jul 2011 20:52:03 +0100
Message-ID: <20110720195203.GB26043@opensource.wolfsonmicro.com>
References: <1311163564-24526-1-git-send-email-sudhakar.raj@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 04C2F1038FA
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jul 2011 21:52:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1311163564-24526-1-git-send-email-sudhakar.raj@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 20, 2011 at 05:36:04PM +0530, Rajashekhara, Sudhakar wrote:
> According to DM365 voice codec data sheet at [1], before starting
> recording or playback, ADC/DAC modules should follow a reset and
> enable cycle. Writing a 1 to the ADC/DAC bit in the register resets
> the module and clearing the bit to 0 will enable the module. But the
> driver seems to be doing the reverse of it.

Applied, thanks.
