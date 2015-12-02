From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Replace siggen widget type
 with mic widgets
Date: Wed, 2 Dec 2015 09:15:00 +0000
Message-ID: <20151202091500.GA6058@localhost.localdomain>
References: <1448991128-22784-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <565DED87.1030600@metafoo.de> <20151201193613.GP1929@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 7602B261AE4
 for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2015 10:15:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20151201193613.GP1929@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 01, 2015 at 07:36:13PM +0000, Mark Brown wrote:
> On Tue, Dec 01, 2015 at 07:57:11PM +0100, Lars-Peter Clausen wrote:
> > On 12/01/2015 06:32 PM, Charles Keepax wrote:
> 
> > > The siggen widget type doesn't really require its own special handling.
> > > It can be handled identically to a mic widget, ie. it is a source of a
> > > signal and causes things to power up when an output is connected.
> 
> > > However, as siggen widgets present as always on (the power check always
> > > returns 1), this leads to some odd interactions with DAPM.
> 
> > Sounds sensible, but I'd keep the siggen type and just change the
> > power_check callback. snd_soc_dapm_mic widgets are a bit special in that
> > they also influence how input and output widgets behave, we don't want the
> > same behavior for siggen widgets, since siggen widgets are internal to CODEC
> > while mic widgets are usually external.
> 
> Yeah, the siggen widgets were created because mics are funky - best to
> just fix the bug.

Thanks guys, will respin today.

Thanks,
Charles
