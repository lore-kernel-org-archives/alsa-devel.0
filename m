From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH v2 1/2] ASoC: davinci: fix codec start and
	stop functions
Date: Wed, 20 Jul 2011 17:25:26 +0100
Message-ID: <4E270176.5070904@ti.com>
References: <1311163564-24526-1-git-send-email-sudhakar.raj@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 6300C24577
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jul 2011 18:25:32 +0200 (CEST)
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>
List-Id: alsa-devel@alsa-project.org

On 20/07/11 13:06, Rajashekhara, Sudhakar wrote:
> According to DM365 voice codec data sheet at [1], before starting
> recording or playback, ADC/DAC modules should follow a reset and
> enable cycle. Writing a 1 to the ADC/DAC bit in the register resets
> the module and clearing the bit to 0 will enable the module. But the
> driver seems to be doing the reverse of it.
> 
> [1] http://focus.ti.com/lit/ug/sprufi9b/sprufi9b.pdf
> 
> Signed-off-by: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>
> ---

Both

Acked-by: Liam Girdwood <lrg@ti.com>
