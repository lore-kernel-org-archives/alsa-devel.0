From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH 01/19] ASoC: upd9976: Add Renesas uPD9976
	codec driver
Date: Thu, 05 May 2011 08:44:19 +0530
Message-ID: <1304565259.20953.33.camel@vkoul-udesk3>
References: <20110504133756.32443.6282.stgit@localhost>
	<20110504134458.32443.45825.stgit@localhost>
	<20110504143451.GA10912@opensource.wolfsonmicro.com>
	<20110504150516.GB1671@qtel.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 15930243BE
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 05:46:47 +0200 (CEST)
In-Reply-To: <20110504150516.GB1671@qtel.sh.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Lu, Guanqun" <guanqun.lu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, "Wang, Xingchao" <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-05-04 at 20:35 +0530, Lu, Guanqun wrote:
> On Wed, May 04, 2011 at 10:34:51PM +0800, Mark Brown wrote:
> > On Wed, May 04, 2011 at 09:44:58PM +0800, Lu Guanqun wrote:
> > 
> > Overall this looks very good, a few minor points below.
> > 
> > > +static inline unsigned int upd9976_read(struct snd_soc_codec *codec,
> > > +					unsigned int reg)
> > > +{
> > 
> > I guess these SCU write functions are going to be shared with other
> > CODECs for this CPU - we should probably push this into the soc-cache
> > for them.
> 
> Yes, currently it's the same read/write operation as in sn95031 codec.
I would not do that yet, as I don't see any more codecs using this
interface today or in near future :)


-- 
~Vinod
