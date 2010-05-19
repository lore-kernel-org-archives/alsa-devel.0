From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC: tpa6130a2: Define output pins with
 SND_SOC_DAPM_OUTPUT
Date: Wed, 19 May 2010 16:46:17 +0300
Message-ID: <20100519164617.181ad760.jhnikula@gmail.com>
References: <1274266526-29439-1-git-send-email-jhnikula@gmail.com>
	<201005191500.14607.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f217.google.com (mail-ew0-f217.google.com
	[209.85.219.217])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E8171038FA
	for <alsa-devel@alsa-project.org>;
	Wed, 19 May 2010 15:46:17 +0200 (CEST)
Received: by ewy9 with SMTP id 9so2214310ewy.4
	for <alsa-devel@alsa-project.org>; Wed, 19 May 2010 06:46:16 -0700 (PDT)
In-Reply-To: <201005191500.14607.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, 19 May 2010 15:00:14 +0300
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> On Wednesday 19 May 2010 13:55:26 ext Jarkko Nikula wrote:
> > Codec output pin should be defined with SND_SOC_DAPM_OUTPUT as otherwise
> > external widgets doesn't alter the output state.
> > 
> > Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> > Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> > ---
> > I noticed this with a widget and audio map below where state of
> > "Headphone Jack" wasn't changing the codec output.
> 
> This is intentional.
> TPA is _not_ a codec, it is amplifier.
> 
> > SND_SOC_DAPM_HP("Headphone Jack", NULL),
> > 
> > {"Headphone Jack", NULL, "TPA6130A2 Headphone Left"},
> > {"Headphone Jack", NULL, "TPA6130A2 Headphone Right"},
> > {"TPA6130A2 Left", NULL, "LLOUT"},
> > {"TPA6130A2 Right", NULL, "RLOUT"}
> 
> And this is how you should use it in a machine driver:
> Connect the codec's outputs to TPA. The TPA code adds the HPs for you already, 
> so you don't need to care about it...
> 
>  {"TPA6130A2 Left", NULL, "LLOUT"},
>  {"TPA6130A2 Right", NULL, "RLOUT"}
> 
> If you want to turn off the headset path, which I suppose you want to do here, 
> than within the same kcontrol you will have for HS mute you can do this:
> 
> 	if (jack_state) {
> 		snd_soc_dapm_enable_pin(codec, "TPA6130A2 Headphone Left");
> 		snd_soc_dapm_enable_pin(codec, "TPA6130A2 Headphone Right");
> 	} else {
> 		snd_soc_dapm_disable_pin(codec, "TPA6130A2 Headphone Left");
> 		snd_soc_dapm_disable_pin(codec, "TPA6130A2 Headphone Right");
> 	}
> 
Thanks for update, this also works, I was unclear are there bug or not
so wanted to try with a patch first :-)


-- 
Jarkko
