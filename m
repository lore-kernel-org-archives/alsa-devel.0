From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: [PATCH 11/19] ASoC: upd9976: add jack detection
	function
Date: Thu, 5 May 2011 08:37:39 +0800
Message-ID: <20110505003739.GD8633@qtel.sh.intel.com>
References: <20110504133756.32443.6282.stgit@localhost>
	<20110504134550.32443.87977.stgit@localhost>
	<20110504163231.GI10912@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id BA54010391D
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 02:38:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110504163231.GI10912@opensource.wolfsonmicro.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, "Koul, Vinod" <vinod.koul@intel.com>, ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, "Wang, Xingchao" <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 05, 2011 at 12:32:31AM +0800, Mark Brown wrote:
> On Wed, May 04, 2011 at 09:45:50PM +0800, Lu Guanqun wrote:
> 
> > +void upd9976_jack_detection(struct snd_soc_jack *jack, u8 interrupt_status)
> > +{
> > +	int status = 0;
> > +	unsigned int value = 0;
> > +	struct snd_soc_codec *codec = jack->codec;
> > +	int mask = SND_JACK_BTN_0 | SND_JACK_BTN_1 | SND_JACK_HEADSET;
> > +
> > +	if (interrupt_status & 0x3)
> > +		value = snd_soc_read(codec, UPD9976_SAUXINT);
> 
> > +EXPORT_SYMBOL_GPL(upd9976_jack_detection);
> > +
> 
> I'd expect that the driver would also manage the work to do with
> handling the interrupt as well.

Yes, I see some wm* codec driver handles the interrupt directly in
CODEC. I'm not sure whether it's better handled in codec driver or
machine driver. Now it's confirmed by you, I'll change it
correspondingly.

-- 
guanqun
