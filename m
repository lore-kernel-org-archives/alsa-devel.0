From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: snd_soc_dapm_force_enable_pin question
Date: Fri, 25 Mar 2011 11:40:50 +0000
Message-ID: <20110325114050.GC31415@opensource.wolfsonmicro.com>
References: <1301049930.1695.11.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DEE3F2451F
	for <alsa-devel@alsa-project.org>; Fri, 25 Mar 2011 12:40:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1301049930.1695.11.camel@vkoul-udesk3>
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

On Fri, Mar 25, 2011 at 04:15:30PM +0530, Koul, Vinod wrote:

> I have a Vibra controller on the codec which can be programmed using
> alsa controls. Now after configuration I added an enable control which
> when turned On, forces the Vibra Pin to be ON. The Pin is on, but not
> the path, I need the DAC and amplifier connected to be ON as well?

> Is this not what the force_enable_pin() is supposed to do?

No, it's there to force a pin to be on when there's no audio path - the
main use is for microphone biases, to ensure they're enabled in order to
allow jack detection to work.  The purpose is to ignore routing so it
won't affect any other widgets.

> If not how should I ensure this path and codec BIAS is on when Vibra is
> activated by user?

Your above scenario sounds like you're just doing a regular playback of
some kind - if that is the case I'd expect things to power up when you
start playing through the DAC.

Otherwise I'd suggest creating an input widget, connecting it as an
input to the DAC and then using regular enable_pin() to enable that and
the output.
