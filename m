From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: cs35l35: Add multi-device
	synchronisation
Date: Tue, 30 May 2017 09:51:38 +0100
Message-ID: <20170530085138.GR1594@localhost.localdomain>
References: <1495121559-1063-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1495121559-1063-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20170529135306.ldn74fwvfa4ots6a@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 01AD6266AA1
 for <alsa-devel@alsa-project.org>; Tue, 30 May 2017 10:50:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20170529135306.ldn74fwvfa4ots6a@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, lgirdwood@gmail.com, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, May 29, 2017 at 02:53:06PM +0100, Mark Brown wrote:
> On Thu, May 18, 2017 at 04:32:39PM +0100, Charles Keepax wrote:
> 
> > +	SOC_SINGLE_EXT("SYNC Audio", CS35L35_MULT_DEV_SYNCH2, 1, 1, 0,
> > +		       snd_soc_get_volsw, cs35l35_put_sync),
> > +	SOC_SINGLE_EXT("SYNC VPBR", CS35L35_MULT_DEV_SYNCH2, 2, 1, 0,
> > +		       snd_soc_get_volsw, cs35l35_put_sync),
> > +	SOC_SINGLE_EXT("SYNC OTW", CS35L35_MULT_DEV_SYNCH2, 3, 1, 0,
> > +		       snd_soc_get_volsw, cs35l35_put_sync),
> 
> I can't tell how this works.  It feels like this shouldn't just be being
> controlled from userspace but rather should be handled in some more
> standard fashion, or possibly as part of the platform integration but
> right now it's just some totally undocumented application managed
> controls.

These activate the individual types of synchronisation between
the two stereo amps over a proprietary single wire connection
between the two amps. The audio option synchronises the group
delay between the two amps. The VPBR links the brown out on the
two amps and the OTW links the over temperature warning.

The issue is really one of it being use-case specific whether the
amps are being used independently or in a stereo configuration.
You could have only a single amp in use in which case the sync
features are best turned off. Or one might even have use-cases
with both amps where they are being used independently but at the
same time.

I guess we could potentially do those as calls from the machine
driver, although in some cases it might be hard to tell which
use-case is being used. Alternatively, one could try to actually
link the two amps in DAPM and control it that way although you
probably still want some device tree stuff to say which things
you want to sync and it might cause issues in any cases where you
had both amps up but didn't want to sync.

Thanks,
Charles
