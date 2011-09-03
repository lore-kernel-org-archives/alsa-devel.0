From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 2/3] ASoC: soc-dapm: API to attach
 DAPM_SUPPLY to be used for dai
Date: Sat, 3 Sep 2011 07:31:19 +0100
Message-ID: <20110903063119.GB6556@sirena.org.uk>
References: <1314365603-8947-1-git-send-email-peter.ujfalusi@ti.com>
	<4740107.jCnGMjlvlq@barack>
	<20110829091603.GA9477@opensource.wolfsonmicro.com>
	<11979330.WnlDKWFkCB@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A6E924357
	for <alsa-devel@alsa-project.org>;
	Sat,  3 Sep 2011 08:31:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <11979330.WnlDKWFkCB@barack>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: P?ter Ujfalusi <peter.ujfalusi@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
	Liam" <lrg@ti.com>, "Lopez Cruz, Misael" <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 29, 2011 at 02:41:30PM +0300, P?ter Ujfalusi wrote:
> On Monday 29 August 2011 11:16:04 Mark Brown wrote:
> > That's not what you said before...  I did post the sequence I was
> > suggesting and you seemed fine with it.  Please try to be clear about
> > what you're trying to do here - previously you'd just said that you
> > needed to make sure the CODEC was powered down prior to the CPU being
> > stopped but now you're adding additional stuff here.

> Hrm, yes i did agreed with your sequence until I started to look at the other 
> implications. However at least I was consistent in the commit messages about 
> the sequence requirements (OMAP4 McPDM should be stopped after the codec's 
> DAC/ADC).

Right, but there was an important additional bit.

> > Could you please clarify what exactly the system looks like here and
> > what you need to do?  I'm struggling to understand how you've got PDM
> > output links providing clocks back into the CPU - usually a PDM output
> > is two wires going in one direction.

> The sequence I'm looking for is:
> 1. pcm_trigger: stop DMA
> 2. DAPM sequence starts
> 3. DAC is turned off on the codec side
> 4. OMAP4 McPDM can be stopped - stop it
> 5. DAPM finishes up
> 6. codec can be turned off

Actually I think this is fine with my suggestion so long as you make the
CODEC SYSCLK visible to DAPM and have the machine driver turn it off at
some later point in the shutdown process (eg, in shutdown()).  That way
the data paths will still be torn down by DAPM immediately but SYSCLK
will still be generated.
