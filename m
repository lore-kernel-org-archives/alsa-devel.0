From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Question about SND_SOC_DAIFMT_xB_xF
Date: Thu, 31 Jul 2014 09:42:01 +0200
Message-ID: <53D9F349.8030903@metafoo.de>
References: <87oaw6uw0r.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-031.synserver.de (smtp-out-033.synserver.de
 [212.40.185.33])
 by alsa0.perex.cz (Postfix) with ESMTP id E34C5261AFC
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 09:42:04 +0200 (CEST)
In-Reply-To: <87oaw6uw0r.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

On 07/31/2014 04:01 AM, Kuninori Morimoto wrote:
> r example, if some data format requests that data is sent from "rising edge",
> but HW send data from "falling edge" in default setting.
> This case, HW should use inverted edge.
> Then, should HW send it by SND_SOC_DAIFMT_NB_NF (= based on required format) ?
> or SND_SOC_DAIFMT_NB_IF (= based on default HW behavior) ?

The same set of settings passed to snd_soc_dai_set_fmt() must for all 
drivers result in the same waveforms. Otherwise interoperability is pretty 
hard to archive. This means the clock invert settings are always be relative 
to the selected DAI format (I2S, LJ, RJ, ...). The hardware default of the 
specific IP that the driver was written for does not matter in this case.
