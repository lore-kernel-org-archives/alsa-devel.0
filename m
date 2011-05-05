From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: [PATCH 01/19] ASoC: upd9976: Add Renesas uPD9976
	codec driver
Date: Thu, 5 May 2011 08:30:58 +0800
Message-ID: <20110505003058.GA8633@qtel.sh.intel.com>
References: <20110504133756.32443.6282.stgit@localhost>
	<20110504134458.32443.45825.stgit@localhost>
	<20110504143451.GA10912@opensource.wolfsonmicro.com>
	<s5hbozio66r.wl%tiwai@suse.de>
	<20110504151827.GD1671@qtel.sh.intel.com>
	<s5h62pqo4qu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 6123E10391D
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 02:32:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h62pqo4qu.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, "Wang, Xingchao" <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 04, 2011 at 11:38:33PM +0800, Takashi Iwai wrote:
> At Wed, 4 May 2011 23:18:27 +0800,
> Lu Guanqun wrote:
> > 
> > On Wed, May 04, 2011 at 11:07:24PM +0800, Takashi Iwai wrote:
> > > At Wed, 4 May 2011 15:34:51 +0100,
> > > Mark Brown wrote:
> > > > 
> > > > On Wed, May 04, 2011 at 09:44:58PM +0800, Lu Guanqun wrote:
> > > > 
> > > > > +static const struct snd_kcontrol_new upd9976_snd_controls[] = {
> > > > > +	SOC_DOUBLE_R_TLV("Headphone & Speaker Volume",
> > > > 
> > > > Master Volume would be a better name.
> > > 
> > > Yes, also in general, try to avoid special letters like "&".
> > 
> > I once used letter "/", but then it failed to create the corresponding
> > debugfs directory... :)
> 
> Yeah, "/" can be used for control names for now because they aren't
> exposed in fs, but better to avoid if possible, too.
> 
> > Oh, btw: There are another register that's related to volume control,
> > it's before DAC (not added in this patchset yet, for simplicity, will
> > add it later). so the connection looks something like this:
> > 
> > [volume gain A] --> [DAC] --> [Mixer Volume] -> [Output Pins]
> > 
> > Which volume control should be the master volume? I'm a bit unclear on
> > this one.
> 
> If it's the only output, any of them can be a "Master" volume.
> But if there are other outputs, it shouldn't be named as "Master" at
> all. 

Thanks for the info.
There are other outputs in this codec.
                            .-> [Mixer Volume for Earpiece] -> [output pins]
                           /
[volume gain A] --> [DAC] --> [Mixer Volume for HP/Spkr] -> [Output Pins]
                           \
                            `-> [Mixer Volume for LineOut] -> [LineOut Pins]

So in this case, I'll make the [volume gain A] as the master volume.

> 
> Master volume is like Highlander(*), there can be only one :)
> 
> 
> Takashi
> 
> (*) doesn't mean guys in Edinburgh

-- 
guanqun
