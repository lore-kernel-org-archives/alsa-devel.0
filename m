From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 1/3] ASoC: omap-mcbsp: buffer size
 constraint only applies to playback stream
Date: Tue, 20 Mar 2012 18:34:24 +0200
Message-ID: <4F68B190.7010009@bitmer.com>
References: <1332242021-7494-1-git-send-email-peter.ujfalusi@ti.com>
	<1332242021-7494-2-git-send-email-peter.ujfalusi@ti.com>
	<20120320152649.GC3445@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
	by alsa0.perex.cz (Postfix) with ESMTP id C00DF104323
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 17:34:33 +0100 (CET)
In-Reply-To: <20120320152649.GC3445@opensource.wolfsonmicro.com>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/20/2012 05:26 PM, Mark Brown wrote:
> On Tue, Mar 20, 2012 at 01:13:39PM +0200, Peter Ujfalusi wrote:
>> In capture stream the buffer size does not need to be constrained to be
>> bigger then the McBSP FIFO.
>> In capture the FIFO content is taken out in period length burst, this
>> enusres that the FIFO is not going to overflow.
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.comm>

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
