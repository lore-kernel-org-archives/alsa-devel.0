From: Oder Chiou <oder_chiou@realtek.com>
Subject: Re: [PATCH v3] ASoC: rt5514: add rt5514 SPI driver
Date: Tue, 17 May 2016 02:33:16 +0000
Message-ID: <7EB0DE829A537248AF2ED30C97D12694FDDF5C@RTITMBSV03.realtek.com.tw>
References: <1462789855-23485-1-git-send-email-oder_chiou@realtek.com>
 <20160513121932.GN22038@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id D6FBF264F74
 for <alsa-devel@alsa-project.org>; Tue, 17 May 2016 04:33:23 +0200 (CEST)
In-Reply-To: <20160513121932.GN22038@sirena.org.uk>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> > +static void rt5514_spi_copy_work(struct work_struct *work)
> > +{
> > +	struct rt5514_dsp *rt5514_dsp =
> > +		container_of(work, struct rt5514_dsp, copy_work.work);
> > +	struct snd_pcm_runtime *runtime = rt5514_dsp->substream->runtime;
> > +	size_t period_bytes, truncated_bytes = 0;
> 
> I can't see anything that cancels this work when the PCM stream to
> userspace is stopped or if things power off otherwise?
> 
In the beginning of the function "rt5514_spi_copy_work", there is a if
condition to check the variable "rt5514_dsp->substream", and the function
"rt5514_spi_hw_free" will set the variable "rt5514_dsp->substream" to NULL.
It also will make the delayed work stop and won't schedule again.
