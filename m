From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: RT5640 jack detection
Date: Wed, 23 Sep 2015 17:22:38 +0100
Message-ID: <1443025358.6977.71.camel@loki>
References: <CAL9uMOHM3tbdKT7s4panz8zyYxu35F38GLUtu9DSmgrQr=Ciqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BAF8260423
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2015 18:22:46 +0200 (CEST)
In-Reply-To: <CAL9uMOHM3tbdKT7s4panz8zyYxu35F38GLUtu9DSmgrQr=Ciqg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, =?ISO-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@endlessm.com>, Daniel Drake <drake@endlessm.com>
List-Id: alsa-devel@alsa-project.org

+ Realtek

On Tue, 2015-09-22 at 11:18 +0200, Carlo Caione wrote:
> Hi,
> I'm working with the ALC5640-VB audio codec based on the Realtek
> RT5640. On my setup the codec is only used for audio output through an
> headphone jack, otherwise the audio should be routed via HDMI.
> 
> The problem is that the jack sensing only works when the codec is
> actively playing something, that is when the bias set for the codec is
> not SND_SOC_BIAS_OFF. When the codec is suspended and it is powered
> off I'm not able to detect anymore the presence of the jack. Because
> of this issue actively switching the audio from HDMI to HP when the
> jack is inserted is not working.
> 
> The driver I'm using for the RT5640 in the .set_bias_level hook
> function among other things is gating the I2S input clock and this
> seems to prevent the generation of the IRQ signal I'm using to detect
> the presence/absence of the jack (the culprit here is MX-FA[0] bit for
> those interested).
> 
> I can easily modify the codec driver to avoid gating the I2S clock
> when the bias is off but this seems in contrast with the whole DAPM
> principle.
> 
> How this is usually supposed to be working?
> 

In situations like this it may be best to report jack status as removed
when no BIAS is available for jack detection (since no one is using the
codec anyway). The jack status could always be re-detected when BIAS is
re-enabled.

Liam 
