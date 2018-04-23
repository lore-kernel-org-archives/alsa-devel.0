From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH] ASoC: codecs: msm8916-wcd: use threaded
	IRQ handlers
Date: Mon, 23 Apr 2018 16:54:22 +0200
Message-ID: <4ec0b0ff-f5f3-298d-8aa6-d4c16aee68e6@zonque.org>
References: <20180420120750.356-1-daniel@zonque.org>
 <20180423144901.GE19834@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 79BC8266CA1
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 16:54:23 +0200 (CEST)
In-Reply-To: <20180423144901.GE19834@sirena.org.uk>
Content-Language: en-US
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
Cc: linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, srinivas.kandagatla@linaro.org
List-Id: alsa-devel@alsa-project.org

On Monday, April 23, 2018 04:49 PM, Mark Brown wrote:
> On Fri, Apr 20, 2018 at 02:07:50PM +0200, Daniel Mack wrote:
>> The handler for the mbhc switch irq calls into snd_soc_jack_report() which
>> in turn triggers a notifier chain that is blocking, which means it allows
>> its callbacks to sleep. This leads to a "scheduling while atomic" Ooops
>> when the jack notifier callback uses snd_soc_dapm_sync(), for instance.
> 
> Someone already submitted a fix for this which is in -next already?

Ah, missed that. Nice, it's the exact same fix :)


Sorry for the noise,
Daniel
