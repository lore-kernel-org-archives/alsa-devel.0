From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: [PATCH 01/19] ASoC: upd9976: Add Renesas uPD9976
	codec driver
Date: Thu, 5 May 2011 11:51:30 +0800
Message-ID: <20110505035130.GE10907@qtel.sh.intel.com>
References: <20110504133756.32443.6282.stgit@localhost>
	<20110504134458.32443.45825.stgit@localhost>
	<20110504143451.GA10912@opensource.wolfsonmicro.com>
	<20110504150516.GB1671@qtel.sh.intel.com>
	<1304565259.20953.33.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id D3766243D8
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 05:52:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1304565259.20953.33.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, "Wang, Xingchao" <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 05, 2011 at 11:14:19AM +0800, Koul, Vinod wrote:
> On Wed, 2011-05-04 at 20:35 +0530, Lu, Guanqun wrote:
> > On Wed, May 04, 2011 at 10:34:51PM +0800, Mark Brown wrote:
> > > On Wed, May 04, 2011 at 09:44:58PM +0800, Lu Guanqun wrote:
> > > 
> > > Overall this looks very good, a few minor points below.
> > > 
> > > > +static inline unsigned int upd9976_read(struct snd_soc_codec *codec,
> > > > +					unsigned int reg)
> > > > +{
> > > 
> > > I guess these SCU write functions are going to be shared with other
> > > CODECs for this CPU - we should probably push this into the soc-cache
> > > for them.
> > 
> > Yes, currently it's the same read/write operation as in sn95031 codec.
> I would not do that yet, as I don't see any more codecs using this
> interface today or in near future :)

In this series of patches, I'll not refactor them out and turn them into
some common code.  We can do it later when it's necessary.

-- 
guanqun
