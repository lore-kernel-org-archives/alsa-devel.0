From: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Subject: [PATCH v8 0/1] A codec driver for the TI WL1273 FM
	Radio.
Date: Fri, 20 Aug 2010 12:32:45 +0300
Message-ID: <1282296766-21166-1-git-send-email-matti.j.aaltonen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (mgw-sa02.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id F2CEA1038D1
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 11:32:59 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, peter.ujfalusi@nokia.com
Cc: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
List-Id: alsa-devel@alsa-project.org

Hello again.

And thanks for the comments.

Comments to comments:

> > +
> > +static int wl1273_probe(struct snd_soc_codec *codec)
> > +{
> > +     struct wl1273_core **core = codec->dev->platform_data;
> 
> Just curious, why is your platform data here not just a pointer to a
> struct wl1273 ?

You mean the naming? Wl1273 could be better, but as the whole
driver consists of the mfd core and the codec and the v4l2 child drivers
it was natural for me to name the central struct as wl1273_core.

> > +     INIT_LIST_HEAD(&codec->dapm_widgets);
> > +     INIT_LIST_HEAD(&codec->dapm_paths);
> > +
> > +     codec->name = "wl1273";
> > +     codec->num_dai = 1;
> > +     codec->bias_level = SND_SOC_BIAS_OFF;
> 
> Above 6 lines now done by core, so not needed now (I mentioned that for
> V5, but maybe not explicitly)

OK, I removed those lines now...

Thanks,
Matti


Matti J. Aaltonen (1):
  ASoC: TI WL1273 FM Radio Codec.

 sound/soc/codecs/wl1273.c |  525 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wl1273.h |  101 +++++++++
 2 files changed, 626 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/wl1273.c
 create mode 100644 sound/soc/codecs/wl1273.h
