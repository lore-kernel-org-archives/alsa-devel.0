From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: [PATCH 01/19] ASoC: upd9976: Add Renesas uPD9976
	codec driver
Date: Fri, 6 May 2011 00:26:25 +0800
Message-ID: <20110505162625.GD28594@qtel.sh.intel.com>
References: <20110504133756.32443.6282.stgit@localhost>
	<20110504134458.32443.45825.stgit@localhost>
	<20110504143451.GA10912@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 18D70103A0A
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 18:27:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110504143451.GA10912@opensource.wolfsonmicro.com>
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

On Wed, May 04, 2011 at 10:34:51PM +0800, Mark Brown wrote:
> > +static struct snd_soc_dai_driver upd9976_dais[] = {
> > +{
> > +	.name = "upd9976-audio",
> > +	.playback = {
> 
> Just drop the audio from the name, it's a CODEC so it's obviously audio.

Giving it a second look, I recall why I added this "-audio", because
there is another interface on the codec driver called "voice port", so
in the future, I would expect to add a new dai driver called
"upd9976-voice". So that's the differentiation. :)

I'm finished with all the changes according to you guys' comments.
After I do a thorough test, I'll resend this patchset. Thanks.

-- 
guanqun
