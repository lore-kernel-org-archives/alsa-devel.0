From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: snd_soc_dapm_force_enable_pin question
Date: Fri, 25 Mar 2011 12:56:13 +0000
Message-ID: <20110325125612.GD22502@sirena.org.uk>
References: <1301049930.1695.11.camel@vkoul-udesk3>
	<20110325114050.GC31415@opensource.wolfsonmicro.com>
	<1301055607.1695.16.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C7D43103810
	for <alsa-devel@alsa-project.org>; Fri, 25 Mar 2011 13:56:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1301055607.1695.16.camel@vkoul-udesk3>
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
Cc: alsa <alsa-devel@alsa-project.org>, Liam <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 25, 2011 at 05:50:07PM +0530, Koul, Vinod wrote:
> On Fri, 2011-03-25 at 17:10 +0530, Mark Brown wrote:

> > Your above scenario sounds like you're just doing a regular playback of
> > some kind - if that is the case I'd expect things to power up when you
> > start playing through the DAC.

> No, its Vibra PWM controller no playback here

So the DAC gets its input from some internal source?  In that case that
source maps very directly onto the input widget.
