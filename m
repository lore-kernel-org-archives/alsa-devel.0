From: Andrew Lunn <andrew@lunn.ch>
Subject: Using simple-card to replace kirkwood-t5325.c
Date: Tue, 15 Apr 2014 18:13:02 +0200
Message-ID: <20140415161302.GC1871@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps0.lunn.ch (vps0.lunn.ch [178.209.37.122])
 by alsa0.perex.cz (Postfix) with ESMTP id CD91D264FFF
 for <alsa-devel@alsa-project.org>; Tue, 15 Apr 2014 18:15:14 +0200 (CEST)
Received: from lunn by vps0.lunn.ch with local (Exim 4.80)
 (envelope-from <andrew@lunn.ch>) id 1Wa5yo-0000xP-K6
 for alsa-devel@alsa-project.org; Tue, 15 Apr 2014 18:13:02 +0200
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Folks

I'm an ALSA newbie, so if i say anything stupid, please let me know.

I'm trying to replace sound/soc/kirkwood/kirkwood-t5325.c with DT,
using simple-card. I can get near, but i'm missing two things:

There does not appear to be a way to represent this in DT:

static int t5325_dai_init(struct snd_soc_pcm_runtime *rtd)
{
	struct snd_soc_codec *codec = rtd->codec;
	struct snd_soc_dapm_context *dapm = &codec->dapm;

	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
	snd_soc_dapm_enable_pin(dapm, "Speaker");

	return 0;
}

It appears that quite a few drivers need to enable pins. It also seems
common to disable pins and to set them to NC. Is this a generic enough
feature it could be added to the DT binding?

The second thing i need is:

static int t5325_hw_params(struct snd_pcm_substream *substream,
       	   struct snd_pcm_hw_params *params)
{
	struct snd_soc_pcm_runtime *rtd = substream->private_data;
	struct snd_soc_dai *codec_dai = rtd->codec_dai;
	unsigned int freq;

	freq = params_rate(params) * 256;

	return snd_soc_dai_set_sysclk(codec_dai, 0, freq, SND_SOC_CLOCK_IN);

}

static struct snd_soc_ops t5325_ops = {
       .hw_params = t5325_hw_params,
};


This seems a lot less common requirements. All the Marvell SoCs need
it, but not many others. So i don't think it makes sense to add it
directly to simple-card, otherwise simple-card quickly becomes
complex-card as everybody else wants there quirks adding.

Has there been any thoughts about turning simple-card.c into a
library, or adding hooks so that a driver can modify the created
dai_link structures to add in ops like this?

	 Thanks
		Andrew
