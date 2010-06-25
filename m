From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ALSA SoC device tree bindings
Date: Fri, 25 Jun 2010 12:25:07 +0100
Message-ID: <20100625112506.GA2803@sirena.org.uk>
References: <201006232030.14138.jeremy.kerr@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 223F024380
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jun 2010 13:25:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201006232030.14138.jeremy.kerr@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jeremy Kerr <jeremy.kerr@canonical.com>
Cc: devicetree-discuss@lists.ozlabs.org, kernel-team@lists.ubuntu.com, linaro-dev@lists.linaro.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 23, 2010 at 08:30:13PM +0800, Jeremy Kerr wrote:

> From some discussions at the previous Ubuntu Developer Summit, I've put up a 
> page on the devicetree.org wiki with the ultimate goal of describing device 
> tree bindings for ALSA System on Chip devices.

Please do remember to CC maintainers on e-mails if you're looking for a
response, this is standard practice for kernel stuff due to the number
of high volume mailing lists and busy maintainers.  I've added Liam into
the CCs.

> So - if you're interested in the ALSA and/or device tree areas, please take a 
> look at the notes from UDS:

>  http://devicetree.org/SoC_Audio

A few comments:

 - There's no mention of clocking in the page, which is one of the more
   exciting bits of this stuff.  Reading the page I'm not sure that
   we've even fully captured the problem definition.

 - I'm not sure what "ALSA quirking" is?

 - "i2s" isn't the best thing to use in a property name, I2S is just one
   of several different standards for interconn

 - How does the way you're defining the audio links cope with multi-drop
   links (eg, bluetooth and cellular modem on the same bus)?
