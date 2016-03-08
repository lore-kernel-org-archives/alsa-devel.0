From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v5 6/9] ASoC: hdmi-codec: Use HDMI
 notifications to add jack support
Date: Tue, 08 Mar 2016 09:31:04 +0100
Message-ID: <1457425864.4174.20.camel@pengutronix.de>
References: <1456930153-11853-1-git-send-email-p.zabel@pengutronix.de>
 <1456930153-11853-7-git-send-email-p.zabel@pengutronix.de>
 <56DE0124.6080208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.4.pengutronix.de (metis.ext.4.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id B4F7B2605C6
 for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2016 09:31:12 +0100 (CET)
In-Reply-To: <56DE0124.6080208@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Koro Chen <koro.chen@mediatek.com>, Daniel Kurtz <djkurtz@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org, kernel@pengutronix.de, Matthias Brugger <matthias.bgg@gmail.com>, Cawa Cheng <cawa.cheng@mediatek.com>
List-Id: alsa-devel@alsa-project.org

Hi Jyri,

Am Dienstag, den 08.03.2016, 00:31 +0200 schrieb Jyri Sarha:
> I don't think this patch was updated according to updated "video: rmk's 
> HDMI notification prototype":
> 
> On 03/02/16 16:49, Philipp Zabel wrote:
> > Use HDMI connection / disconnection notifications to update an ALSA
> > jack object. Also make a copy of the ELD block after every change.
> >
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > ---
> >   include/sound/hdmi-codec.h    |  6 +++
> >   sound/soc/codecs/hdmi-codec.c | 85 +++++++++++++++++++++++++++++++++++++++----
> >   2 files changed, 83 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/sound/hdmi-codec.h b/include/sound/hdmi-codec.h
> > index 15fe70f..8b6219d 100644
> > --- a/include/sound/hdmi-codec.h
> > +++ b/include/sound/hdmi-codec.h
> > @@ -99,6 +99,12 @@ struct hdmi_codec_pdata {
> >   	int max_i2s_channels;
> >   };
> >
> > +struct snd_soc_codec;
> > +struct snd_soc_jack;
> > +
> > +int hdmi_codec_set_jack_detect(struct snd_soc_codec *codec,
> > +			       struct snd_soc_jack *jack);
> > +
> >   #define HDMI_CODEC_DRV_NAME "hdmi-audio-codec"
> >
> >   #endif /* __HDMI_CODEC_H__ */
> > diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
> > index 687332d..7d5db11 100644
> > --- a/sound/soc/codecs/hdmi-codec.c
> > +++ b/sound/soc/codecs/hdmi-codec.c
> > @@ -12,9 +12,12 @@
> >    * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the GNU
> >    * General Public License for more details.
> >    */
> > +#include <linux/hdmi-not.h>
> 
> This should be hdmi-notifier.h. "select HDMI_NOTIFIERS" also needs to be 
> added to SND_SOC_HDMI_CODEC config option for compilation to succeed.

Yes, thank you for pointing that out. Will be fixed in v6.

regards
Philipp
